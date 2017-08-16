class FileUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def public_id
    @stored_public_id || model.class.name.underscore + '/' + Cloudinary::Utils.random_public_id
  end
end
