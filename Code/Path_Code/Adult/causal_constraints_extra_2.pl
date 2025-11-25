#include('causal_constraints_extra.pl').

% Check if the head of a list is not a given value

check_lst_head(X,[state(_,[H,_,_,_,_])|T]):- X \= H.

%?- check_lst_head(a,[state(1,[a,b,c,d,e]),'<-D1',state(1,[f,g,h,i,j]),'<-D2',state(3,[k,l,m,n,o])]).
#show no_never_married/1.
#show condition_never_married/2.


% Divorced

condition_divorced(X, L):- X = 'Widowed', check_lst_head(X,L).
condition_divorced(X, L):- X = 'Never-married', check_lst_head(X,L).



is_divorced(L):- condition_divorced('Widowed',L),condition_divorced('Never-married',L).


%?-L = [state(time(3),['Widowed',b,c,d,e]),'<-D1',state(time(2),['Separated',g,h,i,j])  
%    ,'<-D2',state(time(31),['Separated',l,m,n,o])], is_divorced(L).


check_if_divorced(X,_):- X \= 'Divorced'.
check_if_divorced(X,L):- X = 'Divorced', is_divorced(L).


%?-L = [state(time(3),['Never-married',b,c,d,e]),'<-D1',
%    state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_divorced('ah',L).

%?-L = [state(time(3),['Never-married',b,c,d,e]),'<-D1',
%    state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_divorced('Divorced',L).

%?-L = [state(time(3),['Separated',b,c,d,e]),'<-D1',
%    state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_divorced('Divorced',L).



% Separated

condition_separated(X, L):- X = 'Widowed', check_lst_head(X,L).
condition_separated(X, L):- X = 'Never-married', check_lst_head(X,L).
condition_separated(X, L):- X = 'Divorced', check_lst_head(X,L).



is_separated(L):- condition_separated('Widowed',L),condition_separated('Never-married',L),condition_separated('Divorced',L).


%?-L = [state(time(3),['Never-married',b,c,d,e]),'<-D1',state(time(2),['Separated',g,h,i,j])  
%    ,'<-D2',state(time(31),['Separated',l,m,n,o])], is_separated(L).


check_if_separated(X,_):- X \= 'Separated'.
check_if_separated(X,L):- X = 'Separated', is_separated(L).


%?-L = [state(time(3),['Never-married',b,c,d,e]),'<-D1',
%    state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_separated('ah',L).

%?-L = [state(time(3),['Never-married',b,c,d,e]),'<-D1',
%    state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_separated('Separated',L).

%?-L = [state(time(3),['Divorced',b,c,d,e]),'<-D1',
%    state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_separated('Separated',L).

%?-L = [state(time(3),['Married-civ-spouse',b,c,d,e]),'<-D1',
%    state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_separated('Separated',L).

%?-L = [state(time(3),['Separated',b,c,d,e]),'<-D1',
%    state(time(2),['Separated',g,h,i,j])  ,'<-D2',state(time(31),['Never-married',l,m,n,o])], check_if_separated('Separated',L).

