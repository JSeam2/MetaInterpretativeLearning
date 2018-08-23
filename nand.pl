/*
 * nand representation representation
 *
 * Test on a sequence of substitution boxes and xors
 * Uses 1 layer of (xor+sbox)
 * examples uses all keys
 * 
 * To use load program on prolog and run with
 * ?- a.
 */

/* This test requires metagol
 * https://github.com/metagol/metagol
 */
:- use_module('../metagol').
metagol:max_clauses(1000).


%% predicates that can be used in learning
prim(myNand/3).

%% definition of tokens
/*
 * 00 a
 * 01 b
 * 10 c
 * 11 d
 */

%% First order background knowledge
/* facts
 * 	NAND
 *  0 0 1 
 *  0 1 1
 *  1 0 1
 *  1 1 0 
 */

myNand(a, a, d).
myNand(a, b, d).
myNand(a, c, d).
myNand(a, d, d).

myNand(b, a, d).
myNand(b, b, c).
myNand(b, c, d).
myNand(b, d, c).

myNand(c, a, d).
myNand(c, b, d).
myNand(c, c, b).
myNand(c, d, b).

myNand(d, a, d).
myNand(d, b, c).
myNand(d, c, b).
myNand(d, d, a).

%% myNand(a, d).
%% myNand(b, d).
%% myNand(c, d).
%% myNand(d, d).
%% myNand(e, d).

%% myNand(f, c).
%% myNand(g, d).
%% myNand(h, c).
%% myNand(i, d).
%% myNand(j, d).

%% myNand(k, b).
%% myNand(l, b).
%% myNand(m, d).
%% myNand(n, c).
%% myNand(o, b).
%% myNand(p, a).

%% metarules
metarule([P, Q, R], ([[P, A, B], [Q, B, C]]:-[[R, A, C]])).

%% learning task
a :- 
  Pos = [
  	p(a, a, b),
  	p(a, b, c),
  	p(a, c, d),
  	p(a, d, a)
  ],
  Neg = [
  	p(a, b, a),
  ]
  learn(Pos, Neg).
%%
%% output
%% learning p/2
%% clauses: 1
%% p(A,B):-sbox(A,B).
%% true

%% a :- 
%%   Pos = [
%%    p(a, c),
%%    p(b, a),
%%    p(c, d),
%%    p(d, b)
%%   ],
%%   learn(Pos, []).
%%
%% output
%% learning p/2
%% clauses: 1
%% clauses: 2
%% clauses: 3
%% clauses: 4
%% clauses: 5
%% clauses: 6
%% false
  
