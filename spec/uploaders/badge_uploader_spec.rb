require 'spec_helper'
require 'carrierwave/test/matchers'

describe BadgeUploader do
  let(:uploader) { BadgeUploader }

  describe 'versions' do
    it 'includes "thumb"' do
      uploader.versions.should have_key :thumb
    end
  end

  context 'the "thumb" version' do
    it 'should resize to 50x50' do
      processor = [:resize_to_fill, [50, 50, '#ffffff', 'Center'], nil]
      uploader.version(:thumb)[:uploader].processors.should include processor
    end
  end

  describe 'default_url' do
    it 'should return /assets/default-"version".png' do
      badge_uploader = uploader.new

      badge_uploader.default_url.should eq('default.png')
      badge_uploader.thumb.default_url.should eq('thumb-default.png')
    end
  end

end