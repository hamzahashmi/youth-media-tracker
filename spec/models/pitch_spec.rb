require 'rails_helper'

RSpec.describe Pitch, type: :model do
  describe 'Factory Girl' do
    it 'should pitch factory valid' do
      @user = FactoryGirl.create(:user)
      FactoryGirl.create(:pitch, :user => @user).should be_valid
    end
    it 'should multiple pitch factory valid' do
      FactoryGirl.create(:pitch, :user => @user).should be_valid
      FactoryGirl.create(:pitch, :user => @user).should be_valid
    end
  end

end
