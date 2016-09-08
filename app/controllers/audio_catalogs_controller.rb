class AudioCatalogsController < ApplicationController
  before_action :find_user
  before_action :find_audio_catalog, only:[:edit, :show, :update, :destroy]
  before_action :check_authorization, only:[:new, :edit, :create, :update, :destroy, :add_track_to_catalog, :remove_track]




  def add_track_to_catalog
    @audio_catalog = @user.audio_catalogs.find(params[:audio_catalog_id])
    unless params[:attachment]
      flash[:error] = 'No file selected.'
      redirect_to user_audio_catalog_path(@user, @audio_catalog)
      return
    end
    @audio = @audio_catalog.attachments.audio.build(audio_params)
    @audio.user_id = params[:user_id]

    if @audio.save
      flash[:notice] = 'Track successfully added to catalog.'
      redirect_to user_audio_catalog_path(@user, @audio_catalog)
    else
      flash[:error] = @audio.errors.full_messages
      redirect_to user_audio_catalog_path(@user, @audio_catalog)
    end
  end


  def remove_track
    @audio_catalog = @user.audio_catalogs.find(params[:audio_catalog_id])
    @track = @audio_catalog.attachments.audio.find(params[:track_id])
    unless @track.destroy
      flash[:error] = @track.errors.full_messages
    else
      flash[:notice] = 'Track successfully removed.'
    end
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
   # binding.pry
  end

  def update
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
    #binding.pry
  end

  def destroy
      @audio_catalog.destroy
      flash[:notice] = 'Audio Catalog successfully daleted.'
      redirect_to user_audio_catalogs_path(@user)
  end

  private

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

  def audio_params
    params.require(:attachment).permit(:file)
  end
end
