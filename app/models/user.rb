class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates :email, :first_name, :last_name, presence: true
  validates :email, format: { with: /([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z\_\-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}/ }
  validates :password, on: :create, length: { minimum: 6, maximum: 128 }
  validates :secondary_email, format: { with: /([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z\_\-]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}/ }, allow_blank: true
  validates :phone, format: { with: /\([\d]{2}\)\s[\d]{8,9}/ }, allow_blank: true
  validates :website, format: { with: /(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?/ }, allow_blank: true

  has_many :memberships
  has_many :organizations, through: :memberships

  mount_uploader :avatar, AvatarUploader

  bitmask :availability, as: AVAILABILITY_OPTIONS
  bitmask :topics, as: TOPIC_OPTIONS

  after_save { self.delay.update_location_and_mailchimp }

  def update_location_and_mailchimp
    self.fetch_address if self.postal_code.present?
    self.locate_ip if self.ip.present? and self.postal_code.blank?
    self.update_mailchimp_subscription
  end

  def name
    "#{first_name} #{last_name}"
  end

  def fetch_address
    json = JSON.parse(open("http://brazilapi.herokuapp.com/api?cep=#{self.postal_code}").read)
    if(json[0]["cep"]["result"])
      address = json[0]["cep"]["data"]
      if(self.city != address["cidade"] || self.address_street != "#{address["tp_logradouro"]} #{address["logradouro"]}" || self.address_district != address["bairro"] || self.state != address["uf"])
        self.update_columns(city: address["cidade"], address_street: "#{address["tp_logradouro"]} #{address["logradouro"]}", address_district: address["bairro"], state: address["uf"])
      end
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
      Rails.logger.error e
    end
  end

  def update_mailchimp_subscription
    # TODO: rewrite this method to support multiple accounts
    if self.application_slug != "naopassarao"
      begin
        Gibbon::API.lists.subscribe(
          id: ENV["MAILCHIMP_LIST_ID"],
          email: {email: self.email},
          merge_vars: {
            FNAME: self.first_name,
            LNAME: self.last_name,
            CITY: self.city,
            PHONE: self.phone,
            groupings: [ name: 'Skills', groups: self.translated_skills ]
          },
          double_optin: false,
          update_existing: true,
          replace_interests: true
        )
      rescue Exception => e
        Rails.logger.error e
      end
    end
  end

  def translated_skills
    self.skills.map { |s| I18n.t("skills.#{s}") } unless self.skills.blank?
  end
end
