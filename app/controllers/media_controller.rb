class MediaController < InheritedResources::Base
	before_filter :check_token, only: [:edit]
  before_filter :admin_only, :except => [:edit, :update]


def update
    @medium = Medium.find(params[:id])
    if @medium.update(medium_params)
      flash[:notice] = 'Medium was successfully submitted.'
      redirect_to root_path
    else
      render :edit
    end
  end
  private

    def medium_params
      params.require(:medium).permit(:context, :user_id, :token, :week_session_id, :due_date)
    end
    def check_token
    	#success = params.token? && Medium.exists?(:id => params[:id], :token => params[:token])
    	success = Medium.find_by_id_and_token(params[:id],params[:token] )
    	redirect_to root_path,  :alert => "Not authorized" if !success
    end
    def admin_only
    unless user_signed_in? && current_user.admin?
      redirect_to root_path, :alert => "Access denied."
    end
  end
end

