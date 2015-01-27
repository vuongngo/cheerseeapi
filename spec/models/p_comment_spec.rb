require 'rails_helper'

describe PComment do
  let(:p_comment) { FactoryGirl.build :p_comment }
  subject { p_comment }

  it { should respond_to(:u) }
  it { should respond_to(:post) }
  it { should respond_to(:created_at) }

  it { should validate_presence_of(:u) }
  it { should validate_presence_of(:post) }
  it { should validate_presence_of(:created_at) }
  it { should validate_uniqueness_of(:u).scoped_to(:post, :created_at) }
end
