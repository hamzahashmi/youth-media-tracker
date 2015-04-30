require 'rails_helper'

RSpec.describe PitchesController do
  
  render_views
  before(:all) do
    @user = FactoryGirl.create(:user)
  end
    it "blocks unauthenticated access" do
    sign_in nil

    get :new

    response.should redirect_to(new_user_session_path)
  end

  it "allows authenticated access" do
    sign_in @user

    get :new

    response.should be_success
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

  describe 'index action with sorting' do
    before :each do
      FactoryGirl.create(:pitch, :name => "test",:user => @user)
      get 'index', {:sort => "top"}
    end

    it 'should be render template index' do
      response.should render_template(:index)
      response.should be_success
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
      pitch =FactoryGirl.create(:pitch, :name => "test2",:user_id=> @user.id)
      get 'show', :id => pitch.id
    end

    it 'should be render template show' do
      response.should render_template(:show)
      response.should be_success
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
      sign_in @user
      @pitch =FactoryGirl.create(:pitch, :name => "test3",:user => @user)
      get 'edit', :id => @pitch.id
    end


    it 'should edit pitch' do
      assigns[:pitch].should eq(@pitch)
    end

  end

  describe 'new action' do
    before :each do
      sign_in @user
      @pitch =FactoryGirl.create(:pitch, :name => "test3",:user => @user)
      get 'new'
    end

    it 'should be render template new' do
      response.should render_template(:new)
      response.should be_success
    end

    it 'should show  new pich' do
      assigns[:pitch].should be_a Pitch
    end

  end

  describe 'update action' do
    before :each do
      sign_in @user
      @pitch =FactoryGirl.create(:pitch, :name => "test3",:user => @user)
      put 'update', :id => @pitch , :pitch => @pitch.attributes
    end

    it 'should redirect to' do
      response.should redirect_to(pitch_path(@pitch))
    end

  end
  describe 'update action failed' do
    before :each do
      sign_in @user
      @pitch =FactoryGirl.create(:pitch, :name => "test4",:user => @user)
      put 'update', :id => @pitch , :pitch => {:name => ""}
    end

    it 'should redirect to new' do
      response.should render_template(:edit)
      response.should be_success
    end

  end

  describe 'create action' do

    it 'should success' do
      sign_in @user
      category = FactoryGirl.create(:category)
      media_type = FactoryGirl.create(:media_type)
      params = {:name=>"testName",
                :media_type_id => media_type.id,
                :category_id => category.id,
                :description=>"testText",}
      post 'create',  :pitch => params
      response.should redirect_to(pitches_path)
    end

  end

   describe 'create action failed' do

    it 'should failed' do
      sign_in @user
      params = {:name=>"",
                :media=>"testMedia",
                :category=>"testCategory",
                :description=>"testText",}
      post 'create', :pitch => params
      response.should render_template(:new)
      response.should be_success
    end

  end

  describe 'destroy action' do

    it 'should success' do
      sign_in @user
      @pitch = FactoryGirl.create(:pitch, :user => @user)
      get 'destroy',  :id => @pitch.id
      response.should redirect_to(pitches_path)
    end
  end
  describe 'vote action' do

    it 'should add one up vote' do
      sign_in @user
      @pitch = FactoryGirl.create(:pitch, :user => @user)
      @request.env['HTTP_REFERER'] = 'http://test.com/'
      expect{put 'upvote',  :id => @pitch.id}.to change{ 
        @pitch.get_upvotes.size}.from(0).to(1)
    end
  end

  describe 'down action' do

    it 'should add one down vote' do
      sign_in @user
      @pitch = FactoryGirl.create(:pitch, :user => @user)
      @request.env['HTTP_REFERER'] = 'http://test.com/'
      expect{put 'downvote',  :id => @pitch.id}.to change{ 
        @pitch.get_downvotes.size}.from(0).to(1)
    end
  end

  
end