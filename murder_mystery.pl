/*....facts....*/
person(alice).
person(husband).
person(son).
person(daughter).
person(brother).

child(son).
child(daughter).

male(husband).
male(son).
male(brother).

female(alice).
female(daughter).

twin(alice,brother).
twin(brother,alice).
twin(son,daughter).
twin(daughter,son).

/*....rules....*/
istwin(X):-twin(X,_).

older(alice,son).
older(alice,daughter).
older(husband,son).
older(husband,daughter).

inbar(M,N):-person(M),person(N),male(M),female(N).
together(S,T):-S=alice,T=husband.
together(S,T):-T=alice,S=husband.

alone(P):-person(P),child(P).

/*....rule combining clues....*/
solution(Killer,Victim,InbarA,InbarB,Alone):-person(Killer),person(Victim),
    /*..the victims twin was innocent..*/
        istwin(Victim),\+twin(Victim,Killer),

    /*..The killer was younger than the victim..*/
    \+older(Killer,Victim),
        /*..not the same as "older(Victim,Killer)"!..*/

    /*..Alice and her husband were not together at the murder time..*/
        \+together(Killer,Victim),Killer \= Victim,

    /*..A man and a women were together at the time of murder..*/
        inbar(InbarA, InbarB),
    InbarA \=Killer,InbarB \= Killer,
    InbarA \=Victim,InbarB \= Victim,

    /*..Alice and her husband were not together at murder time..*/
        \+ together(InbarA,InbarB),

    /*..One of the children was alone at the murder time..*/
    alone(Alone),
    Alone \= InbarA, Alone \= InbarB,
    Alone \= Killer, Alone \= Victim.

/*....goal....*/
print_solution:-
    /*..find the solution */
        solution(Killer,Victim,Inbara,InbarB,Alone),
    /*..Write solution..*/
    n1,write(Killer),write("killed"),write(Victim),
write("."),n1,
    write(InbarA),write("and"),write(InbarB),
    write("were together in the bar.").n1,
    write(Alone),write("was alone.").n1,n1.





