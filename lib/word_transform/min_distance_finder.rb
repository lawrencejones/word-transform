module WordTransform
  class MinDistanceFinder
    def initialize(dictionary, searcher)
      @dictionary = dictionary
      @searcher = searcher
    end

    def min_distance_between(source, destination)
      @searcher.new(source, destination,
                    neighbours_of_proc: neighbours_of_proc).min_distance
    end

    private

    def neighbours_of_proc
      -> (word) { @dictionary.neighbours_of(word) }
    end
  end
end
