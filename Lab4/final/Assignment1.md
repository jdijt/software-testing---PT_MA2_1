# Assignment 1

> Read or reread Chapter 4 of The Haskell Road, and make a list of questions on specific points that cause difficulty of understanding.

### Mats

- Exercise 4.55) I do not understand what is wrong with the implementation of `insertSet`. It should already block duplicates.

### Nikki 

- Is there an easy way to remember the rules applying to the Cartesian product of Theorem 4.38? / How can I visualize it, see the logic behind it?

### Jasper

- The notion of list types presented at example 4.52 was a bit confusing for me. If I understood it correctly the type of `[]` can be different depending on context. E.g: `:t []` results in `[t]` however, extracting a `[]` element like this `:t ([[],[[[[]]]]] !! 0)` results in `[[[[t]]]]` so the `[]` actually represents a list of lists of lists of lists in that case. The question beeing, did I understand this correctly?
