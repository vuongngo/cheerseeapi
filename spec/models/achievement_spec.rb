require 'rails_helper'

describe Achievement do
  let(:achievement) { FactoryGirl.build :achievement }
  subject { achievement }

  it { should respond_to(:participation_id) }
  it { should respond_to(:contest_id) }
  it { should respond_to(:winner_place) }

  it { should validate_presence_of(:participation_id) }
  it { should validate_presence_of(:contest_id) }
  it { should validate_presence_of(:winner_place) }

  it { should validate_uniqueness_of(:participation_id).scoped_to(:contest_id) } 
end
