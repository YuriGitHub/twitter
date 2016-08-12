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



    private
    def get_data_for_lock_user
    	params.require(:feedback_to_admin).permit(:feedbacks_text)
    end

end
