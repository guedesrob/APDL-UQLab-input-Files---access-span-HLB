function Y = LSF (X)

    global iter;
    format long;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%                      INICIO - TESTE ANGULO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % PARÂMETROS INICIAIS
    % P=578E3;
    % Q=178.816E3;
    % perc_P=P/(P+Q);
    % perc_Q=Q/(P+Q);
    % P_ultimo=900E3;
    % n_load=10;
    % P_atual=zeros(n_load,1);
    % U2_atual=zeros(n_load,1);
    % Ang_atual=zeros(n_load,1);
    % rig_atual=zeros(n_load,1);
    % % INÍCIO DO LOOP
    % for i=2:n_load
    %     P_atual(i)=i/n_load*P_ultimo;
    %     X(17)=P_atual(i)*perc_P;
    %     X(18)=P_atual(i)*perc_Q;
    %     % Escreve vetor de VA "variable.txt"
    %     fileID = fopen('variable.txt', 'w');  % Open the file for writing
    %     fprintf(fileID, '%d\n', X);  % Write the vector to the file, with each element on a new line
    %     fclose(fileID);  % Close the file
    %     % Escreve Vetor de VA no inputfile
    %     system('"C:\Users\User\AppData\Local\Programs\Python\Python312\python.exe" "C:\Users\User\Desktop\Roberto\testerob1\VariableToAPDL_R01.py"');
    %     % Executa o Ansys com VA atuais
    %     system('SET KMP_STACKSIZE=2048k & "C:\Program Files\ANSYS Inc\v170\ansys\bin\winx64\MAPDL.exe"  -p ansys -np 8 -lch -dir "C:\Users\User\Desktop\Roberto\testerob1" -j "zteste" -s read -l en-us -b -i "C:\Users\User\Desktop\Roberto\testerob1\APDL_testerob1.apdl.txt" -o "C:\Users\User\Desktop\Roberto\testerob1\zteste"');
    %     % Lê os resultados nos nós
    %     RESP_ESTR=uq_readOutput('DESL_MAX.txt');
    %     % Armazena resultado para o nó 2
    %     U2_atual(i)=abs(RESP_ESTR(1,1));
    % end
    % % PLOT P x U
    % figure
    % xplot_1=P_atual/5e4;
    % yplot_1=U2_atual*100;
    % plot(xplot_1,yplot_1);
    % xlabel('Força');
    % ylabel('UY');
    % grid on
    % axis equal;
    % % PLOT DO ÂNGULO DO GRÁFICO P X U
    % for i=2:10
    %     Ang_atual(i)=atand((yplot_1(i)-yplot_1(i-1))/(xplot_1(i)-xplot_1(i-1)));
    %     if i==2
    %         Ang_1=Ang_atual(i);
    %     end
    %     rig_atual(i)=Ang_atual(i)/Ang_1;
    % end
    % figure
    % xplot_2=xplot_1;
    % yplot_2=Ang_atual;
    % plot(xplot_2,yplot_2);
    % xlabel('Força');
    % ylabel('Ang');
    % grid on;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                      CONFIGURAÇÃO CARGA MOVEL DETERM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    iter=iter+1
    X(17)=0.99*114E3;
    X(18)=0.99*33.70E3;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                      FIM - TESTE ANGULO
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% PRIMEIRA CHAMADA DA FEL
    %Escreve as vari�veis atuais no arquivo "variable.txt"
    fileID = fopen('variable.txt', 'w');  % Open the file for writing
    fprintf(fileID, '%d\n', X);  % Write the vector to the file, with each element on a new line
    fclose(fileID);  % Close the file
    %Escreve no APDL os valores presentes em "variable.txt"
    system('"C:\Users\User\AppData\Local\Programs\Python\Python312\python.exe" "C:\Users\User\Desktop\Roberto\testerob1\VariableToAPDL_R01.py"');
    %Executa o Ansys
    system('SET KMP_STACKSIZE=2048k & "C:\Program Files\ANSYS Inc\v170\ansys\bin\winx64\MAPDL.exe"  -p ansys -np 8 -lch -dir "C:\Users\User\Desktop\Roberto\testerob1" -j "zteste" -s read -l en-us -b -i "C:\Users\User\Desktop\Roberto\testerob1\APDL_testerob1.apdl.txt" -o "C:\Users\User\Desktop\Roberto\testerob1\zteste"');
    %Recupera a resposta estrutural do ansys
    RESP_ESTR=uq_readOutput('DESL_MAX.txt');
    U=zeros(3,2); % Inicialização de U_1
    U(:,1)=RESP_ESTR(:,1);
    P=zeros(3,2);
    P(:,1)=X(17)+X(18)*(5.5880*1/2+5.5880*1/2); % Carga total P+Q
    %% SEGUNDA CHAMADA DA FEL
    X(17)=114E3;
    X(18)=33.70E3;
    %Escreve as vari�veis atuais no arquivo "variable.txt"
    fileID = fopen('variable.txt', 'w');  % Open the file for writing
    fprintf(fileID, '%d\n', X);  % Write the vector to the file, with each element on a new line
    fclose(fileID);  % Close the file
    %Escreve no APDL os valores presentes em "variable.txt"
    system('"C:\Users\User\AppData\Local\Programs\Python\Python312\python.exe" "C:\Users\User\Desktop\Roberto\testerob1\VariableToAPDL_R01.py"');
    %Executa o Ansys
    system('SET KMP_STACKSIZE=2048k & "C:\Program Files\ANSYS Inc\v170\ansys\bin\winx64\MAPDL.exe"  -p ansys -np 8 -lch -dir "C:\Users\User\Desktop\Roberto\testerob1" -j "zteste" -s read -l en-us -b -i "C:\Users\User\Desktop\Roberto\testerob1\APDL_testerob1.apdl.txt" -o "C:\Users\User\Desktop\Roberto\testerob1\zteste"');
    %Recupera a resposta estrutural do ansys
    RESP_ESTR=uq_readOutput('DESL_MAX.txt');
    U(:,2)=RESP_ESTR(:,1);
    P(:,2)=X(17)+X(18)*(5.5880*1/2+5.5880*1/2); % Carga total 1.01*(P+Q)
    Delta_P=P(:,2)-P(:,1);
    Delta_U=U(:,2)-U(:,1);
    %% PLOT P x U
    xplot_1=Delta_P/5e4;
    yplot_1=-Delta_U*100;
%     for i=1:3
%     figure
%     plot(P(i,:)/5e4,-U(i,:)*100);
%     xlabel('Força');
%     ylabel('UY');
%     grid on
%     axis equal;
%     end
    %% ÂNGULO DO GRÁFICO P X U
    ANG=zeros(3,1);
    ANG=atand(yplot_1./xplot_1);
    
    %% FUNÇÃO DE ESTADO LIMITE
    % Print Iter
    toc
    % Cálculo da Função de Estado limite
    Y=75-max(abs(ANG))
    
    end