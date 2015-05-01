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
end