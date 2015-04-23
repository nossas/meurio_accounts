class Membership < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  validates :organization_id, uniqueness: { scope: :user_id }
  validates :organization_id, :user, presence: true

  accepts_nested_attributes_for :organization

  after_create { self.user.delay.update_location_and_mailchimp }
end
