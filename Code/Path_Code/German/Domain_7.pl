#include('Draft_1_1.pl').

% Domain: 
    % We have restricted the domain to- checking_account_status:  { 'no_checking_account', '>=200'}
        f_domain(checking_account_status, 'no_checking_account').
        f_domain(checking_account_status, '>=200').

        f_domain(checking_account_status, '<0').
        f_domain(checking_account_status, '>=0_and_<200').


    % We have restricted the domain to- credit_history:  { 'no credits taken/ all credits paid back duly',  'all credits at this bank paid back duly'}
        f_domain(credit_history, 'no credits taken/ all credits paid back duly').
        f_domain(credit_history, 'all credits at this bank paid back duly').
        
        f_domain(credit_history, 'existing credits paid back duly till now').
        f_domain(credit_history, 'delay in paying off in the past').
        f_domain(credit_history, 'critical account/  other credits existing (not at this bank)').
        
     % We have restricted the domain to- property: {'car or other', 'real estate'}
        f_domain(property, 'car or other').
        f_domain(property, 'real estate').
        
        f_domain(property, 'building society savings agreement/ life insurance').
        f_domain(property, 'no property').

    % duration_months: [4,72]
        f_domain(duration_months, X):- X .>=. 4, X .=<. 72.

    % credit_amount: [250,18424]
        f_domain(credit_amount, X):-  X .>=. 250, X .=<. 18424.




% Domain: 
    % We have restricted the domain to- present_employment_since:  { 'unemployed', '<1_year'}
        f_domain(present_employment_since, 'unemployed').
        f_domain(present_employment_since, '<1_year').
        
        f_domain(present_employment_since, '1=<_and_<4_years').
        f_domain(present_employment_since, '4=<_and_<7_years').
        f_domain(present_employment_since, '>=7_years').


    % We have restricted the domain to- job: {'unemployed/unskilled-non-resident', 'official/skilled-employee'}
        f_domain(job, 'unemployed/unskilled-non-resident').
        f_domain(job, 'official/skilled-employee').
        
        f_domain(job, 'unskilled-resident'). 
        f_domain(job, 'management/self-employed/highly qualified employee/officer').



%?- f_domain(age, X).