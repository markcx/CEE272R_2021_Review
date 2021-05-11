clc; clear;
% %%%%%% CHANGE YOUR PATH %%%%%%%%%%
% addpath('/afs/.ir.stanford.edu/users/m/a/markcx/Downloads/cvx_maci64/')

% problem data
PL =20; %load
CQ = [3;2]; %cost; coefficients of quadratic terms
CL = [1;10]; %cost; coefficients of linear terms
F = 6; %line capacity
% define the optimization problem
cvx_begin
    variable PG(2); % optimization variables: PG1 and PG2
    variable P12(1); % optimization variables: P12
    dual variable lmp1; % lagrange multiplier for power balance at bus 1
    dual variable lmp2; % lagrange multiplier for power balance at bus 2
    minimize(PG'* diag(CQ) *PG + PG'*CL); % objective function
                                          % compact form of
                                          % CQ(1)*PG(1)^2+CL(1)*PG(1)
                                          %+CQ(2)*PG(2)^2+CL(2)*PG(2)
    subject to
        lmp1 : PG(1) == P12; % lagrange multiplier : constraint
        lmp2 : PG(2) + P12 == PL;
        -F <= P12 <= F;
cvx_end
% solution
disp(PG), disp(P12) % optimal dispatch and flow
disp(cvx_optval) % optimal cost
disp(lmp1), disp(lmp2) % LMPs
