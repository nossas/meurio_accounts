require 'machinist/active_record'

User.blueprint do
  email     { Faker::Internet.email }
  password  { Faker::Internet.password }
end