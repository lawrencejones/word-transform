require 'set'
require 'benchmark'

module WordTransform
  class Dictionary
    def initialize(words)
      @words = words
    end

    def neighbours(word)
      words_of_size(word.size).
        select { |candidate| character_difference(word, candidate) == 1 }
    end

    def path(source, destination)
      seen = Set.new.add(source)
      distance = 0
      targets = [source]

      until targets.empty?
        distance += 1
        targets = targets.flat_map { |target| neighbours(target) }.uniq - seen.to_a
        seen.merge(targets)

        return distance if seen.include?(destination)
      end
    end

    private

    attr_reader :words

    def words_of_size(n)
      @words_of_size ||= words.select { |word| word.size == n }
    end

    def character_difference(source, destination)
      source.chars.zip(destination.chars).select { |(a, b)| a != b }.count
    end
  end
end
