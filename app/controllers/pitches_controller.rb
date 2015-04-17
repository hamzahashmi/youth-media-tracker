class PitchesController < ApplicationController
  require 'will_paginate/array' 
  before_action :set_pitch, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # GET /pitches
  # GET /pitches.json
  def index
    days_from = (DateTime.current - Rails.application.config.start_day).to_i % Rails.application.config.schedule_days
    iter_start = DateTime.current.advance(:days => -days_from).at_beginning_of_day
    iter_end = iter_start.advance(:days => Rails.application.config.schedule_days).at_beginning_of_day
    @pitches_disabled = days_from > Rails.application.config.pitch_day
    @disc_disabled = days_from < Rails.application.config.disc_day

    if flash.key? :notice
      flash.now[:notice] = flash[:notice].html_safe
      flash.now[:notice] += "<br/>".html_safe
      flash.now[:notice] += "Current iteration ends on #{iter_end.to_formatted_s(:long)}."
    else
      flash.now[:notice] = "Current iteration ends on #{iter_end.to_formatted_s(:long)}.".html_safe
    end

    if @pitches_disabled
      flash.now[:notice] += "<br/>".html_safe
      flash.now[:notice] += "Pitch submissions currently disabled."
    end
    if @disc_disabled
      flash.now[:notice] += "<br/>".html_safe
      flash.now[:notice] += "Discussion starts in #{Rails.application.config.disc_day - days_from} days."
    end

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
    days_from = (DateTime.current - Rails.application.config.start_day).to_i % Rails.application.config.schedule_days
    @disc_disabled = days_from < Rails.application.config.disc_day
    if @disc_disabled
      flash.now[:notice] = "Discussion currently disabled."
    end
  end

  # GET /pitches/new
  def new
    @pitch = current_user.pitches.build
    days_from = (DateTime.current - Rails.application.config.start_day).to_i % Rails.application.config.schedule_days
    if days_from > Rails.application.config.pitch_day
      flash.now[:notice] = "Pitch submissions are currently disabled."
    end
  end

  # GET /pitches/1/edit
  def edit
  end

  # POST /pitches
  # POST /pitches.json
  def create
    days_from = (DateTime.current - Rails.application.config.start_day).to_i % Rails.application.config.schedule_days
    @pitches_disabled = days_from > Rails.application.config.pitch_day

    @pitch = current_user.pitches.build(pitch_params)

    if @pitches_disabled
      flash[:notice] = "Sorry, pitch submissions are currently disabled."
      render :new
    elsif @pitch.save
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
      redirect_to pitches_path(@pitch)
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
    days_from = (DateTime.current - Rails.application.config.start_day).to_i % Rails.application.config.schedule_days
    @disc_disabled = days_from < Rails.application.config.disc_day

    if not @disc_disabled
      @pitch = Pitch.find(params[:id])
      @pitch.upvote_by current_user
    end

    redirect_to :back
  end

  def downvote
    days_from = (DateTime.current - Rails.application.config.start_day).to_i % Rails.application.config.schedule_days
    @disc_disabled = days_from < Rails.application.config.disc_day

    if not @disc_disabled
      @pitch = Pitch.find(params[:id])
      @pitch.downvote_by current_user
    end

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
