/*
 * Test on simple logic
 */

/* A featherless biped is a human */
human(featherless_biped).

/* all humans are mortal */
mortal(X) :- human(X).

/* is featherless biped mortal */
?- mortal(featherless_biped).

/* run with prolog 
 * use_module(test).
 */