class PitchesController < ApplicationController
  require 'will_paginate/array' 
  before_action :set_pitch, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # GET /pitches
  # GET /pitches.json
  def index
    sort = params[:sort] || session[:sort] || "recent"
    session[:sort] = sort
    if (sort=="recent" ) 
     @pitches = Pitch.order(created_at: :desc)
   else
    @pitches = Pitch.all.sort{|a,b| a.get_downvotes.size - a.get_upvotes.size <=> b.get_downvotes.size - b.get_upvotes.size}
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
      flash[:notice] = 'Pitch was successfully created.'
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
    @pitch.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @pitch = Pitch.find(params[:id])
    @pitch.downvote_by current_user
    redirect_to :back
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_pitch
      @pitch = Pitch.find(params[:id])
    end
    def authorized_user
      @pitch = current_user.pitches.find_by(id: params[:id])
      redirect_to pitches_path, notice: "Not authorized to edit this pitch" if @pitch.nil?
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def pitch_params
      params.require(:pitch).permit(:name, :media, :category, :description, :page)
    end
  end
