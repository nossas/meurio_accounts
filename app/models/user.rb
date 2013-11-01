class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :first_name, :last_name, presence: true
  validates :email, format: { with: /([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}/ }
  validates :password, on: :create, length: { minimum: 6, maximum: 128 }
  validates :secondary_email, format: { with: /([0-9a-zA-Z]+[-._+&amp;])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,6}/ }, allow_blank: true
  validates :postal_code, format: { with: /[\d]{5}-[\d]{3}/ }, allow_blank: true
  validates :phone, format: { with: /\([\d]{2}\)\s[\d]{8,9}/ }, allow_blank: true
  validates :website, format: { with: /(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?/ }, allow_blank: true

  mount_uploader :avatar, AvatarUploader

  after_save { self.delay.fetch_address }

  def fetch_address
    json = JSON.parse(open("http://brazilapi.herokuapp.com/api?cep=#{self.postal_code}").read)
    if(json[0]["cep"]["result"])
      address = json[0]["cep"]["data"]
      if(self.city != address["cidade"] || self.address_street != "#{address["tp_logradouro"]} #{address["logradouro"]}" || self.address_district != address["bairro"] || self.state != address["uf"])
        self.update_attributes(city: address["cidade"], address_street: "#{address["tp_logradouro"]} #{address["logradouro"]}", address_district: address["bairro"], state: address["uf"])
      end
    end
  end
end
