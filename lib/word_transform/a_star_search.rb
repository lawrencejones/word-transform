module WordTransform
  class AStarSearch
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
      open = Hash[@source, 0]
      seen = {}

      until open.empty?
        current, distance = open.min_by { |k,v| v + h(k) }
        seen[current] = open.delete(current)

        for neighbour in neighbours_of(current)
          cost = distance + 1

          return cost if neighbour == @destination

          open.delete(neighbour) if open.key?(neighbour) && cost < open[neighbour]
          seen.delete(neighbour) if seen.key?(neighbour) && cost < seen[neighbour]

          if !open.key?(neighbour) && !seen.key?(neighbour)
            open[neighbour] = cost
          end
        end
      end
    end

    def h(n)
      character_difference(n, @destination)
    end

    def character_difference(source, destination)
      source.chars.zip(destination.chars).select { |(a, b)| a != b }.count
    end

    def neighbours_of(n)
      @neighbours_of_proc.call(n)
    end
  end
end
