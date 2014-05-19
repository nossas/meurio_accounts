class Membership < ActiveRecord::Base
  belongs_to :organization
  validates :organization_id, uniqueness: { scope: :user_id }
end
