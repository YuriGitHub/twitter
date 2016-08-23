class AttachmentsController < ApplicationController

    

    def show_image 
        @post =  Post.find(params[:post_id])      
        images = @post.attachments.image       
        @image = images.find(params[:image_id]) 
        if params[:position] == 'next'             
             @index = images.find_index(@image)
             if @index == images.count - 1
                @image = images[0]
             else              
                @image = images[@index + 1]
             end
        end
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
