require 'rails_helper'

  describe 'Factory Girl' do
    it 'should zipcode factory valid' do
      FactoryGirl.create(:zipcode).should be_valid
      FactoryGirl.build(:zipcode).should be_valid
    end
    it 'should multiple zipcode factory valid' do
      FactoryGirl.create(:zipcode).should be_valid
      FactoryGirl.create(:zipcode).should be_valid
    end
    
end
