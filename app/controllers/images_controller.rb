class ImagesController < ApplicationController
    def create
        @image = Image.create(image_params)
        if @image.save
            render json: {}
        else
            render json: {},status:400
        end
    end

    def update
        if (@image = Image.update(image_params))
            render json: {}
        else
            render json: {},status:400
        end
    end

    def destroy
        Image.find(params[:id]).destroy
    end

    private
    def image_params
        params.require(:image).permit(:image,:post_id)
    end
end
