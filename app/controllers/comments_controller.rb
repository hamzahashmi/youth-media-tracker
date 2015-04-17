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

    days_from = (DateTime.current - Rails.application.config.start_day).to_i % Rails.application.config.schedule_days
    @disc_disabled = days_from < Rails.application.config.disc_day
    
    if @disc_disabled
      flash[:notice] = "Comments are disabled."
      redirect_to pitch_path(@pitch)
    else
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
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:pitch_id, :body, :user_id)
    end
end
