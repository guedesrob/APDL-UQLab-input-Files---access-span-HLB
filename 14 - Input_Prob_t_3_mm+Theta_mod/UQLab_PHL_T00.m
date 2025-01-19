% 1 - INITIALIZE UQLAB
%
% Clear all variables from the workspace, set the random number generator
% for reproducible results, and initialize the UQLab framework:
tic         % Inicia o contador de Tempo
clearvars
rng(1,'twister')
uqlab
clc

global iter
iter=0;

% 2. Minha FEL
modelOpts.mFile = 'LSF';
modelOpts.isVectorized = false;
modelOpts.Format = {'%1.8f'};
modelOpts.Display = 'verbose';
myModel = uq_createModel(modelOpts);
%

% 3 - PROBABILISTIC INPUT MODEL

% BARRAS 1 A 6 (H-H)
% T1X
InputOpts.Marginals(1).Name    = ['X', num2str(1)];
InputOpts.Marginals(1).Type    = 'Gaussian';
InputOpts.Marginals(1).Moments = 0.015875*[1 0.02];
InputOpts.Marginals(1).Bounds = [1e-5 inf];
% T2X
InputOpts.Marginals(2).Name    = ['X', num2str(2)];
InputOpts.Marginals(2).Type    = 'Gaussian';
InputOpts.Marginals(2).Moments = 0.009525*[1 0.02];
InputOpts.Marginals(2).Bounds = [1e-5 inf];

% BARRAS 7 e 15 (J-J)
% T1X
InputOpts.Marginals(3).Name    = ['X', num2str(3)];
InputOpts.Marginals(3).Type    = 'Gaussian';
InputOpts.Marginals(3).Moments = 0.0127*[1 0.02];
InputOpts.Marginals(3).Bounds = [1e-5 inf];
% T2X
InputOpts.Marginals(4).Name    = ['X', num2str(4)];
InputOpts.Marginals(4).Type    = 'Gaussian';
InputOpts.Marginals(4).Moments = (0.0127+0.003)*[1 0.02];
InputOpts.Marginals(4).Bounds = [1e-5 inf];
y4=(0.0127-(0.0127+0.0125))/((0.0127+0.0125)*.02);

% T3X
InputOpts.Marginals(5).Name    = ['X', num2str(5)];
InputOpts.Marginals(5).Type    = 'Gaussian';
InputOpts.Marginals(5).Moments = 0.009525*[1 0.02];
InputOpts.Marginals(5).Bounds = [1e-5 inf];

% BARRAS 8, 11 e 14 (B-B)
% T1X
InputOpts.Marginals(6).Name    = ['X', num2str(6)];
InputOpts.Marginals(6).Type    = 'Gaussian';
InputOpts.Marginals(6).Moments = 0.009525*[1 0.02];
InputOpts.Marginals(6).Bounds = [1e-5 inf];
% T2X
InputOpts.Marginals(7).Name    = ['X', num2str(7)];
InputOpts.Marginals(7).Type    = 'Gaussian';
InputOpts.Marginals(7).Moments = (0.009525+0.003)*[1 0.02];
InputOpts.Marginals(7).Bounds = [1e-5 inf];
y7=(0.009525-(0.009525+0.0125))/((0.009525+0.0125)*.02);

% T3X
InputOpts.Marginals(8).Name    = ['X', num2str(8)];
InputOpts.Marginals(8).Type    = 'Gaussian';
InputOpts.Marginals(8).Moments = 0.009525*[1 0.02];
InputOpts.Marginals(8).Bounds = [1e-5 inf];

% BARRAS 9, 10, 12 e 13 (G-G)
% T1X
InputOpts.Marginals(9).Name    = ['X', num2str(9)];
InputOpts.Marginals(9).Type    = 'Gaussian';
InputOpts.Marginals(9).Moments = 0.009525*[1 0.02];
InputOpts.Marginals(9).Bounds = [1e-5 inf];
% T2X
InputOpts.Marginals(10).Name    = ['X', num2str(10)];
InputOpts.Marginals(10).Type    = 'Gaussian';
InputOpts.Marginals(10).Moments = (0.009525+0.003)*[1 0.02];
InputOpts.Marginals(10).Bounds = [1e-5 inf];
y10=(0.009525-(0.009525+0.0125))/((0.009525+0.0125)*.02);

% T3X
InputOpts.Marginals(11).Name    = ['X', num2str(11)];
InputOpts.Marginals(11).Type    = 'Gaussian';
InputOpts.Marginals(11).Moments = 0.009525*[1 0.02];
InputOpts.Marginals(11).Bounds = [1e-5 inf];

% BARRAS 16,17 (E-E)
% T1X
InputOpts.Marginals(12).Name    = ['X', num2str(12)];
InputOpts.Marginals(12).Type    = 'Gaussian';
InputOpts.Marginals(12).Moments = 0.015875*[1 0.02];
InputOpts.Marginals(12).Bounds = [1e-5 inf];
% T2X
InputOpts.Marginals(13).Name    = ['X', num2str(13)];
InputOpts.Marginals(13).Type    = 'Gaussian';
InputOpts.Marginals(13).Moments = (0.015875+0.003)*[1 0.02];
InputOpts.Marginals(13).Bounds = [1e-5 inf];
y13=(0.015875-(0.015875+0.0095))/((0.015875+0.0095)*.02);

% T3X
InputOpts.Marginals(14).Name    = ['X', num2str(14)];
InputOpts.Marginals(14).Type    = 'Gaussian';
InputOpts.Marginals(14).Moments = 0.009525*[1 0.02];
InputOpts.Marginals(14).Bounds = [1e-5 inf];

% E
InputOpts.Marginals(15).Name    = ['X', num2str(15)];
InputOpts.Marginals(15).Type    = 'Gaussian';
InputOpts.Marginals(15).Moments = 195.8E9*[1 .076];
InputOpts.Marginals(15).Bounds = [1e-5 inf];
y15=(7.423790e+10-195.8E9)/(195.8E9*.076);

% fy
InputOpts.Marginals(16).Name    = ['X', num2str(16)];
InputOpts.Marginals(16).Type    = 'Lognormal';
InputOpts.Marginals(16).Moments = 260.94E6*[1 .087];
InputOpts.Marginals(16).Bounds = [1e-5 inf];
y16=(260.94E6-260.94E6)/(260.94E6*0.087);

% Load Line P (N)- Imai Frangopol/ Hwang Kim 2009
InputOpts.Marginals(17).Name = ['X', num2str(17)];
InputOpts.Marginals(17).Type = 'Gumbel';    
InputOpts.Marginals(17).Moments = [570.99E3 20.657E3];
InputOpts.Marginals(17).Bounds = [1e-5 inf];
y17=(400E3-489.30E3)/(489.30E3*0.054);

% Uniform Load Q (N/m)- Imai Frangopol/ Hwang Kim 2009
InputOpts.Marginals(18).Name = ['X', num2str(18)];
InputOpts.Marginals(18).Type = 'Gumbel';    
InputOpts.Marginals(18).Moments = [31.973E3 1.156E3];
InputOpts.Marginals(18).Bounds = [1e-5 inf];
y18=(25E3-27.40E3)/(27.40E3*0.053);

% Var Erro de Modelo (Adm)- Sorensen
InputOpts.Marginals(19).Name = ['X', num2str(19)];
InputOpts.Marginals(19).Type = 'Lognormal';    
InputOpts.Marginals(19).Moments = 1*[1 0.03];
InputOpts.Marginals(19).Bounds = [1e-5 inf];

% Create the INPUT object
myInput = uq_createInput(InputOpts);
%

% 5 - RELIABILITY ANALYSIS USING AK-MCS

% Select the reliability analysis technique:
AKOptions.Type = 'Reliability';
AKOptions.Method = 'AKMCS';
% 
% 
% Specify the maximum number of sample points
% added to the experimental design:
% AKOptions.AKMCS.MaxAddedED = 1000;

% Specify the initial experimental design:
X_ED=uq_getSample(60,'LHS');

% 
Y_ED=uq_evalModel(myModel,X_ED);
AKOptions.AKMCS.IExpDesign.X=X_ED;
AKOptions.AKMCS.IExpDesign.G=Y_ED;

% % AKOptions.AKMCS.IExpDesign.N = 0;
% % AKOptions.AKMCS.IExpDesign.Sampling = 'LHS';
AKOptions.Simulation.MaxSampleSize = 1E6;

% % Specify the meta-model options
% % (*note*: all Kriging options are supported):
AKOptions.AKMCS.Kriging.Corr.Family = 'Gaussian';

% % Specify the trend Option
% % for the adaptive experimental design algorithm
AKOptions.AKMCS.Kriging.Trend.Type = 'linear';


% % Specify the convergence criterion
% % for the adaptive experimental design algorithm
% AKOptions.AKMCS.Convergence = 'stopPf';
AKOptions.AKMCS.Convergence = 'stopBeta';

% % Specify the Estimation method
% % for the adaptive experimental design algorithm
AKOptions.AKMCS.Kriging.EstimMethod = 'ML';


% % Run the analysis:
AKAnalysis = uq_createAnalysis(AKOptions);



% %
% % Print out a report of the analysis:
uq_print(AKAnalysis)
uq_print(AKAnalysis.Results.Kriging)


% %
% % Create a graphical representation of the results:
uq_display(AKAnalysis)

% %
elapsed_time = toc;         % Para o contador e obt�m o tempo decorrido em segundos
elapsed_time_in_minutes = elapsed_time / 60;   % Converte o tempo decorrido para minutos
disp(['Tempo decorrido: ', num2str(elapsed_time_in_minutes), ' minutos']);


save('results_AKMCS.mat');