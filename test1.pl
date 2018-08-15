:- use_module('../metagol').

/* TODO
 * Sbox - xor rep
 * universal gate representaion
 * xor + and 
 * nand
 */

%% First order background knowledge
/* facts
 * 	XOR
 *  0 0 0 
 *  0 1 1
 *  1 0 1
 *  1 1 0 
 */
xor(0,0,1).
xor(0,1,1).
xor(1,0,1).
xor(1,1,0).

/* facts
 * SBOX
 * 0 0 0 1
 * 0 1 1 0
 * 1 0 1 1
 * 1 1 0 0
 */
 sbox(0,0,0,1).
 sbox(0,1,1,0).
 sbox(1,0,1,1).
 sbox(1,1,0,0).

%% predicates that can be used in learning

%% metarules
metarule([P,Q],([P,A,B]:-[Q,A,B])).

%% learning task
a :- 
  Pos = [
  ],
  Neg = [
  ],
  learn(Pos,Neg).
  
