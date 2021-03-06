class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @pitch = Pitch.find(params[:pitch_id]);
    @comment = @pitch.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user;

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to pitch_path(@pitch)
    else
      flash[:warning] = "Your comment was NOT added, try again!"
      @pitch.reload
      #prevents breaking if comments field is left blank
      redirect_to pitch_path(@pitch)
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
      if @comment.update(comment_params)
        flash[:notice] = "Your comment was updated"
        redirect_to pitch_path(@pitch)
      else
        @pitch.reload
        flash[:alert] = "Update failed"
        #prevents breaking if comments field is left blank
        redirect_to pitch_path(@pitch)
      end
    
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    flash[:notice] = "Your comment was destroyed."
    redirect_to pitch_path(@pitch)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      @pitch = Pitch.find(params[:pitch_id]);
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:pitch_id, :body, :user_id)
    end
end
