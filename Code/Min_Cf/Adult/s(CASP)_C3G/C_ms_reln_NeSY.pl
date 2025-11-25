
	%case_2(X):- X = 'Married-spouse-absent'.
	%case_2(X):- X = 'Never-married'.
    %case_2(X):- X = 'Divorced'.
    %case_2(X):- X = 'Separated'.
    %case_2(X):- X = 'Widowed'.



% Constraint rules identify causal relationships amongst features.
% They restrict the values taken for relationship(Y) and age(Z)
	constraint_ms_reln('Married-civ-spouse',Y, cost(Inp,Inp)):- Y = 'Husband'.
	constraint_ms_reln('Married-civ-spouse',Y, cost(Inp,Inp)):- Y = 'Wife'.
    constraint_ms_reln('Married-civ-spouse',Y, cost(Inp,Inp)):- Y = 'Own-child'.
    constraint_ms_reln('Married-civ-spouse',Y, cost(Inp,Inp)):- Y = 'Other-relative'.
    constraint_ms_reln('Married-civ-spouse',Y, cost(Inp,Inp)):- Y = 'Not-in-family'.


    % Original
    % Covers majority of the different marital_status types.

        % Commented out
            %constraint_ms_reln(married_spouse_absent,Y):- Y = not_in_family.
            %constraint_ms_reln(married_spouse_absent,Y):- Y = unmarried.
            %constraint_ms_reln(married_spouse_absent,Y):- Y = own_child.
            %constraint_ms_reln(married_spouse_absent,Y):- Y = other_relative.

            constraint_ms_reln('Never-married',Y, cost(Inp,Inp)):- Y = 'Not-in-family'.
            constraint_ms_reln('Never-married',Y, cost(Inp,Inp)):- Y = 'Unmarried'.
            constraint_ms_reln('Never-married',Y, cost(Inp,Inp)):- Y = 'Own-child'.
            constraint_ms_reln('Never-married',Y, cost(Inp,Inp)):- Y = 'Other-relative'.

            constraint_ms_reln('Divorced',Y, cost(Inp,Inp)):- Y = 'Not-in-family'.
            constraint_ms_reln('Divorced',Y, cost(Inp,Inp)):- Y = 'Unmarried'.
            constraint_ms_reln('Divorced',Y, cost(Inp,Inp)):- Y = 'Own-child'.
            constraint_ms_reln('Divorced',Y, cost(Inp,Inp)):- Y = 'Other-relative'.

            constraint_ms_reln('Separated',Y, cost(Inp,Inp)):- Y = 'Not-in-family'.
            constraint_ms_reln('Separated',Y, cost(Inp,Inp)):- Y = 'Unmarried'.
            constraint_ms_reln('Separated',Y, cost(Inp,Inp)):- Y = 'Own-child'.
            constraint_ms_reln('Separated',Y, cost(Inp,Inp)):- Y = 'Other-relative'.

            %constraint_ms_reln(widowed,Y):- Y = not_in_family.
            %constraint_ms_reln(widowed,Y):- Y = unmarried.
            %constraint_ms_reln(widowed,Y):- Y = own_child.
            %constraint_ms_reln(widowed,Y):- Y = other_relative.






        
        constraint_ms_reln('Widowed',Y, cost(Inp,Inp)):- Y = 'Not-in-family'.
        constraint_ms_reln('Widowed',Y, cost(Inp,Inp)):- Y = 'Unmarried'.
        constraint_ms_reln('Widowed',Y, cost(Inp,Inp)):- Y = 'Own-child'.
        constraint_ms_reln('Widowed',Y, cost(Inp,Inp)):- Y = 'Other-relative'.


        constraint_ms_reln('Married-spouse-absent',Y, cost(Inp,Inp)):- Y = 'Not-in-family'.
        constraint_ms_reln('Married-spouse-absent',Y, cost(Inp,Inp)):- Y = 'Unmarried'.
        constraint_ms_reln('Married-spouse-absent',Y, cost(Inp,Inp)):- Y = 'Own-child'.
        constraint_ms_reln('Married-spouse-absent',Y, cost(Inp,Inp)):- Y = 'Other-relative'.



	constraint_ms_reln('Married-AF-spouse',Y, cost(Inp,Inp)):- Y = 'Husband'.
	constraint_ms_reln('Married-AF-spouse',Y, cost(Inp,Inp)):- Y = 'Wife'.
    constraint_ms_reln('Married-AF-spouse',Y, cost(Inp,Inp)):- Y = 'Own-child'.
    constraint_ms_reln('Married-AF-spouse',Y, cost(Inp,Inp)):- Y = 'Other-relative'.

%?- constraint_ms_reln(X,Y,cost(1, Opt)).


