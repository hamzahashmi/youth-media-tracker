RSpec.describe PitchesController do
  render_views
  login_admin
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  describe 'index action' do
    before :each do
      FactoryGirl.create(:pitch, :name => "test",:user => @user)
      get 'index'
    end

    it 'should be render template index' do
      response.should render_template(:index)
    end

    it 'should show some pitches' do
      assigns[:pitches].should_not be_empty
    end

    it 'should have googd name' do 
      response.body.should have_link("test")
    end

  end
  describe 'show action' do
    before :each do
      pitch =FactoryGirl.create(:pitch, :name => "test2",:user => @user)
      get 'show', :id => pitch.id
    end

    it 'should be render template show' do
      response.should render_template(:show)
    end

    it 'should show  pitch' do
      assigns[:pitch].should be_valid
    end

    it 'should have  name' do 
      response.body.should have_content("test2")
    end

  end

  describe 'edit action' do
    before :each do
      pitch =FactoryGirl.create(:pitch, :name => "test3",:user => @user)
      get 'edit', :id => pitch.id
    end

    it 'should be render template edit' do
      response.should render_template(:edit)
    end

    it 'should edit  pitch' do
      assigns[:pitch].should be_valid
    end

    it 'should have name' do 
      response.body.should have_content("test2")
    end

  end
  
end