require 'rails_helper'

describe ClinkComment do
  let(:clink_comment) { FactoryGirl.build :clink_comment }
  subject { clink_comment }	

  it { should belong_to(:contest) }
  it { should embed_many(:c_comments) }
end
