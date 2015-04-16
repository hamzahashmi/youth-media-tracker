describe User do

  describe 'Factory Girl' do
    it 'should user factory valid' do
      FactoryGirl.create(:user, :email => "my@email.com").should be_valid
      FactoryGirl.build(:user, :email => "your@email.com").should be_valid
    end
    it 'should multiple user factory valid' do
      FactoryGirl.create(:user, :email => "his@email.com").should be_valid
      FactoryGirl.create(:user, :email => "her@email.com").should be_valid
    end
    
  end

end
