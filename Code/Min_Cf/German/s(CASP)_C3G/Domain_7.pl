f_domain(checking_account_status, 'less_than0').
f_domain(checking_account_status, 'no_checking_account').
f_domain(checking_account_status, '0equalsless_than_and_less_than200').
f_domain(checking_account_status, 'greater_than200').
f_domain(credit_history, 'critical_account').
f_domain(credit_history, 'existing_dues_cleared_for_now').
f_domain(credit_history, 'delay_in_paying_off').
f_domain(credit_history, 'none_taken/all_dues_cleared').
f_domain(credit_history, 'all_dues_atbank_cleared').
f_domain(property, 'real_estate').
f_domain(property, 'building_society/savings_agreement/life_insurance').
f_domain(property, 'unknown/no_property').
f_domain(property, 'car_or_other').
f_domain(duration_months, X) :- X .>=. 4, X .=<. 72.
f_domain(credit_amount, X) :- X .>=. 250, X .=<. 18424.
f_domain(present_employment_since, 'greater_than7').
f_domain(present_employment_since, '4equalsless_than_and_less_than7').
f_domain(present_employment_since, '1equalsless_than_and_less_than4').
f_domain(present_employment_since, 'less_than1').
f_domain(present_employment_since, 'unemployed').
f_domain(job, 'skilled_employee/official').
f_domain(job, 'unskilled-resident').
f_domain(job, 'management/self-employed/highly_qualified/officer').
f_domain(job, 'unemployed/unskilled-non_resident').
