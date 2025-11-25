f_domain(marital_status, 'Married-civ-spouse').
f_domain(marital_status, 'Married-spouse-absent').
f_domain(marital_status, 'Never-married').
f_domain(marital_status, 'Divorced').
f_domain(marital_status, 'Separated').
f_domain(marital_status, 'Married-AF-spouse').
f_domain(marital_status, 'Widowed').
f_domain(capital_gain, X) :- X .>=. -4356, X .=<. 99999.
f_domain(education_num, X) :- X .>=. 1, X .=<. 16.
f_domain(relationship, 'Husband').
f_domain(relationship, 'Wife').
f_domain(relationship, 'Not-in-family').
f_domain(relationship, 'Own-child').
f_domain(relationship, 'Unmarried').
f_domain(relationship, 'Other-relative').
f_domain(sex, 'Male').
f_domain(sex, 'Female').
