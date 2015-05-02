class PitchesController < ApplicationController
  require 'will_paginate/array' 
  before_action :set_pitch, only: [:show, :edit, :update, :destroy , :send_final_work_mail]
  before_action :set_categories_media_types, only: [:edit, :new, :update, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # GET /pitches
  # GET /pitches.json
  def index
    if flash.key? :notice
      flash.now[:notice] = flash[:notice].html_safe
      flash.now[:notice] += "<br/>".html_safe
      flash.now[:notice] += "Current iteration ends on #{Schedule.iter_end.to_formatted_s(:long)}"
    else
      flash.now[:notice] = "Current iteration ends on #{Schedule.iter_end.to_formatted_s(:long)}".html_safe
    end

    sort = params[:sort] || session[:sort] || "recent"
    session[:sort] = sort
    if (sort=="recent") 
      @pitches = Pitch.order(created_at: :desc)
    else
      @pitches = Pitch.all.sort_by{|a| - a.get_upvotes.size }
  end
  @pitches = @pitches.paginate(:page => params[:page] || 1, :per_page => 30)

end

  # GET /pitches/1
  # GET /pitches/1.json
  def show
  end

  # GET /pitches/new
  def new
    @pitch = current_user.pitches.build
  end

  # GET /pitches/1/edit
  def edit
  end

  # POST /pitches
  # POST /pitches.json
  def create
    @pitch = current_user.pitches.build(pitch_params)

    if @pitch.save
      flash[:notice] = "Pitch was successfully created."
      redirect_to pitches_path
    else
      render :new
    end
  end

  # PATCH/PUT /pitches/1
  # PATCH/PUT /pitches/1.json
  def update
    if @pitch.update(pitch_params)
      flash[:notice] = 'Pitch was successfully updated.'
      redirect_to pitch_path(@pitch)
    else
      render :edit
    end
  end

  # DELETE /pitches/1
  # DELETE /pitches/1.json
  def destroy
    @pitch = Pitch.find(params[:id])
    @pitch.destroy
    flash[:notice] = 'Pitch was successfully destroyed.'
    redirect_to pitches_path
  end

  def upvote
    @pitch = Pitch.find(params[:id])
    if @pitch.created_at > Schedule.iter_start
      @pitch.upvote_by current_user
    else
      flash.now[:notice] = "Cannot vote on previous iteration's pitches."
    end

    redirect_to :back
  end

  def downvote
    @pitch = Pitch.find(params[:id])
    
    if current_user.voted_up_on?(@pitch)
      if @pitch.created_at > Schedule.iter_start
        @pitch.downvote_by current_user
      else
        flash.now[:notice] = "Cannot vote on previous iteration's pitches."
      end
    end

    redirect_to :back
  end

  def send_final_work_mail
    UserMailer.submit_final_work(@pitch).deliver
    flash[:success] = 'Sent successfully.'
    redirect_to :back
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_pitch
      @pitch = Pitch.find(params[:id])
    end
    def set_categories_media_types
      @categories = Category.categories_list
      @media_types = MediaType.all.map { |m| [m.name,m.id] }
    end
    def authorized_user
      @pitch = current_user.pitches.find_by(id: params[:id])
      redirect_to pitches_path, notice: "Not authorized to edit this pitch" if @pitch.nil?
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def pitch_params
      params.require(:pitch).permit(:name, :media_type_id,  :description, :page,:category_id)
    end
  end
