class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates :email, :first_name, :last_name, :organization_id, presence: true
  validates :email, format: { with: /([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z\_\-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}/ }
  validates :password, on: :create, length: { minimum: 6, maximum: 128 }
  validates :secondary_email, format: { with: /([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z\_\-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}/ }, allow_blank: true
  validates :phone, format: { with: /\([\d]{2}\)\s[\d]{8,9}/ }, allow_blank: true
  validates :website, format: { with: /(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?/ }, allow_blank: true
  validates :auth_token, uniqueness: true

  has_many :memberships, inverse_of: :user
  has_many :organizations, through: :memberships
  belongs_to :organization

  accepts_nested_attributes_for :memberships

  mount_uploader :avatar, AvatarUploader

  bitmask :availability, as: AVAILABILITY_OPTIONS
  bitmask :topics, as: TOPIC_OPTIONS

  before_validation :set_auth_token
  before_validation :process_website
  after_create :create_first_membership
  after_create { self.delay.import_image_from_gravatar }
  after_save { self.delay.update_location_and_mailchimp }

  def update_location_and_mailchimp
    self.update_location
    self.update_mailchimp_subscription
  end

  def update_location
    self.fetch_address if self.postal_code.present?
    self.locate_ip if self.ip.present? and self.postal_code.blank?
  end

  def update_mailchimp_subscription
    self.organizations.each do |organization|
      begin
        subscription = Gibbon::API.lists.subscribe(
          id: organization.mailchimp_list_id,
          email: { email: self.email },
          merge_vars: {
            FNAME: self.first_name,
            LNAME: self.last_name,
            # TODO: remove 'try' when the organization_id became required
            ORG: self.organization.try(:name),
            CITY: self.city,
            PHONE: self.phone,
            LOGINLINK: self.login_url,
            DISTRICT: self.address_district,
            groupings: [
              { name: 'Skills', groups: self.translated_skills },
              { name: 'Organizations', groups: self.organization_names }
            ]
          },
          double_optin: false,
          update_existing: true,
          replace_interests: true
        )

        self.update_column :mailchimp_euid, subscription["euid"]
      rescue Exception => e
        Appsignal.add_exception e
        Rails.logger.error e
      end
    end
  end

  def subscription_data
    {
      email: { email: self.email },
      merge_vars: {
        FNAME: self.first_name,
        LNAME: self.last_name,
        # TODO: remove 'try' when the organization_id became required
        ORG: self.organization.try(:name),
        CITY: self.city,
        PHONE: self.phone,
        LOGINLINK: self.login_url,
        DISTRICT: self.address_district,
        groupings: [
          { name: 'Skills', groups: self.translated_skills },
          { name: 'Organizations', groups: self.organization_names }
        ]
      }
    }
  end

  def self.batch_update_mailchimp_subscriptions(*args)
    begin
      options = args.extract_options!
      sleep_time = options[:sleep_time] || 1.0
      group_size = options[:group_size] || 100
      ids = options[:ids] || []
      
      puts "Starting MailChimp subscriptions update..."
      Organization.all.each do |organization|
        puts "Organization: #{organization.name}"

        subscriptions_data = []
        users = ids.empty? ? organization.users : organization.users.find(ids)
        users_count = users.count
        puts "Users found: #{users_count}"

        users.in_groups_of(group_size, false) do |group|
          group.each do |user|
            puts "#{ users_count } left... #{user.id} - #{user.email}"
            subscriptions_data.push(user.subscription_data)
            users_count -= 1
          end

          puts "Calling MailChimp API"
          subscriptions = Gibbon::API.lists.batch_subscribe(
            id: organization.mailchimp_list_id,
            batch: subscriptions_data,
            double_optin: false,
            update_existing: true,
            replace_interests: true
          )

          if subscriptions['status'] == 'error'
            puts "Error: #{subscriptions['error']}"
          else
            puts "Total users added: #{subscriptions['add_count']}"
            puts "Total users updated: #{subscriptions['update_count']}"
            puts "Total errors: #{subscriptions['error_count']}"

            update_mailchimp_euids subscriptions["adds"]
            update_mailchimp_euids subscriptions["updates"]
            puts "MailChimp subscriptions successfully updated!"
          end
          
          sleep(sleep_time)
        end
      end
    rescue Exception => e
      Appsignal.add_exception e
      Rails.logger.error e
    end
  end

  def self.update_mailchimp_euids subscriptions
    subscriptions.each do |subscription|
      user = User.find_by email: subscription["email"]
      user.update_column :mailchimp_euid, subscription["euid"] if user
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def fetch_address
    begin
      json = JSON.parse(open("http://brazilapi.herokuapp.com/api?cep=#{self.postal_code}").read)
      if(json[0]["cep"]["valid"])
        address = json[0]["cep"]["data"]
        if(self.city != address["cidade"] || self.address_street != "#{address["tp_logradouro"]} #{address["logradouro"]}" || self.address_district != address["bairro"] || self.state != address["uf"])
          self.update_columns(city: address["cidade"], address_street: "#{address["tp_logradouro"]} #{address["logradouro"]}", address_district: address["bairro"], state: address["uf"])
        end
      end
    rescue Exception => e
      Appsignal.add_exception e
      Rails.logger.error e
    end
  end

  def locate_ip
    begin
      location = Ipaddresslabs.locate(self.ip)
      self.update_columns(
        city: location["geolocation_data"]["city"],
        state: location["geolocation_data"]["region_name"],
        country: location["geolocation_data"]["country_name"]
      )
    rescue Exception => e
      Appsignal.add_exception e
      Rails.logger.error e
    end
  end

  def organization_names
    self.memberships.any? ? self.memberships.map { |m| m.organization.try(:name) } : []
  end

  def translated_skills
    self.skills.present? ? self.skills.map { |s| I18n.t("skills.#{s}") } : []
  end

  def import_image_from_gravatar
    if (self.avatar_url == self.avatar.default_url) and self.gravatar_exists?
      self.update_attribute(:remote_avatar_url, self.gravatar_url)
    end
  end

  def gravatar_url
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email.downcase)}.png"
  end

  def gravatar_exists?
    url = "#{self.gravatar_url}?d=404"
    response = Net::HTTP.get_response(URI.parse(url))
    response.code.to_i != 404
  end

  def login_url
    "http://#{ENV['HOST']}?user_token=#{self.auth_token}&user_email=#{self.email}"
  end

  private

  def set_auth_token
    return if self.auth_token.present?

    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: self.auth_token)
  end

  def process_website
    self.website = "http://#{self.website}" if self.website.present? && self.website.index("http://").nil?
  end

  def create_first_membership
    # TODO: remove this condition when organization_id become required
    if self.organization.present?
      Membership.create organization: self.organization, user: self
    end
  end
end
