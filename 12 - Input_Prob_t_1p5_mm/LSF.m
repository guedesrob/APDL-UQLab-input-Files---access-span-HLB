function Y = LSF (X)
format long;
global iter;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      FIM - TESTE ANGULO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PRIMEIRA CHAMADA DA FEL
%Escreve as vari�veis atuais no arquivo "variable.txt"
fileID = fopen('variable.txt', 'w');  % Open the file for writing
fprintf(fileID, '%d\n', X);  % Write the vector to the file, with each element on a new line
fclose(fileID);  % Close the file
%Escreve no APDL os valores presentes em "variable.txt"
system('"C:\Users\Java 5\anaconda3\python.exe" "C:\Users\Java 5\Desktop\Roberto\testerob1\VariableToAPDL_R01.py"');
%Executa o Ansys
system('SET KMP_STACKSIZE=2048k & "C:\Program Files\ANSYS Inc\v182\ansys\bin\winx64\MAPDL.exe"  -p ansys -np 12 -lch -dir "C:\Users\Java 5\Desktop\Roberto\testerob1" -j "zteste" -s read -l en-us -b -i "C:\Users\Java 5\Desktop\Roberto\testerob1\APDL_testerob1.apdl.txt" -o "C:\Users\Java 5\Desktop\Roberto\testerob1\zteste"');
%Recupera a resposta estrutural do ansys
RESP_ESTR=uq_readOutput('DESL_MAX.txt');
U=zeros(3,2); % Inicialização de U_1
U(:,1)=RESP_ESTR(:,1);
P=zeros(3,2);
P(:,1)=X(17)+X(18)*(5.5880*1/2+5.5880*1/2); % Carga total P+Q
%% SEGUNDA CHAMADA DA FEL
X(17)=X(17)*1.01;
X(18)=X(18)*1.01;
%Escreve as vari�veis atuais no arquivo "variable.txt"
fileID = fopen('variable.txt', 'w');  % Open the file for writing
fprintf(fileID, '%d\n', X);  % Write the vector to the file, with each element on a new line
fclose(fileID);  % Close the file
%Escreve no APDL os valores presentes em "variable.txt"
system('"C:\Users\Java 5\anaconda3\python.exe" "C:\Users\Java 5\Desktop\Roberto\testerob1\VariableToAPDL_R01.py"');
%Executa o Ansys
system('SET KMP_STACKSIZE=2048k & "C:\Program Files\ANSYS Inc\v182\ansys\bin\winx64\MAPDL.exe"  -p ansys -np 12 -lch -dir "C:\Users\Java 5\Desktop\Roberto\testerob1" -j "zteste" -s read -l en-us -b -i "C:\Users\Java 5\Desktop\Roberto\testerob1\APDL_testerob1.apdl.txt" -o "C:\Users\Java 5\Desktop\Roberto\testerob1\zteste"');
%Recupera a resposta estrutural do ansys
RESP_ESTR=uq_readOutput('DESL_MAX.txt');
U(:,2)=RESP_ESTR(:,1);
P(:,2)=X(17)+X(18)*(5.5880*1/2+5.5880*1/2); % Carga total 1.01*(P+Q)
Delta_P=P(:,2)-P(:,1);
Delta_U=U(:,2)-U(:,1);
%% PLOT P x U
xplot_1=Delta_P/5e4;
yplot_1=-Delta_U*100;
%% ÂNGULO DO GRÁFICO P X U
ANG=zeros(3,1);
ANG=atand(yplot_1./xplot_1);

%% FUNÇÃO DE ESTADO LIMITE
% Print Iter
iter=iter+1
toc
% Cálculo da Função de Estado limite
Y=75-max(abs(ANG))

end