function mpc = case3(r12, x12, b12, r13, x13, b13, r23, x23, b23, ...
                    P_load, Q_load, gen1_cost, gen2_cost, Pmax1, Qmax1, Pmax2, Qmax2, ...
                    br_12_da_max, br_13_da_max, br_23_da_max)

%CASE9    Power flow data for 9 bus, 3 generator case.
%   Please see CASEFORMAT for details on the case file format.
%
%   Based on data from Joe H. Chow's book, p. 70.

%   MATPOWER
%   $Id: case9.m,v 1.11 2010/03/10 18:08:14 ray Exp $

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 1000;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
	1       3	0       0   	0	0	1	1	0	20	1	1.1	0.9;
	2       1	0       0       0	0	1	1	0	20	1	1.1	0.9;
	3   	1	P_load	Q_load	0	0	1	1	0	20	1	1.1	0.9;
];

%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	 Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	0	0	Qmax1	-300	1	100     1       Pmax1    10      0	  0      0       0       0       0       0       0	0	0	0;
	2	0 	0	Qmax2	-300	1	100     1       Pmax2    10      0    0      0       0       0       0       0       0	0	0	0;
];

%% branch data
%	fbus	tbus	r	x	b       rateA	rateB	rateC	ratio	angle
%	status	angmin	angmax
mpc.branch = [
	1       2       r12	x12	b12     250     250     250     0       0       1       -360	br_12_da_max;
	1       3       r13	x13	b13     250     250     250     0       0       1       -360	br_13_da_max;
    2       3       r23	x23	b23     150     150     150     0       0       1       -360	br_23_da_max;
];

%%-----  OPF Data  -----%%
%% area data
%	area	refbus
mpc.areas = [
	1	1;
];

%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	1500	0	length(gen1_cost)	gen1_cost;
   	2	1500	0	length(gen2_cost)	gen2_cost;
];