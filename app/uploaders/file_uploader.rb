

class FileUploader < CarrierWave::Uploader::Base
  delegate :indentifier, to: :file

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end



end
