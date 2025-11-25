
3) run.pl: Contains the qpery we need to run. The O_Effort .=. 2 specifies  cost of actions.
    To run, ensure that you are in the same directory as all the files
    Run by the following command in the terminal:
        scasp run.pl -s0
    
    The query specifies that we want a paths with a cost of 2. 
        ?- O_Effort .=. 2, T1 = 0, F1 = '2', F2 = 'med', F3 = 'high', F4 = 'high',  get_path(act(1,1,1,1),wei(1,1,1,1),time(T1),original(F1,F2,F3,F4), time(TN),counterfactual(Cf1,Cf2,Cf3,Cf4),[state(time(T1),[F1,F2,F3,F4])],Opt, 0, O_Effort).



    The query specifies that we want a paths with a cost of 2 and a path length of =< 4
        ?- O_Effort .=. 2, TN .=<. 4, T1 = 0, F1 = '2', F2 = 'med', F3 = 'high', F4 = 'high',  get_path(act(1,1,1,1),wei(1,1,1,1),time(T1),original(F1,F2,F3,F4), time(TN),counterfactual(Cf1,Cf2,Cf3,Cf4),[state(time(T1),[F1,F2,F3,F4])],Opt, 0, O_Effort).
