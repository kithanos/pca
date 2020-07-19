clear all
close all
clc

%Define arquivo com os vetores de entrada
arq_entrada = "dados.ascii";

%Define nome do arquivo de saida
arq_saida = "dados_saida_PCA.ascii";

%Define numero de componentes principais
n = 4;

%Carrega arquivo
Y = load('-ascii', arq_entrada);  

%Calcula media (ou centro de massa)
mu = mean(Y); 

%Leva os pontos originais para um novo sistema de coordenada centrada na media calculada
Xm = bsxfun(@minus,Y,mu);

%Calcula matriz de covariancia
C = cov(Xm);

%Calcula autovalores e autovetores
[V,D] = eig(C);

%Organiza a diagonal na ordem descendente
[D, i] = sort(diag(D), 'descend');

%Organiza V na nova ordem decrescente 
V = V(:,i);

%Obtem soma acumulada da importancia dos autovalores
soma_acu = cumsum(D)/sum(D)

save('-ascii', "Autovalores.ascii","soma_acu");

%Com "n" sendo o novo numero de coordenadas
Z = Xm*V(:,1:n);

%Armazena novos vetores em um arquivo
save('-ascii', arq_saida,"Z");

