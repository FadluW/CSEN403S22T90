:- dynamic word/2.

is_category(C):-
	word(_,C).
 
 categories(L):-	
	setof(C,is_category(C),L).

get_length([],[]).

get_length([H|T],Y):-
	get_length(T, Y),
	string_length(H,H1),
	member(H1,Y).

get_length([H|T],[H1|Y]):-
	get_length(T, Y),
	string_length(H,H1),
	\+member(H1,Y).
	
available_length(X):-
	setof(W,word(W,_),R1),
	get_length(R1,L),
	member(X,L).
	
pick_word(W,L,C):-
	word(W,C),
	available_length(L),
	string_length(W, L).
	
correct_letters([H|T],L2,[H|T1]):-
	member(H,L2),
	correct_letters(T,L2,T1).

correct_letters([H|T],L2,T1):-
	\+member(H,L2),
	correct_letters(T,L2,T1).

correct_letters([],Z,[]).

correct_positions([],_,[]).

correct_positions([H1|T1], [H1|T2], [H1|T3]):-
	correct_positions(T1, T2, T3).

correct_positions([H1|T1], [H2|T2], T3):-
	H1 \== H2,
	correct_positions(T1, T2, T3).

build_kb:-
	write("Welcome to Pro-Wordle!"),nl,
	write("----------------------"),nl,nl,
	build_help,nl,
	write("Done building the words database").
	
build_help:-
	write("Please enter a word and its category on seperate lines:"),nl,
	read(Word),
	( 	Word = done;
		read(Category),
		assert(word(Word, Category)),
		build_help
	).
