require 'spec_helper'

RSpec.describe WordTransform::Dictionary do
  subject(:dictionary) { described_class.new(words) }

  let(:words) { %w(hot dot dog lot log cog) }

  describe '.neighbours_of' do
    it 'generates array of words that are one character away' do
      expect(dictionary.neighbours_of('hot')).to eq(%w(dot lot))
    end

    context 'when word has no neighbours' do
      it 'generates empty array' do
        expect(dictionary.neighbours_of('hermit')).to eq([])
      end
    end
  end
end
