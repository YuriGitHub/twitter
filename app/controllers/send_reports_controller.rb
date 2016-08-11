class SendReportsController < ApplicationController

	 def delete_report
       m = Report.find(params[:id]).destroy
      redirect_to admin_user_path m.sender_user
    end

    def lock_user
      u = User.find(params[:id])
      u.locked_at = Time.now.utc
      u.save
      MailforLockedUserMailer.lock_user_email(u,get_data_for_lock_user).deliver_now
      redirect_to admin_user_path u
    end


    def unlock_user
        u = User.find(params[:id])
        redirect_to admin_user_path u
    end


    private
    def get_data_for_lock_user
    	params.require(:report).permit(:report_text)
    end
end
