/*
 * Figure out sequence of nand gates, f(x), given an input/output sequence
 * We only settle 1 bit nand
 * the xor-sbox network we try to figure out involves an xor operation with
 * a key, followed by the sbox operation after the xor operation.
 * the sbox does this mapping {0: 1, 1: 2, 2: 3, 3: 0}
 */
:- use_module('../metagol').

% metagol settings
metagol:max_clauses(100).
metagol:unfold_program.


% predicates used 
prim(nand/2). % 2-arity

% background knowledge
% preserve 2-arity
%% nand(0000, 0011).
%% nand(0001, 0011).
%% nand(0010, 0011).
%% nand(0011, 0011).
nand(a, d).
nand(b, d).
nand(c, d).
nand(d, d).

%% nand(0100, 0011).
%% nand(0101, 0010).
%% nand(0110, 0011).
%% nand(0111, 0010).
nand(e, d).
nand(f, c).
nand(g, d).
nand(h, c).

%% nand(1000, 0011).
%% nand(1001, 0011).
%% nand(1010, 0001).
%% nand(1011, 0001).
nand(i, d).
nand(j, d).
nand(k, b).
nand(l, b).

%% nand(1100, 0011).
%% nand(1101, 0010).
%% nand(1110, 0001).
%% nand(1111, 0000).
nand(m, d).
nand(n, c).
nand(o, b).
nand(p, a).

% metarules 
metarule([P, Q], [P, A, B]:-[[Q, A, B]]). % identity
metarule([P, Q], [P, A, B]:-[[Q, B, A]]). % inverse
metarule([P, Q, R], [P, A, B]:-[[Q, A, C],[R, C, B]]). % chain



% learn 
/*
[0]
0000 : 0001
0001 : 0010
0010 : 0011
0011 : 0000

[1]
0100 : 0010
0101 : 0001
0110 : 0000
0111 : 0011

[2]
1000 : 0011
1001 : 0000
1010 : 0001
1011 : 0010

[3]
1100 : 0000
1101 : 0011
1110 : 0010
1111 : 0001
*/


a :- 
  Pos = [
    p(a,b),
    p(b,c),
    p(c,d),
    p(d,a),
    
    p(e,c),
    p(f,b),
    p(g,a),
    p(h,d),

    p(i,d),
    p(j,a),
    p(k,b),
    p(l,c),

    p(m,a),
    p(n,d),
    p(o,c),
    p(p,b)
  ],
  Neg = [
  ],
  learn(Pos, Neg).
