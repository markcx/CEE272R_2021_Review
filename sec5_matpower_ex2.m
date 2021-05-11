%
% %%%%%% CHANGE YOUR PATH %%%%%%%%%%
% addpath('/afs/ir.stanford.edu/users/m/a/markcx/Downloads/matpower7.1/')
%
clc; clear;
%% Matpower call for case3.m example:
% This is the main routine. You must define all your input parameters 
% (r12, x12, ...) to the function case3.m before calling it.

%%%%%%%%%%%%%%%%%
% DEFINE YOUR VARIABLES HERE
%%%%%%%%%%%%%%%%%
r12 = 1;
x12 = 2;
b12 = 0.02;
r13 = 2;
x13 = 1.5;
b13 = 0;
r23 = 1.1;
x23 = 1.0;
b23 = 0.05;
P_load = 150;
Q_load = 100;
gen1_cost = 20;
gen2_cost = 12;
mpopt = mpoption('pf.alg', 'FDXB', 'pf.tol', 1e-4);
% mpopt = mpoption(mpopt, 'opf.dc.solver', 'CPLEX', 'verbose', 2);

%%%%%%%%%%%%%%%%%
% FUNCTION CALL
mpc = case3(r12, x12, b12, r13, x13, b13, r23, x23, b23, P_load, Q_load, ...
                gen1_cost, gen2_cost, 1000, 1000, 1000, 1000, 360, 360, 360);
%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%
% SOLVING POWER FLOW
res_pf = runpf(mpc, mpoption(mpopt, 'VERBOSE', 0));
% NOTE: res_pf is type "struct". In order to access the results of the
% runpf function you have to type "res_pf.field", where field is the name
% of the field you want to access from the struct. E.g. res_pf.gen(1,PG)
% Check the Matpower_Documentation file on coursework for more information
%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%
% SOLVING OPTIMAL POWER FLOW
res_opf = runopf(mpc, mpoption(mpopt, 'VERBOSE', 0));
% NOTE: res_opf is type "struct". In order to access the results of the
% runopf function you have to type "res_opf.field", where field is the name
% of the field you want to access from the struct. E.g. res_ppf.gen(1,PG)
% Check the Matpower_Documentation file on coursework for more information
%%%%%%%%%%%%%%%%%%
