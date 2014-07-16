class Membership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  validates :organization_id, uniqueness: { scope: :user_id }
  validates :organization_id, :user, presence: true

  accepts_nested_attributes_for :organization

  after_create :add_to_mailchimp_list

  def add_to_mailchimp_list
    begin
      subscription = Gibbon::API.lists.subscribe(
        id: self.organization.mailchimp_list_id,
        email: {email: self.user.email},
        merge_vars: {
          FNAME: self.user.first_name,
          LNAME: self.user.last_name,
          CITY: self.user.city,
          PHONE: self.user.phone,
          groupings: [ name: 'Skills', groups: self.user.translated_skills ]
        },
        double_optin: false,
        update_existing: true,
        replace_interests: true
      )

      self.user.update_attribute :mailchimp_euid, subscription["euid"]
    rescue Exception => e
      Rails.logger.error e
    end
  end
end
