require 'spec_helper'
require 'pry'

RSpec.describe WordTransform::Dictionary do
  subject(:dictionary) { described_class.new(words) }

  let(:words) { %w(hot dot dog lot log cog) }

  describe '.neighbours' do
    it 'generates array of words that are one character away' do
      expect(dictionary.neighbours('hot')).to eq(%w(dot lot))
    end

    context 'when word has no neighbours' do
      it 'generates empty array' do
        expect(dictionary.neighbours('hermit')).to eq([])
      end
    end
  end

  describe '.path' do
    it 'returns nil if no path is possible' do
      expect(dictionary.path('badword', 'hot')).to be(nil)
    end

    it 'computes distance for single step away' do
      expect(dictionary.path('hot', 'dot')).to be(1)
    end

    it 'computes distance for multiple steps away' do
      expect(dictionary.path('hit', 'cog')).to be(4)
    end

    context 'with a large dictionary' do
      let(:words) { File.read('/usr/share/dict/words').split }

      it 'computes distance for large steps away' do
        # This one took a while to discover!
        # expect(dictionary.path('tiger', 'aryan')).to eq(10)
        # expect(dictionary.path('tiger', 'stave')).to eq(11)
      end
    end
  end
end
