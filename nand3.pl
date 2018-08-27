/*
 * Figure out sequence of nand gates, f(x), given an input/output sequence
 * We only settle 1 bit nand
 */
:- use_module('../metagol').

% metagol settings
metagol:max_clauses(100).
metagol:unfold_program.


% predicates used 
prim(nand/2). % 2-arity

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
metarule([P, Q], [P, A, B]:-[[Q, A, B]]). % identity
metarule([P, Q], [P, A, B]:-[[Q, B, A]]). % inverse
metarule([P, Q, R], [P, A, B]:-[[Q, A, C],[R, C, B]]). % chain



% learn 
a :- 
  Pos = [
    p(b,a),
    p(a,b)
  ],
  Neg = [
  ],
  learn(Pos, Neg).
