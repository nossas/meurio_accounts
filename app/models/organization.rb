class Organization < ActiveRecord::Base
  validates :name, :mailchimp_list_id, :city, presence: true
  validates :name, :mailchimp_list_id, :city, uniqueness: true

  mount_uploader :avatar, AvatarUploader
end
