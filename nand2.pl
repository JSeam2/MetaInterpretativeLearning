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
metagol:max_clauses(100).


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

myNand(a, d).
myNand(b, d).
myNand(c, d).
myNand(d, d).

myNand(b, c).
myNand(d, c).

myNand(c, b).
myNand(d, b).

myNand(d, a).

metarule([P,Q],([P,A,B]:-[[Q,A,B]])). % identity
metarule([P,Q],([P,A,B]:-[[Q,B,A]])). % inverse
metarule([P,Q,X],([P,A,B]:-[[Q,A,B,X]])). % curry
metarule([P,Q,R],([P,A,B]:-[[Q,A],[R,A,B]])). % precon
metarule([P,Q,R],([P,A,B]:-[[Q,A,B],[R,B]])). % postcon


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
  
