# Word Transform

Given a dictionary of words, a source word, and a destination, find the minimum number of single
character transformations from the source word to the destination where every interim step is a
valid word in the dictionary.

```sh
bundle install

./bin/min_distance_between hit cog bfs  # breadth-first algorithm
./bin/min_distance_between tiger stave ass  # A* algorithm
```

## My approach

A simple breadth first search through the possible moves in the dictionary was an obvious solution
to this problem. I would prefer to get a solution working quickly that I can iterate on than
over-optimise before the code even runs.

I created a `Dictionary` class to represent the set of words in the dictionary, which also knew how
to compute the neighbours of any of it's words. I then implemented a method on `Dictionary` called
`min_distance_between(source, destination)` which made use of a breadth first search to identify the
path length.

This was then spec'ed out in the dictionary test file, testing a few edge cases and maintaining a
single test that could give indications on how my algorithm performed.

Breadth first search at this point seemed like a sub-optimal solution to the problem, and so using
my dictionary specs as regression tests I refactored a `BreadthFirstSearch` class out of
`Dictionary`. Running the dictionary specs on each change gave me confidence that I hadn't broken
the algorithm, and from there I could settle on a clean public interface for a typical 'Searcher'.

After some thought I settled on the A\* algorithm for the next iteration. By using the character
difference between words as the algorithms heuristic function, I could guarantee that I would find
the shortest path (as h(n) <= real optimal path) and significantly reduce the computation in the
majority of cases.

With my dictionary spec file testing the `min_distance_between` method for a variety of cases, I
implemented a new `AStarSearch` class that implemented the algorithm, making dictionary use this as
it's underlying searcher. Once the tests still passed I felt a bit strange that the dictionary was
tasked with finding paths, and so refactored once more to have a class `MinDistanceFinder` that
could instrument `Dictionary` and a `Searcher` to find the minimum distance between words. I could
then easily create a spec for the `MinDistanceFinder` that made use of both my search
implementations.

## Checking my solution is correct

By writing tests to verify base and a few more complex cases, and selecting an algorithm that I was
confident in initially, I could develop upon a base implementation without too much worry of my
solution becoming invalid. At each stage I could verify that the changes I made didn't produce
different results than the previous algorithm, and that the only thing changing was the performance
of the code.

## Assumptions made

I've made a few assumptions in how the algorithm should work, by enforcing that the destination word
is inside the dictionary of words. This is in contrast to the spec sheet, which did not list 'cog'
as within the dictionary.


## Extra

To try and discover some larger transformation paths I created the `./all_valid_destinations_from`
script, which creates a bunch of workers that can hammer through a dictionary using the A\*
algorithm to find possible destinations from a single source word. This was really just a bit of
fun, and could be done in a much nicer way (no concurrency control on put'ing to STDOUT!!) but
served to produce a couple of larger paths that I could then use to benchmark my code.
