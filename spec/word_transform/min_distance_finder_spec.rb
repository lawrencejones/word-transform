require 'spec_helper'

RSpec.describe WordTransform::MinDistanceFinder do
  let(:dictionary) { WordTransform::Dictionary.new(words) }
  let(:words) { %w(hot dot dog lot log cog) }

  shared_examples 'WordTransform::MinDistanceFinder' do |searcher|
    subject(:finder) { described_class.new(dictionary, searcher) }

    describe '.min_distance_between' do
      it 'returns nil if no path is possible' do
        expect(finder.min_distance_between('badword', 'hot')).to be(nil)
      end

      it 'computes distance for single step away' do
        expect(finder.min_distance_between('hot', 'dot')).to be(1)
      end

      it 'computes distance for multiple steps away' do
        expect(finder.min_distance_between('hit', 'cog')).to be(4)
      end

      context 'with a large dictionary', :benchmark do
        let(:words) { File.read('/usr/share/dict/words').split }

        it 'computes distance for large steps away' do
          # This one took a while to discover!
          expect(finder.min_distance_between('tiger', 'stave')).to eq(11)
        end
      end
    end
  end

  it_behaves_like 'WordTransform::MinDistanceFinder', WordTransform::BreadthFirstSearch
  it_behaves_like 'WordTransform::MinDistanceFinder', WordTransform::AStarSearch
end
