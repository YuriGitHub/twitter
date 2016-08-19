class AttachmentsController < ApplicationController

    def create
        @attachment = Attachment.new(attachment_params);



        @attachment.post_id = params[:post_id]
        if Post.find(params[:post_id]).user_id == current_user.id
            type = params[:attachment][:file].content_type.split('/')[0]
            if type == 'audio' or type == 'video' or type == 'image'
                @attachment.file_type = type.to_sym
                if @attachment.save
                    render json: {}
                else
                    render json: {},status:400
                end
            else
                render json: {},status:403
            end
        else
            render json: {},status:400 
        end

    end

    def update
        if (@attachment = Attachment.update(image_params))
            render json: {}
        else
            render json: {},status:400
        end
    end

    def destroy
        Image.find(params[:id]).destroy
    end

    private
    def attachment_params
        params.require(:attachment).permit(:file)
    end
end
