class Admin::PublicFilesController < Admin::ApplicationController
  load_and_authorize_resource instance_name: :file

  def index
  end

  def new
  end

  def edit
  end

  def update
    if @file.update(update_params)
      redirect_to({action: :index}, notice: 'The file is updated')
    else
      render :new
    end
  end

  def create
    @file.title = @file.data.file.original_filename
    if @file.save
      redirect_to({action: :index}, notice: 'The file is added')
    else
      render :new
    end
  end

  def destroy
    @file.destroy
    redirect_to({action: :index}, notice: 'The file is deleted')
  end

  private

    def create_params
      params.require(:public_file).permit(:data)
    end

    def update_params
      params.require(:public_file).permit(:title)
    end

    def decorator_class
      Admin::FileDecorator
    end

    def decorate
      @files &&= decorator_class.decorate_collection(@files)
      @file &&= decorator_class.decorate(@file)
    end
end
