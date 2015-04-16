require 'spec_helper'

describe Inspired::VideoFilter do
  describe '.filter' do
    context 'when the validator does not discard the video' do
      before do
        allow_any_instance_of(Inspired::VideoFilter::Validator).to receive(:discard?).and_return(false)
      end

      it 'returns an array containing the video' do
        expect(Inspired::VideoFilter.filter([Video.new, Video.new]).size).to eq(2)
      end
    end

    context 'when the validator discards the video' do
      before do
        allow_any_instance_of(Inspired::VideoFilter::Validator).to receive(:discard?).and_return(true)
      end

      it 'returns an array without the video' do
        expect(Inspired::VideoFilter.filter([Video.new, Video.new]).size).to eq(0)
      end
    end
  end

  describe Inspired::VideoFilter::Validator do
    describe '#discard?' do
      context 'when the video is bad quality' do
        before { @video = Video.new(definition: 'something_other_than_hd') }

        specify do
          expect(Inspired::VideoFilter::Validator.new(@video).discard?).to eq(true)
        end
      end

      context 'when the video is too long' do
        before { @video = Video.new(duration: 'PT10M42S') }

        specify do
          expect(Inspired::VideoFilter::Validator.new(@video).discard?).to eq(true)
        end
      end

      context 'when the video already exists in db' do
        before { @video = Video.create! }

        specify do
          expect(Inspired::VideoFilter::Validator.new(@video).discard?).to eq(true)
        end
      end
    end
  end
end