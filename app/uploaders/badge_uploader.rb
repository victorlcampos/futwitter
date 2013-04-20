# encoding: utf-8

class BadgeUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  version :thumb do
    process resize_to_fill: [50, 50, '#ffffff', 'Center']
  end

  def default_url
    [version_name, 'default.png'].compact.join('-')
  end
end
