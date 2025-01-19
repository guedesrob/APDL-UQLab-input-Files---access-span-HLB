% 1 - INITIALIZE UQLAB
%
% Clear all variables from the workspace, set the random number generator
% for reproducible results, and initialize the UQLab framework:
tic         % Inicia o contador de Tempo
clearvars
rng(1,'twister')
uqlab
clc

global iter;
iter=0;

% 2. Minha FEL
modelOpts.mFile = 'LSF';
modelOpts.isVectorized = false;
modelOpts.Format = {'%1.8f'};
modelOpts.Display = 'verbose';
myModel = uq_createModel(modelOpts);
%

% 3 - PROBABILISTIC INPUT MODEL
%

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
% InputOpts.Marginals(4).Moments = (0.0127+0.0125)*[1 0.02];
InputOpts.Marginals(4).Moments = (0.0127)*[1 0.02];
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
% InputOpts.Marginals(7).Moments = (0.009525+0.0125)*[1 0.02];
InputOpts.Marginals(7).Moments = (0.009525)*[1 0.02];
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
% InputOpts.Marginals(10).Moments = (0.009525+0.0125)*[1 0.02];
InputOpts.Marginals(10).Moments = (0.009525)*[1 0.02];
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
% InputOpts.Marginals(13).Moments = (0.015875+0.0095)*[1 0.02];
InputOpts.Marginals(13).Moments = (0.015875)*[1 0.02];
InputOpts.Marginals(13).Bounds = [1e-5 inf];
y13=(0.015875-(0.015875+0.0095))/((0.015875+0.0095)*.02);
% T3X
InputOpts.Marginals(14).Name    = ['X', num2str(14)];
InputOpts.Marginals(14).Type    = 'Gaussian';
InputOpts.Marginals(14).Moments = 0.009525*[1 0.02];
InputOpts.Marginals(14).Bounds = [1e-5 inf];

% E Melchers e Beck Hermes Carvalho
InputOpts.Marginals(15).Name    = ['X', num2str(15)];
InputOpts.Marginals(15).Type    = 'Gaussian';
InputOpts.Marginals(15).Moments = 195.8E9*[1 .076];
InputOpts.Marginals(15).Bounds = [1e-5 inf];
y15=(8.019134e+10-195.8E9)/(195.8E9*.076);

% fy Melchers e Beck Hermes Carvalho
InputOpts.Marginals(16).Name    = ['X', num2str(16)];
InputOpts.Marginals(16).Type    = 'Lognormal';
InputOpts.Marginals(16).Moments = 260.94E6*[1 .087];
InputOpts.Marginals(16).Bounds = [1e-5 inf];
y16=(260.94E6-260.94E6)/(260.94E6*0.087);

% Create the INPUT object
myInput = uq_createInput(InputOpts);
%

% %% 4 - RELIABILITY ANALYSIS USING AK-MCS
% %
% % Select the reliability analysis technique:
AKOptions.Type = 'Reliability';
AKOptions.Method = 'AKMCS';

%
% Specify the initial experimental design:
AKOptions.AKMCS.IExpDesign.N = 120;
AKOptions.AKMCS.IExpDesign.Sampling = 'LHS';
% AKOptions.Simulation.MaxSampleSize = 1e6;

%
% Specify the meta-model options
% (*note*: all Kriging options are supported):
AKOptions.AKMCS.Kriging.Corr.Family = 'Gaussian';

%
% Specify the trend Option
% for the adaptive experimental design algorithm
AKOptions.AKMCS.Kriging.Trend.Type = 'linear';

%
% Specify the convergence criterion
% for the adaptive experimental design algorithm
AKOptions.AKMCS.Convergence = 'stopPf';
% AKOptions.AKMCS.Convergence = 'stopBeta';

%
% Specify the Estimation method
% for the adaptive experimental design algorithm
AKOptions.AKMCS.Kriging.EstimMethod = 'ML';

%
% Run the analysis:
AKAnalysis = uq_createAnalysis(AKOptions);

%
% Print out a report of the analysis:
uq_print(AKAnalysis)
uq_print(AKAnalysis.Results.Kriging)


%
% Create a graphical representation of the results:
uq_display(AKAnalysis)

%
elapsed_time = toc;         % Para o contador e obt�m o tempo decorrido em segundos
elapsed_time_in_minutes = elapsed_time / 60;   % Converte o tempo decorrido para minutos
disp(['Tempo decorrido: ', num2str(elapsed_time_in_minutes), ' minutos']);

%
save('resultados_AKMCS.mat');
% delete('estado_analise.mat');