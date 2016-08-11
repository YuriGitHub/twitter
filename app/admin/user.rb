ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
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
         column image_tag user.avatar.url(:thumb)
        end
      column :login
      column :email
      actions
    end

    show do
        columns do
      attributes_table_for user do
      row :login
      row :email
      row :last_name
     end
    end
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
