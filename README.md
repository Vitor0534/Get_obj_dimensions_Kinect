# Luggage Scanner Software

Este software tem o objetivo de ser uma ferramenta para auxílio nas atividades operacionais de empresas aéreas quanto ao checkin.
A principal função é realizar medidas de bagagens aeroportuárias. Para tanto o sistema é composto pelo seguintes componentes:
- Software: 
	- Código em Matlab: controla o Scanner Kinect e a esteira
	- Código da esteira: produzido para arduino permite o controle da esteira, que guiara a mala por de baixo do sensor Kinect
- Hardware:
	- Kinect V2;
	- Esteira customizada capas de mover uma mala por de baixo do sensor. Contem uma base móvel para posicionamento do Kinect

## Informações importantes

- Tecnologias utilizadas no desenvolvimento:
    - Matlab 2020

- Para executar esse programa, é necessário instalar as dependências:
	- image aquisition toolbox;
	- kinect for matlab package;

- Executando o software:
	1. o ponto de entrada é o arquivo UserGui.m que é uma view
	2. antes de executá-lo certifique-se de adicionar todas as pastas do diretório raiz ao search path do matlab:
		- Basta abrir o diretório com o matlab, selecionar a pasta na arvore de diretórios, clicar com o botão direito e adicionar tudo, inclusive as subpastas
	3. Dependendo do método utilizado para medida, os dois seguintes packages devem ser adicionados
		- Minimal Bounding Box (https://www.mathworks.com/matlabcentral/fileexchange/18264-minimal-bounding-box)
		- 2D minimal bounding box (https://www.mathworks.com/matlabcentral/fileexchange/31126-2d-minimal-bounding-box)