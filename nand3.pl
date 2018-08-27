/*
 * Figure out sequence of nand gates, f(x), given an input/output sequence
 * We only settle 1 bit nand
 */
:- use_module('../metagol').

% metagol settings
metagol:max_clauses(100).
metagol:unfold_program.


% predicates used 
prim(nand/3). % 3-arity

% background knowledge
% preserve 2-arity
%% nand(0, 0, 1).
%% nand(0, 1, 1).
%% nand(1, 0, 1).
%% nand(1, 1, 0).

nand(a, b).
nand(b, b).
nand(c, b).
nand(d, a).

% metarules
metarule([P, Q], [P, A, B]:-[[Q, A, B]]).
metarule(mutual,[P,Q,R],([P,A]:-[[Q,A,B],[R,B]]),PS):-
  member(sym(R,1,_),PS). %% explicitly bind R to a symbol on the predicate signature


% learn 
a :- 
  Pos = [
    p(a,b),
    p(b,a)
  ],
  Neg = [
  ],
  learn(Pos, Neg).
