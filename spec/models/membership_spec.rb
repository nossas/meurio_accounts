require 'spec_helper'

describe Membership do
  it { should belong_to :organization }
  it { should validate_uniqueness_of(:organization_id).scoped_to(:user_id) }
  it { should validate_presence_of(:organization_id) }
  it { should validate_presence_of(:user_id) }

  describe '#add_to_mailchimp_list' do
    it 'should subscribe user to the mailchimp list' do
      membership = Membership.make!
      lists = double('lists')
      Gibbon::API.stub(:lists).and_return(lists)
      lists.should_receive(:subscribe).with(
        id: membership.organization.mailchimp_list_id,
        email: {email: membership.user.email},
        merge_vars: {
          FNAME: membership.user.first_name,
          LNAME: membership.user.last_name,
          CITY: membership.user.city,
          PHONE: membership.user.phone,
          groupings: [ name: 'Skills', groups: membership.user.translated_skills ]
        },
        double_optin: false,
        update_existing: true,
        replace_interests: true
      ).at_least(:once).and_return({"euid" => "123"})
      membership.add_to_mailchimp_list
    end

    it 'should update the user mailchimp_euid' do
      user = User.make!
      Gibbon::API.stub_chain(:lists, :subscribe).and_return({"euid" => "123"})
      user.should_receive(:update_attribute).with(:mailchimp_euid, '123')
      membership = Membership.make! user: user
    end
  end
end
