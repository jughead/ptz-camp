class Admin::PagesController < Admin::ApplicationController
  load_resource :camp
  load_and_authorize_resource through: :camp, shallow: true

  decorate_current_camp
  before_action :decorate

  def index
  end

  def new
  end

  def edit
  end

  def update
    if @page.update(update_params)
      Rails.cache.clear
      redirect_to({action: :index}, notice: 'The page is updated')
    else
      render :new
    end
  end

  def create
    if @page.save
      Rails.cache.clear
      redirect_to({action: :index}, notice: 'The page is added')
    else
      render :new
    end
  end

  def destroy
    @page.destroy
    Rails.cache.clear
    redirect_to({action: :index}, notice: 'The page is deleted')
  end

  private

    def create_params
      params.require(:page).permit(:title, :slug, :content, :state, :order, :camp_id)
    end

    def update_params
      params.require(:page).permit(:title, :slug, :content, :state, :order, :camp_id)
    end

    def decorator_class
      Admin::PageDecorator
    end

    def decorate
      @pages &&= decorator_class.decorate_collection(@pages)
      @page &&= decorator_class.decorate(@page)
    end
end
