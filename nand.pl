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

%% metagol settings
metagol:max_clauses(100).

%% Learned program should be unfolded to remove unnecessary 
%% invented predicates
metagol:unfold_program.

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
 *  00 00 11
 *  00 01 11
 *  00 10 11
 *  00 11 11

 *  01 00 11
 *  01 01 10
 *  01 10 11
 *  01 11 10

 *  10 00 11
 *  10 01 11
 *  10 10 01
 *  10 11 01

 *  11 00 11
 *  11 01 10
 *  11 10 01
 *  11 11 00
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

%% metarules
metarule([P, Q], ([P, A, B, C]:-[[Q, A, B, C]])).
metarule([P, Q], ([P, A, B]:-[[Q, A, A, B]])).
metarule([P, Q, R, S], ([P, A, B, C, D]:-[[R, A, B, E], [S, C, D, F], [Q, E, F, G]])).


%% learning task
a :- 
  Pos = [
    %% key = 0
  	p(a, a, b),
  	p(a, b, c),
  	p(a, c, d),
  	p(a, d, a)

    %% key = 1
    %% p(b, a, c),
    %% p(b, b, b),
    %% p(b, c, a),
    %% p(b, d, d),

    %% %% key = 2
    %% p(c, a, d),
    %% p(c, b, a),
    %% p(c, c, b),
    %% p(c, d, c),

    %% %% key = 3
    %% p(d, a, a),
    %% p(d, b, d),
    %% p(d, c, c),
    %% p(d, d, b)
  ],
  Neg = [
    p(a,a,c)
  ],
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
  
