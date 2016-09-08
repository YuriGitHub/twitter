class PhotoAlbumsController < ApplicationController

  before_action :find_user
  before_action :check_authorization, only:[:new, :create, :update, :destroy]
  before_action :find_album, only:[:show, :edit, :update, :destroy]



  def  add_photo_to_album
    @album = @user.photo_albums.find(params[:photo_album_id])
    @picture = @album.attachments.image.build(photo_params)
    @picture.user_id = params[:user_id]
    if @picture.save
      redirect_to user_photo_album_path(@user, @album)
    end
  end




  def index
  end

  def new
  end

  def edit
    @errors = params[:errors]
  end

  def show
  end

  def create
    @album = @user.photo_albums.build(album_params)
    respond_to do |format|
      if @album.save
        format.html {redirect_to user_photo_albums_path(@user)}
      else
        format.html {render 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html {redirect_to user_photo_album_path(@user, @album)}
      else
        format.html do
          errors = @album.errors.full_messages
          redirect_to edit_user_photo_album_path(@user, @album, errors: errors)
        end
      end
    end
  end

  def destroy
    @album.destroy
    redirect_to user_photo_albums_path(@user)
  end

  private
  def find_album
    @album = @user.photo_albums.find(params[:id])
  end
  def find_user
    @user = User.find(params[:user_id])
  end

  def check_authorization
    unless params[:user_id].to_i == current_user.id
      redirect_to current_user
    end
  end
  def album_params
    params.require(:photo_album).permit(:name)
  end

  def photo_params
    params.require(:attachment).permit(:file)
  end
end
