require 'spec_helper'

describe Membership do
  it { should belong_to :organization }
  it { should validate_uniqueness_of(:organization_id).scoped_to(:user_id) }
end
