class AudioCatalogsController < ApplicationController
  before_action :find_user
  before_action :find_audio_catalog, only:[:edit, :show, :update, :destroy, :add_track_to_catalog, :remove_track]
  before_action :check_authorization, only:[:new, :edit, :create, :update, :destroy, :add_track_to_catalog, :remove_track]


  def  add_track_to_catalog
    unless params[:attachment]
      set_flash_error('No file selected.')
      redirect_to user_audio_catalog_path(@user, @audio_catalog)
      return
    end
    flash[:notice] = @audio_catalog.load_track(track_params, current_user)
    redirect_to user_audio_catalog_path(@user, @audio_catalog)
  end

  def remove_track
    flash[:notice] = @audio_catalog.remove_track(params[:track_id])
    redirect_to user_audio_catalog_path(@user, @audio_catalog)
  end


  def index
  end

  def new
  end

  def edit
  end

  def create
    @audio_catalog = @user.audio_catalogs.build(audio_catalog_params)
    if name_uniquess(@audio_catalog.name)
          respond_to do |format|
            if @audio_catalog.save
              format.html do
                flash[:notice] = 'Audio Catalog successfully created.'
                redirect_to user_audio_catalog_path(@user, @audio_catalog)
              end
            else
              format.html do
                flash[:error] = @audio_catalog.errors.full_messages
                render 'new'
              end
            end
          end
    else
      set_flash_error('Name must by uniquess.')
      redirect_to new_user_audio_catalog_path(@user)
    end


  end

  def update
    if name_uniquess(params[:audio_catalog][:name]) || @audio_catalog.name == params[:audio_catalog][:name]
        respond_to do |format|
          if @audio_catalog.update(audio_catalog_params)
            format.html do
              flash[:notice] = 'Audio Catalog successfully updated.'
              redirect_to user_audio_catalog_path(@user, @audio_catalog)
            end
          else
            format.html do
              flash[:error] = @audio_catalog.errors.full_messages
              redirect_to edit_user_audio_catalog_path(@user, @audio_catalog)
            end
          end
        end
    else
      set_flash_error('Name must by uniquess.')
      redirect_to edit_user_audio_catalog_path(@user, @audio_catalog)
    end


  end

  def destroy
      @audio_catalog.destroy
      flash[:notice] = 'Audio Catalog successfully daleted.'
      redirect_to user_audio_catalogs_path(@user)
  end

  private

  def set_flash_error(errors = nil)
    errors ||= @audio_catalog.errors.full_messages
    flash[:error] = errors
  end

  def name_uniquess(name)
    if @user.audio_catalogs.find_by_name(name)
      false
    else
      true
    end
  end

  def check_authorization
    unless params[:user_id].to_i == current_user.id
      redirect_to current_user
    end
  end

  def audio_catalog_params
    params.require(:audio_catalog).permit(:name)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_audio_catalog
    @audio_catalog = @user.audio_catalogs.find(params[:id])
  end

  def track_params
    params.require(:attachment).permit(:file)
  end
end
