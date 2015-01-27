require 'rails_helper'

describe Contest do
  let(:contest) { FactoryGirl.build :contest }
  subject { contest }

  it { should respond_to(:u) }
  it { should respond_to(:post) }
  it { should respond_to(:att) }
  it { should respond_to(:rule) }
  it { should respond_to(:ended_at) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:winner) }

  it { should validate_presence_of(:u) }
  it { should validate_presence_of(:post) }
  it { should validate_presence_of(:att) }
  it { should validate_presence_of(:rule) }
  it { should validate_presence_of(:ended_at) }
  it { should validate_presence_of(:created_at) }
  it { should validate_presence_of(:updated_at) }

  it { should validate_uniqueness_of(:u).scoped_to(:att, :rule) }

end
