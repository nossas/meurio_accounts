require 'spec_helper'

describe Membership do
  before { Membership.make! }

  it { should belong_to :organization }
  it { should validate_uniqueness_of(:organization_id).scoped_to(:user_id) }
  it { should validate_presence_of(:organization_id) }
  it { should validate_presence_of(:user) }
end
