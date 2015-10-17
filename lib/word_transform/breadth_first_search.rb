require 'set'

module WordTransform
  class BreadthFirstSearch
    def initialize(source, destination, neighbours_of_proc:)
      @source = source
      @destination = destination
      @neighbours_of_proc = neighbours_of_proc
    end

    def min_distance
      @min_distance ||= calculate_min_distance
    end

    private

    def calculate_min_distance
      distance = 0
      seen = Set.new.add(@source)
      open = [@source]

      until open.empty?
        distance += 1
        open = open.flat_map { |n| neighbours_of(n) }.uniq - seen.to_a
        seen.merge(open)

        return distance if seen.include?(@destination)
      end
    end

    def neighbours_of(n)
      @neighbours_of_proc.call(n)
    end
  end
end
