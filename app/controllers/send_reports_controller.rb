class SendReportsController < ApplicationController



    def show_report
    	@user = User.find(params[:id])
        @report = FeedbackToAdmin.new
    end

    def add_report
       f =  FeedbackToAdmin.new(get_data_for_lock_user)
       f.user = User.find params[:id]
       f.save
       redirect_to '/'
    end

    def add_report_to_user
      if current_user.present?
        report = Report.new(get_data_from_report)
        user = User.find(params[:id_reportable])
        report.sender_user = current_user
        report.reportable = user
        report.save
        if(user.reports.length >= 5)
          user .blocked_text = "You got a lot of reports"
          user.locked_at = Time.now.utc
          user.save
          MailforLockedUserMailer.lock_user_email(user, user.blocked_text).deliver_now
        end
      end
      redirect_to "/users/#{user.id}"
    end

    def show_report_form
      @report = Report.new
      render 'send_reports/add_report'
    end


    private
    def get_data_for_lock_user
    	params.require(:feedback_to_admin).permit(:feedbacks_text)
    end
    def get_data_from_report
      params.require(:report).permit(:report_text)
    end

end
