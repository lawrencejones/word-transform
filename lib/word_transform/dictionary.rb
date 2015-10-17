module WordTransform
  class Dictionary
    def initialize(words)
      @words = words
    end

    def neighbours_of(word)
      words_of_size(word.size).
        select { |candidate| difference_of_one(word, candidate) }
    end

    private

    attr_reader :words, :searcher

    def words_of_size(n)
      @words_of_size ||= words.select { |word| word.size == n }
    end

    def difference_of_one(source, destination)
      delta = 0

      for i in 0..(source.size - 1)
        delta += 1 unless source[i] == destination[i]
        return false if delta > 1
      end

      delta == 1
    end
  end
end
