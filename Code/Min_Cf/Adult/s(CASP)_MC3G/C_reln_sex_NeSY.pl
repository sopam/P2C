

% Constraint rules that restrict age and sex for relationship
	constraint_reln_sex('Husband',Y, cost(_,0)):- Y = 'Male'.
% There is no rule for wife, so we put a rule to allow the same
	constraint_reln_sex('Wife',Y, cost(_,0)):- Y= 'Female'.
% Add the rule to catch all other cases
	constraint_reln_sex(X,_, cost(Inp,Inp)):- X \= 'Husband', X \= 'Wife'.

%?-f_domain(relationship,X), f_domain(sex, Y), constraint_reln_sex(X,Y,cost(1,Opt)).