RSpec.describe CommentsController do
  before(:all) do
    @user = FactoryGirl.create(:user)
    @pitch = FactoryGirl.create(:pitch, :user => @user)
  end
    it "blocks unauthenticated access" do
    get :new, :pitch_id => @pitch.id
    response.should redirect_to(new_user_session_path)
  end

  it "allows authenticated access" do
    sign_in @user

    get :new, :pitch_id => @pitch.id

    response.should be_success
  end

  it "should update comment" do
    sign_in @user
    comment = FactoryGirl.create(:comment, :user => @user, :pitch => @pitch, :body => "old")
    put :update, :pitch_id => @pitch.id,:id => comment.id,  :comment => {:body => "new"}
    comment.reload
    comment.body.should eq("new")
    expect(flash[:notice]).to be_present
  end

  it "should not update comment" do
    sign_in @user
    comment = FactoryGirl.create(:comment, :user => @user, :pitch => @pitch, :body => "old")
    put :update, :pitch_id => @pitch.id,:id => comment.id,  :comment => {:body => ""}
    comment.reload
    comment.body.should eq("old")
    expect(flash[:alert]).to be_present
  end

  it "should update comment" do
    sign_in @user
    comment = FactoryGirl.create(:comment, :user => @user, :pitch => @pitch, :body => "old")
    delete :destroy, :pitch_id => @pitch.id,:id => comment.id
    comment.should be_valid
    expect(flash[:notice]).to be_present
  end
end