#include('Draft_1_4.pl').

% Ensure that if Never-Married , no past state can have Married, Dovirced, Separated
   anti_member_3(_,[]).
   
   anti_member_3(X,[M|T]):- message(M), anti_member_3(X,T). %To pass messages <-D1 or <-C
   % Only works for 3 member data
   %anti_member_3(X,[state(time(_),[_,H,_])|T]):- X \= H, anti_member_3(X,T).
   anti_member_3(X,[state(_,[H,_,_,_,_])|T]):- X \= H, anti_member_3(X,T).

%?- anti_member_3(h,[state(1,[a,b,c]),'<-D1',state(1,[d,e1,f]),'<-D2',state(3,[g,h1,i])]).
#show no_never_married/1.
#show condition_never_married/2.


%condition_never_married(X, L):- X = 'Married-civ-spouse', anti_member_3(X,L).
%condition_never_married(X, L):- X = 'Married-spouse-absent', anti_member_3(X,L).
%condition_never_married(X, L):- X = 'Divorced', anti_member_3(X,L).
%condition_never_married(X, L):- X = 'Separated', anti_member_3(X,L).
%condition_never_married(X, L):- X = 'Married-AF-spouse', anti_member_3(X,L).
%condition_never_married(X, L):- X = 'Widowed', anti_member_3(X,L).
condition_never_married(X, L):- X \= 'Never-married', anti_member_3(X,L).

is_no_never_married(L):- condition_never_married('Married-civ-spouse',L),
  condition_never_married('Married-spouse-absent',L),
  condition_never_married('Married-AF-spouse',L),
  condition_never_married('Separated',L),
  condition_never_married('Divorced',L),
  condition_never_married('Widowed',L).


check_if_not_married(X,_):- X \= 'Never-married'.
check_if_not_married(X,L):- X = 'Never-married', is_no_never_married(L).







% For the actual code




%?-L = [state(time(3),['Never-married',b,c,d,e]),'<-D1',state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], is_no_never_married(L).

%?-L = [state(time(3),['Never-married',b,c,d,e]),'<-D1',state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_not_married('Never-married',L).
%?-L = [state(time(3),['Never-married',b,c,d,e]),'<-D1',state(time(2),['Never-married',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_not_married('Never-married',L).

%?-L = [state(time(3),['Never-married',b,c,d,e]),'<-D1',state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_not_married('ah',L).


% Testing on real code
%?-L = [state(time(2),['Married-civ-spouse',0,9,'Other-relative','Male']),  '<-D4',state(time(1),['Married-civ-spouse',0,9,'Husband','Male'])]  , check_if_not_married('Never-married1',L).

%?-L = [state(time(2),['Married-civ-spouse',0,9,'Other-relative','Male']),  '<-D4',state(time(1),['Married-civ-spouse',0,9,'Husband','Male'])]  , check_if_not_married('Never-married',L).

%?-L = [state(time(2),['Never-married',0,9,'Other-relative','Male']),
%  '<-D4',state(time(1),['Never-married',0,9,'Husband','Male'])]  , check_if_not_married('Never-married',L).




%?-L = [state(time(2),['Married-civ-spouse',0,9,'Other-relative','Male']),
%  '<-D4',state(time(1),['Married-civ-spouse',0,9,'Husband','Male'])]  , check_if_not_married('Never-married',L).

%?-L = [state(time(2),['Married-civ-spouse',0,9,'Other-relative','Male']),
%  '<-D4',state(time(1),['Married-civ-spouse',0,9,'Husband','Male'])]  , check_if_not_married('ah',L).


%?-L = [state(time(2),['Never-married',0,9,'Other-relative','Male']),
%  '<-D4',state(time(1),['Never-married',0,9,'Husband','Male'])]  , check_if_not_married('Never-married',L).