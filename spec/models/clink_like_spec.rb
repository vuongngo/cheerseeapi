require 'rails_helper'

describe ClinkLike do
  let(:clink_like) { FactoryGirl.build :clink_like }
  subject { clink_like }

  it { should belong_to(:contest) }
  it { should embed_many(:c_likes) }
end
