class PhotoAlbumsController < ApplicationController

  before_action :find_user
  before_action :check_authorization, only:[:new, :create, :update, :destroy, :remove_photo, :add_photo_to_album]
  before_action :find_album, only:[:show, :edit, :update, :destroy, :add_photo_to_album, :remove_photo]

  def remove_photo
    flash[:notice] = @album.remove_photo(params[:photo_id])
    redirect_to user_photo_album_path(@user, @album)
  end

  def  add_photo_to_album
    unless params[:attachment]
      set_flash_error('No file selected.')
      redirect_to user_photo_album_path(@user, @album)
      return
    end
    flash[:notice] = @album.load_photo(photo_params, current_user)
    redirect_to user_photo_album_path(@user, @album)
  end


  def all_photos
    albums = @user.photo_albums
    @photos = []
    albums.each do |album|
      @photos << album.photos
    end
    @photos.flatten!
  end

  def index
  end

  def new
  end

  def edit
  end

  def show
  end

  def create
    @album = @user.photo_albums.build(album_params)
    if @album.name_uniquess(@album.name)
        respond_to do |format|
          if @album.save
            flash[:notice] = 'Photo Album successfully created'
            format.html {redirect_to user_photo_albums_path(@user)}
          else
            set_flash_error
            format.html { redirect_to new_user_photo_album_path(@user) }
          end
        end
    else
        set_flash_error('Name must by uniquess.')
        redirect_to new_user_photo_album_path(@user)
    end
  end

  def update
   if @album.name_uniquess(@album.name)
    respond_to do |format|
      if @album.update(album_params)
        format.html do
          flash[:notice] = 'Photo Album successfully updated'
          redirect_to user_photo_album_path(@user, @album)
        end
      else
        format.html do
          set_flash_error
          redirect_to edit_user_photo_album_path(@user, @album)
        end
      end
    end
   else
     set_flash_error('Name must by uniquess.')
     redirect_to edit_user_photo_album_path(@user, @album)
   end
  end

  def destroy
    if @album.destroy
      flash[:notice] = 'Photo Album successfully deleted.'
      redirect_to user_photo_albums_path(@user)
    else
      set_flash_error
      redirect_to user_photo_album_path(@user, @album)
    end
  end

  private

  def set_flash_error(errors = nil)
    errors ||= @album.errors.full_messages
    flash[:error] = errors
  end
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
