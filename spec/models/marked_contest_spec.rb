require 'rails_helper'

describe MarkedContest do
  let(:marked_contest) { FactoryGirl.build :marked_contest }
  subject { marked_contest }

  it { should respond_to(:u) }
  it { should respond_to(:contest_id) }
  it { should respond_to(:post) }
  it { should respond_to(:ended_at) }

  it { should validate_presence_of(:u) }
  it { should validate_presence_of(:contest_id) }
  it { should validate_presence_of(:post) }
  it { should validate_presence_of(:ended_at) }
  it { should validate_uniqueness_of(:contest_id) }
  it { should validate_numericality_of(:ended_at) }
end
