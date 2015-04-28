require 'machinist/active_record'

User.blueprint do
  first_name      { Faker::Name.first_name }
  last_name       { Faker::Name.last_name }
  email           { Faker::Internet.email }
  password        { Faker::Internet.password }
  mailchimp_euid  { sn }
  organization { Organization.make! }
end

Organization.blueprint do
  name { "Meu Rio #{sn}" }
  city { "Rio de Janeiro #{sn}" }
  mailchimp_list_id { "123456-#{sn}" }
end

Membership.blueprint do
  user { User.make! }
  organization { Organization.make! }
end
