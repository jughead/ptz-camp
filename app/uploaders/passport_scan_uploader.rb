class PassportScanUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :on_upload

  version :thumb do
    resize_to_fit 50, 50
  end

  def public_id
    @stored_public_id || model.class.name.underscore + '/' + Cloudinary::Utils.random_public_id
  end

  def on_upload
    options = {convert: 'png'}
  end
end
