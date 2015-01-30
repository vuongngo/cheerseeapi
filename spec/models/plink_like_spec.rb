require 'rails_helper'

describe PlinkLike do
  let(:plink_like) { FactoryGirl.build :plink_like }
  subject { plink_like }

  it { should belong_to(:participation) }
  it { should embed_many(:p_likes) }
end
