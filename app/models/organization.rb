class Organization < ActiveRecord::Base
  validates :name, :mailchimp_list_id, :city, presence: true
  validates :name, :mailchimp_list_id, :city, uniqueness: true

  has_many :memberships
  has_many :users, through: :memberships

  mount_uploader :avatar, AvatarUploader
end
