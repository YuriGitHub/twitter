class AttachmentsController < ApplicationController

    def refresh_post_images_thumbs_block
        #binding.pry
        @post = Post.find(params[:post_id])
        @user = User.find(params[:user_id])
    end

    def remove_posts_image
        #binding.pry
        @post = User.find(params[:user_id]).posts.find(params[:post_id])
        image = @post.attachments.image.find(params[:id])
        @image_id = image.id
        image.destroy
    end

    def show_audios_block
        @post_id = params[:post_id]
    end

    def show_video
        @post = Post.find(params[:post_id])
        videos = @post.attachments.video
        @video = videos.find(params[:video_id])        
    end

    def show_videos_block
        @post_id = params[:post_id]
    end


    def create
        @attachment = Attachment.new(attachment_params);
        @attachment.post_id = params[:post_id] if params[:post_id]
        @attachment.post_id = 0 unless params[:post_id]
        @attachment.user_id = current_user.id
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



    #def update
    #if (@attachment = Attachment.update(image_params))
    #render json: {}
    #else
    #render json: {},status:400
    #end
    #end

    def destroy
        respond_to do |format|
            if  Attachment.find(params[:id]).destroy
                format.json{render json: {},status:200}
            end
        end
    end

    private
    def attachment_params
        params.require(:attachment).permit(:file)
    end
end
