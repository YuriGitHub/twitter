ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

controller do
    # This code is evaluated within the controller class

    def delete_report
       m = Report.find(params[:id]).destroy
      redirect_to admin_user_path m.sender_user
    end

    def lock_user
      u = User.find(params[:id])
      u.locked_at = Time.now.utc
      u.save
      MailforLockedUserMailer.lock_user_email(u,'loh').deliver_now
      redirect_to admin_user_path u
    end


    def unlock_user
        u = User.find(params[:id])
        redirect_to admin_user_path u

    end
  end



 permit_params :login, :email, :password, :first_name,
               :last_name, :country,:city,:date_of_birth,
               :gender,:avatar
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
    filter :email
    filter :login

    index do 
      id_column
       column "Image" do |user|
          image_tag user.avatar.url(:thumb)
        end
      column :login
      column :email
      actions
    end

    show do
      if user.access_locked?  

        h1 "User is locked"

       end
          attributes_table do
          row :image do
            image_tag user.avatar.url(:medium)
          end
          row :first_name
          row :last_name
          row :email
          row :login
          row :city
          row :country
          row :date_of_birth
        end

    
        columns '', user.reports.each {|r|
            attributes_table  do
            h5 "Report Text: #{r.report_text}"
            h5 link_to "Sender: #{r.sender_user.login}", admin_admin_user_path(r.sender_user)
            h5 link_to "Delete Report", delete_report_admin_user_path(r), method: :delete
            end
        }
   
  end

    form  do |f| 
         f.inputs 'User Main Data' do
            if(f.object.login != nil)
                f.input :login, :input_html => { :disabled => true }
                f.input :email, :input_html => { :disabled => true }
                f.input :password, :input_html => { :disabled => true }
            else
                f.input :login
                f.input :email
                f.input :password
            end
        end
        f.inputs 'User Aditional Data' do
            f.input :first_name
            f.input :last_name
            f.input :country
            f.input :city
            f.input :date_of_birth, as: :datepicker
            f.input :gender
            f.input :avatar, :as => :file, :hint => image_tag(f.object.avatar.url(:medium)) 
 
        end
        f.actions
    end
end
