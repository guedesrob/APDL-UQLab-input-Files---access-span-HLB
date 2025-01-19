import re
import codecs
import os
######################################
#           ENTRADAS
#
######################################
# Caminho do diretório atual
diretorio_atual=os.path.dirname(os.path.abspath(__file__)) if '__file__' in locals() else os.getcdw()

# Caminho do Arquivo 'variables.txt' ('\\' separa as pastas)
path_variables=os.path.join(diretorio_atual,"variable.txt")
# path_variables="C:\\Users\\Java-Lee\\Desktop\\Roberto\\testerob1\\variable.txt"

# Caminho do Arquivo 'variables.txt' ('\\' separa as pastas)
path_apdl=os.path.join(diretorio_atual,"APDL_testerob1.apdl.txt")
# path_apdl="C:\\Users\\Java-Lee\\Desktop\\Roberto\\testerob1\\APDL_testerob1.apdl.txt"

######################################
#    LEITURA DO ARQ 'VARIABLES' E
#   ARMAZENAMENTO DAS VA EM UM VETOR
######################################
#Inicializa um vetor q armazenará as V.A. presentes no arq "variables.txt"
list_of_VA=[]
# Lê linhas do arquivo "variables.txt", cujos valores substituirão o APDL
with open(path_variables, "r") as variables:
    for line in variables.readlines():
        list_of_VA.append(line)
#Inicializa um vetor q armazena as V.A. sem espaços        
Vetor_Aux1=[]
#Inicializa um vetor q armazena as V.A. sem 'tab'
Vetor_Aux2=[]
#Inicializa um vetor q armazena as V.A. sem '\n'
Vetor_Aux3=[]
# Retira os espaços
for i in list_of_VA: 
    whatweneed=i.replace(" ","")
    Vetor_Aux1.append(whatweneed)
# Retira os "tab"    
for i in Vetor_Aux1:
    whatweneed=i.replace("\t","")
    Vetor_Aux2.append(whatweneed)
# Retira os "\n"    
for i in Vetor_Aux2:
    whatweneed=i.replace("\n","")
    Vetor_Aux3.append(whatweneed)    
    
# Vetor com as V.A.
x=Vetor_Aux3
# Numero de Variáveia Aleatórias
N_VA=len(x)

######################################
#    SUBSTITUIÇÃO DAS VA DO VETOR
#           NO ARQV APDL
######################################
# Read in the file
with codecs.open(path_apdl, 'r', encoding='utf-8', errors='ignore') as file :
    filedata = file.read()
    pattern=re.compile(r'([xX])(\d+)\s*(=)\s*(-?\d*\.?\d*[Ee]?[+-]?0?\d*)')
    matches=pattern.finditer(filedata)
    # print(filedata)
# Replace the target string
    for match in matches:
        # print(match.group(0))
        for i in range(N_VA):
            va=f"x{i+1}={x[i]}"
            # print(va)
            teste_if=f'{i+1}'
            if match.group(2)==teste_if:
                filedata = filedata.replace(match.group(0), va)
                # print(filedata)
#print(filedata)

# Write the file out again 
with codecs.open(path_apdl, 'w', encoding='utf-8', errors='ignore') as file :
    filedata = file.write(filedata)
    
############
# FIM
############
       