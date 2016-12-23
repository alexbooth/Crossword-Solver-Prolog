Jackson Mandeville
Theo Chitayat
Alexander Booth

Using Prolog, a language based on propositional logic, we constructed a basic crossword puzzle solver, using a simple natural language processor to understand simple clues.

There are two versions; the first does not consider any clues. It treats the puzzle as a constraint problem, using a provided dictionary to give all possible answers to a given board. The board is defined by hardcoding the length of each line as well as the intersection points between words.
The second uses triples and natural language processing to understand straightforward clues such. For example, the clue "a yellow fruit" will produce all words in the dictionary whose color property is yellow, and has the property of being a fruit. While this could create multiple answers, it uses the length of the blanks and intersection letter to determine the correct choice (though there could still be multiple answers, it is much less likely than before).

For the crossword solver that doesn't use clues:

Load file cw_no_clues.pl in SWI-PL
?- [cw_no_clue].

To find a solution to the fruit crossword:
?- fruits_cw(W1,W2,W3,W4,W5).

To find a solution to our custom_cw:
?- my_cw(W1,W2,W3,W4,W5,W6,W7,W8,W9).

To find a solution to the other_cw:
?- other_cw(W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12).

Notice that there are multiple solutions to the fruit crossword and our custom crossword.
We purposefully added words to our word bank which would cause these puzzles to have more
than one answer. In a crossword, length and intersections aren't good enough constraints
to solve a puzzle unambiguously.

To solve this issue, we created another program, cw_with_clues.pl, that parses language 
in an attempt to prune the domain of possible solutions to a crossword. 


Load file cw_with_clues.pl in SWI-PL
?- [cw_with_clues].

To find a solution to fruit_cw:
fruits_cw(W1,W2,W3,W4,W5).

To find a solution to our custom_cw:
other_cw(W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12).

Notice that our program now finds a single solution to each of these crosswords.



