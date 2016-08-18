class ImagesController < ApplicationController
    def create
        Image.create(image_params)
    end

    def destroy
        Image.find(params[:id]).destroy
    end

    private
    def image_params
        params.require(:image).permit(:image)
    end
end
