class Organization < ActiveRecord::Base
  validates :name, :city, presence: true
  validates :name, :city, uniqueness: true

  has_many :memberships
  has_many :users, through: :memberships

  mount_uploader :avatar, AvatarUploader
end
