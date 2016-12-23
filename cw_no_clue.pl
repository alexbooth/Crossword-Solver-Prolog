%% Copyright (c) 2016 Jackson Mandeville, Theo Chitayat, Alexander Booth

%% Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

%% The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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
	word(W5, _, 6).
	
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
	word(W9, _, 3).

	
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
