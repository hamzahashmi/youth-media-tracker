class MediaController < InheritedResources::Base

  private

    def medium_params
      params.require(:medium).permit(:context, :user_id, :token, :week_session_id, :due_date)
    end
end

