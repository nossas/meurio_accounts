require 'spec_helper'

describe Organization do
  before { Organization.make! }
  it { should validate_presence_of :name }
  it { should validate_presence_of :city }
  it { should validate_presence_of :mailchimp_list_id }
  it { should validate_uniqueness_of :name }
  it { should validate_uniqueness_of :city }
  it { should validate_uniqueness_of :mailchimp_list_id }
end
