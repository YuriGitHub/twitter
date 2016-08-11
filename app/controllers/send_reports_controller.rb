class SendReportsController < ApplicationController

	 # def delete_report
  #      m = Report.find(params[:id]).destroy
  #     redirect_to admin_user_path m.sender_user
  #   end

    def show_report
    	@user = User.find(params[:user_id])
        @report = FeedbackToAdmin.new
    end

    def add_report
       f =  FeedbackToAdmin.new(get_data_for_lock_user)
       f.user = User.find params[:id]
       f.save
       redirect_to '/'
    end

    # def lock_user
    #   u = User.find(params[:id])
    #   u.locked_at = Time.now.utc
    #   u.save
    #   MailforLockedUserMailer.lock_user_email(u,get_data_for_lock_user).deliver_now
    #   redirect_to admin_user_path u
    # end


    # def unlock_user
    #     u = User.find(params[:id])
    #     redirect_to admin_user_path u
    # end


    private
    def get_data_for_lock_user
    	params.require(:feedback_to_admin).permit(:feedbacks_text)
    end
end
