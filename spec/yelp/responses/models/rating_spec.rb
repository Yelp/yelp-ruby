require 'spec_helper'

describe Yelp::Response::Model::Rating do
  let(:rating_value) { 2.5 }

  describe 'image' do
    let(:rating_image) { 'http://yelp.com/image.jpg' }
    let(:rating_image_small) { 'http://yelp.com/image_small.jpg' }
    let(:rating_image_large) { 'http://yelp.com/image_large.jpg' }

    let(:rating_hash) { Hash[ 'rating'                 => rating_value,
                              'rating_image_url'       => rating_image,
                              'rating_image_small_url' => rating_image_small,
                              'rating_image_large_url' => rating_image_large]}

    subject(:rating) { Yelp::Response::Model::Rating.new(rating_hash) }

    it 'has a #rating' do
      expect(rating.rating).to be rating_value
    end

    it 'has an #image_url' do
      expect(rating.image_url).to be rating_image
      expect(rating.image_url(:small)).to be rating_image_small
      expect(rating.image_url(:large)).to be rating_image_large
    end

    it 'has aliases' do
      expect(rating.image_small_url).to be rating_image_small
      expect(rating.image_large_url).to be rating_image_large
    end
  end

  describe 'img' do
    let(:rating_image) { 'http://yelp.com/image.jpg' }
    let(:rating_image_small) { 'http://yelp.com/image_small.jpg' }
    let(:rating_image_large) { 'http://yelp.com/image_large.jpg' }

    let(:rating_hash) { Hash[ 'rating'               => rating_value,
                              'rating_img_url'       => rating_image,
                              'rating_img_url_small' => rating_image_small,
                              'rating_img_url_large' => rating_image_large]}

    subject(:rating) { Yelp::Response::Model::Rating.new(rating_hash) }

    it 'has a #rating' do
      expect(rating.rating).to be rating_value
    end

    it 'has an #image_url' do
      expect(rating.image_url).to be rating_image
      expect(rating.image_url(:small)).to be rating_image_small
      expect(rating.image_url(:large)).to be rating_image_large
    end

    it 'has aliases' do
      expect(rating.image_small_url).to be rating_image_small
      expect(rating.image_large_url).to be rating_image_large

      expect(rating.img_url).to be rating_image
      expect(rating.img_url_small).to be rating_image_small
      expect(rating.img_url_large).to be rating_image_large
    end
  end
end
