require 'spec_helper'
require 'rake'

load File.dirname(__FILE__) + '/../../../lib/tasks/create_set.rake'

describe 'inspired' do
  describe 'create_set' do
    context 'when no video is set to be released in two days' do
      it 'creates a new set' do
        expect(Inspired::Engine).to receive(:create_set)
        Rake::Task['inspired:create_set'].execute
      end
    end

    context 'when a video is set to be released in two days' do
      before { Video.create!.update_attributes!(released_at: Date.today + 2.days) }

      it 'does not create any set' do
        expect(Inspired::Engine).not_to receive(:create_set)
        Rake::Task['inspired:create_set'].execute
      end
    end
  end
end