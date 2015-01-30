require 'rails_helper'

describe PlinkComment do
  let(:plink_comment) { FactoryGirl.build :plink_comment }
  subject { plink_comment }

  it { should belong_to(:participation) }
  it { should embed_many(:p_comments) }
end
