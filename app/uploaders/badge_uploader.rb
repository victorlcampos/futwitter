# encoding: utf-8

class BadgeUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  version :thumb do
    process resize_to_fill: [30, 30, 'Center']
  end

  def default_url
    [version_name, 'default.png'].compact.join('-')
  end

  def store_dir
    'uploads/badges'
  end

  def root
    Rails.root.join 'public/'
  end
end
