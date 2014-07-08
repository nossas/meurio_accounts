require 'machinist/active_record'

User.blueprint do
  first_name      { Faker::Name.first_name }
  last_name       { Faker::Name.last_name }
  email           { Faker::Internet.email }
  password        { Faker::Internet.password }
  mailchimp_euid  { sn }
end

Organization.blueprint do
  name { "Meu Rio" }
  city { "Rio de Janeiro" }
  mailchimp_list_id { "123" }
end
