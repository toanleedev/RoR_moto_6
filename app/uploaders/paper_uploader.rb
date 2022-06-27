class PaperUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: 'png'
  process tags: ['paper_picture']

  version :standard do
    process resize_to_fill: [100, 150, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end

  def public_id
    # Cloudinary::Utils.random_public_id
    basename = File.basename(original_filename, File.extname(original_filename))
    "moto-6/#{model.class}/#{basename}_#{Cloudinary::Utils.random_public_id}"
  end
end
