%% Copyright (c) 2016 Jackson Mandeville, Theo Chitayat, Alexander Booth

%% Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

%% The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

% Language processing copied and adapted from "nl_interface_direct.pl"
% Copyright (c) David Poole and Alan Mackworth 2010.

% noun_phrase(T0,T4,Ind) is true if
%  T0 and T4 are list of words, such that
%        T4 is an ending of T0
%        the words in T0 before T4 (written T0-T4) form a noun phrase
%  Ind is an individual that the noun phrase is referring to

% A noun phrase is a determiner followed by adjectives followed
% by a noun followed by an optional modifying phrase:
noun_phrase(T0,T3,Ind) :-
    det(T0,T1,Ind),
    adjectives(T1,T2,Ind),
    noun(T2,T3,Ind).

% Determiners (articles) are ignored in this oversimplified example.
% They do not provide any extra constraints.
det([the | T],T,_).
det([a | T],T,_).
det([an | T],T,_).
det(T,T,_).

% Conjunctions are ignored in this oversimplified example.
% They do not provide any extra constraints.
conj([and | T],T,_).
conj([or | T],T,_).
conj(T,T,_).

% Adjectives consist of a sequence of adjectives.
% The meaning of the arguments is the same as for noun_phrase
adjectives(T0,T3,Ind) :-
    adj(T0,T1,Ind),
    conj(T1,T2,Ind),
    adjectives(T2,T3,Ind).
adjectives(T,T,_).

% question(Question,QR,Ind) is true if Question-QR is true of Ind
question([what, is | T0],T1,Ind) :-
    noun_phrase(T0,T1,Ind).

% ask(Q,A) gives answer A to question Q
ask(Q,A) :-
    question(Q,[],A).
    
% clue(Clue, CR, Ind) is true if Clue-CR is true of Ind
clue(T0,T1, Ind):-
	noun_phrase(T0, T1, Ind).

%% DICTIONARY

% adj(T0,T1,Ind) is true if T0-T1 is an adjective that is true of Ind
adj([sweet | T],T,Ind) :- sweet(Ind).
adj([Color | T],T,Ind) :- color(Ind, Color).
adj([Climate | T],T,Ind) :- climate(Ind, Climate).
adj([Size | T],T,Ind) :- size(Ind, Size).
adj([Time | T], T, Ind) :- time(Ind, Time).
adj([late, Time | T], T, Ind) :- time(Ind, Time).
adj([early, Time | T], T, Ind) :- time(Ind, Time).
adj([open | T], T, Ind) :- open(Ind).
adj([closed | T], T, Ind) :- closed(Ind).
adj([slip, on | T], T, Ind) :- slip_on(Ind).

% noun(T0,T1,Ind) is true if T0-T1 is a noun that is true of Ind
noun([fruit | T],T,Ind) :- fruit(Ind).
noun([weapon | T],T,Ind) :- weapon(Ind).
noun([shoe | T],T,Ind) :- shoe(Ind).
noun([cleaner | T],T,Ind) :- cleaner(Ind).
noun([animal | T], T, Ind) :- animal(Ind).
noun([meal | T], T, Ind) :- meal(Ind).
noun([food | T], T, Ind) :- food(Ind).
noun([clothing | T], T, Ind) :- clothing(Ind).
noun([beverage | T],T,Ind) :- drink(Ind).
noun([drink | T], T, Ind) :- drink(Ind).

%% WORD BANK

% word(W, List, Length) is true when word W has length Length and the letters of word are contained in List
word(apple, [a,p,p,l,e], 5).
word(pineapple, [p,i,n,e,a,p,p,l,e], 9).
word(orange, [o,r,a,n,g,e], 6).
word(cherry, [c,h,e,r,r,y], 6).
word(banana, [b,a,n,a,n,a], 6).

word(sandal, [s,a,n,d,a,l], 6).
word(crab, [c,r,a,b], 4).
word(ale, [a,l,e], 3).
word(panda, [p,a,n,d,a], 5).
word(dinner, [d,i,n,n,e,r], 6).
word(spear, [s,p,e,a,r], 5).
word(loafer, [l,o,a,f,e,r], 6).
word(bleach, [b,l,e,a,c,h], 6).
word(bear, [b,e,a,r], 4).
word(donkey, [d,o,n,k,e,y], 6).
word(breakfast, [b,r,e,a,k,f,a,s,t], 9).
word(apron, [a,p,r,o,n], 5).

word(hip, [h,i,p], 3).
word(ruby, [r,u,b,y], 4).
word(rat, [r,a,t], 3).
word(et, [e,t], 2).
word(erode, [e,r,o,d,e], 5).
word(or, [o,r], 2).
word(an, [a,n], 2).
word(irate, [i,r,a,t,e], 5).
word(put, [p,u,t], 3).
word(yard, [y,a,r,d], 4).
word(re, [r,e], 2).
word(oo, [o,o], 2).

%% DEFINITIONS

:- discontiguous food/1, fruit/1, sweet/1, color/2, size/2, animal/1, shoe/1, meal/1, time/2, climate/2.

% food(F) is true when F is a food.
% fruit(F) is true when F is a fruit.
% sweet(S) is true when S is sweet.
% color(W, C) is true when W has color C.
% size(W, S) is true when W has size S.
% animal(A) is true when A is an animal.
% shoe(S) is true when S is a shoe.
% meal(M) is true when M is a meal.
% time(Ind, T) is true when Ind has time T.
% climate(Ind, C) is true when Ind has climate C.

food(apple).
fruit(apple).
sweet(apple).
color(apple, red).
size(apple, medium).

food(banana).
fruit(banana).
sweet(banana).
climate(banana, tropical).
color(banana, yellow).
size(banana, small).
size(banana, medium).

food(orange).
fruit(orange).
color(orange, orange).

food(cherry).
fruit(cherry).
sweet(cherry).
color(cherry, red).
size(cherry, small).

food(pineapple).
fruit(pineapple).
sweet(pineapple).
climate(pineapple, tropical).
color(pineapple, yellow).
color(pineapple, brown).
size(pineapple, large).

animal(panda).
color(panda, white).
color(panda, black).
size(panda, big).

food(crab).
animal(crab).
color(crab, orange).
size(crab, small).
climate(crab, sea).

shoe(loafer).
color(loafer, brown).
color(loafer, black).
color(loafer, blue).
size(loafer, medium).
slip_on(loafer).

shoe(sandal).
size(sandal, small).
open(sandal).

drink(ale).
color(ale, brown).

meal(dinner).
time(dinner, night).

animal(bear).
color(bear, brown).
color(bear, black).
color(bear, white).
size(bear, big).

meal(breakfast).
time(breakfast, morning).

clothing(apron).

animal(donkey).
color(donkey, brown).
size(donkey, medium).

%% CROSSWORD SOLVER 

% intersection(W1, W2, I1, I2) is true if
% 	word W1 has an intersection with word W2
%	at index I1 for W1 and I2 for W2
%	indexes start at 0.
intersection(Word1, Word2, Index1, Index2):-
	dif(Word1, Word2),
	word(Word1, List1, Length1),
	nth0(Index1, List1, Letter),
	Index1 < Length1,
	word(Word2, List2, Length2),
	nth0(Index2, List2, Letter),
	Index2 < Length2.
	
% Implementation of the fruits crossword

% fruits_cw is true if W1, W2, W3, W4, W5
% 	are all words that fulfill the constrains
% 	of this crossword puzzle
fruits_cw(W1,W2,W3,W4,W5):-
	intersection(W1, W2, 0, 1),
	intersection(W1, W3, 2, 2),
	intersection(W1, W4, 4, 2),
	intersection(W1, W5, 8, 2),
	word(W1, _, 9),
	word(W2, _, 5),
	word(W3, _, 6),
	word(W4, _, 6),
	word(W5, _, 6),
	clue([a, large, tropical, fruit],[],W1),
	clue([a, sweet, red, fruit],[],W2),
	clue([a, yellow, fruit],[],W3),
	clue([an, orange, fruit],[],W4),
	clue([a, sweet, red, fruit],[],W5).
	
% Implementation of our custom crossword

% my_cw is true if W1, W2, W3, W4, W5, W6, W7, W8, W9, W10
% 	are all words that fulfill the constrains
% 	of this crossword puzzle
my_cw(W1,W2,W3,W4,W5,W6,W7,W8,W9):-
	intersection(W1, W9, 2, 0),
	intersection(W2, W5, 0, 1),
	intersection(W2, W6, 2, 2),
	intersection(W2, W7, 4, 1),
	intersection(W2, W8, 6, 0),
	intersection(W2, W9, 8, 2),
	intersection(W3, W7, 0, 3),
	intersection(W3, W8, 2, 2),
	intersection(W4, W7, 0, 5),
	intersection(W4, W8, 2, 4),
	word(W1, _, 4),
	word(W2, _, 9),
	word(W3, _, 6),
	word(W4, _, 6),
	word(W5, _, 5),
	word(W6, _, 6),
	word(W7, _, 6),
	word(W8, _, 5),
	word(W9, _, 3),
	clue([a, small, orange, sea, animal],[],W1),
	clue([a, large, tropical, fruit],[],W2),
	clue([a, late, night, meal],[],W3),
	clue([a, slip, on, shoe],[],W4),
	clue([a, sweet, red, fruit],[],W5),
	clue([a, yellow, fruit],[],W6),
	clue([an, open, shoe],[],W7),
	clue([a, black, and, white, animal],[],W8),
	clue([a, brown, beverage],[],W9).

	
% Implementation of the other crossword

% other_cw is true if W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12
% 	are all words that fulfill the constrains
% 	of this crossword puzzle
other_cw(W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12):-
	intersection(W1, W2, 1, 0),
	intersection(W1, W3, 2, 0),
	intersection(W2, W4, 1, 0),
	intersection(W2, W6, 2, 1),
	intersection(W2, W8, 3, 1),
	intersection(W2, W10, 4, 0),
	intersection(W3, W4, 1, 1),
	intersection(W3, W6, 2, 2),
	intersection(W4, W5, 3, 0),
	intersection(W5, W7, 1, 0),
	intersection(W5, W9, 2, 1),
	intersection(W5, W10, 3, 3),
	intersection(W6, W11, 0, 0),
	intersection(W8, W11, 0, 1),
	intersection(W12, W10, 1, 2),
	word(W1, _, 3),
	word(W2, _, 5),
	word(W3, _, 3),
	word(W4, _, 4),
	word(W5, _, 4),
	word(W6, _, 3),
	word(W7, _, 2),
	word(W8, _, 2),
	word(W9, _, 2),
	word(W10, _, 5),
	word(W11, _, 2),
	word(W12, _, 2).
