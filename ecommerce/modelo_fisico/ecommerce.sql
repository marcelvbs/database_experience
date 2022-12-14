create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table cliente(
	idCliente int auto_increment not null primary key,
	nome varchar(100) not null,
    sobrenome varchar(100) not null,
    cpf char(11) not null unique,
    nascimento date not null,
    telefone varchar(11) not null unique,
    email varchar(100) not null unique,
    cep char(8) not null,
    rua varchar(100) not null,
    bairro varchar(100) not null,
    cidade varchar(100) not null,
    estado char(2) not null,
    cadastro timestamp null default current_timestamp
    )auto_increment = 1 default charset=utf8mb4;

-- criar tabela vendedor
create table vendedor(
	idVendedor int auto_increment not null primary key,
	nomefantasia varchar(100) not null,
    razao_social varchar(100) not null,
    cnpj char(14) not null unique,
    nascimento date not null,
    telefone varchar(11) not null unique,
    email varchar(100) not null unique,
    cep char(8) not null,
    rua varchar(100) not null,
    bairro varchar(100) not null,
    cidade varchar(100) not null,
    estado char(2) not null,
    cadastro timestamp null default current_timestamp
)auto_increment = 1 default charset=utf8mb4;

-- criar tabela fornecedor
create table fornecedor(
	idFornecedor int auto_increment not null primary key,
	nomefantasia varchar(100) not null,
    razao_social varchar(100) not null,
    cnpj char(14) not null unique,
    telefone varchar(11) not null unique,
    email varchar(100) not null unique,
    cep char(8) not null,
    rua varchar(100) not null,
    bairro varchar(100) not null,
    cidade varchar(100) not null,
    estado char(2) not null,
    cadastro timestamp null default current_timestamp
)auto_increment = 1 default charset=utf8mb4;

-- criar tabela estoque
create table estoque(
	idEstoque int auto_increment not null primary key,
    nome varchar(100) not null,
    cep char(8) not null,
    rua varchar(100) not null,
    bairro varchar(100) not null,
    cidade varchar(100) not null,
    estado char(2) not null,
    cadastro timestamp null default current_timestamp
)auto_increment = 1 default charset=utf8mb4;

-- criar tabela entregador
create table entregador(
	idEntregador int auto_increment not null primary key,
	nomefantasia varchar(100) not null,
    razao_social varchar(100) not null,
    cnpj char(14) not null unique,
    telefone varchar(11) not null unique,
    email varchar(100) not null unique,
    cep char(8) not null,
    rua varchar(100) not null,
    bairro varchar(100) not null,
    cidade varchar(100) not null,
    estado char(2) not null,
    cadastro timestamp null default current_timestamp
)auto_increment = 1 default charset=utf8mb4;

-- criar tabela produto
create table produto(
	idProduto int auto_increment not null primary key,
    categoria enum ('Eletrodom??sticos', 'M??veis', 'Inform??tica', 'Celulares', 'Brinquedos', 'Vestu??rio') not null,
    tipo varchar(45) not null,
    marca varchar(45) not null,
    descricao varchar(255) not null,
    valor decimal(15,2) not null,
    classificacao_kids boolean default false
)auto_increment = 1 default charset=utf8mb4;

-- criar tabela compra
create table compra(
	idCompra int auto_increment not null primary key,
    valor decimal(15,2) not null,
    frete float not null,
    qtd_parcela int default '1' not null,
    forma_pagamento enum ('Boleto', 'Cart??o de Cr??dito', 'Cart??o de D??bito', 'PIX') default 'Boleto',
    situacao enum ('Cancelada', 'Entregue', 'A caminho', 'Aguardando pagamento', 'Em prepara????o') default 'Aguardando pagamento' not null,
    data_compra timestamp null default current_timestamp,
    cod_rastreio varchar(45),
    entregador int,
    cliente int,
    constraint fk_entregador_compra foreign key(entregador) references entregador(idEntregador),
    constraint fk_cliente_compra foreign key(cliente) references cliente(idCliente)
)auto_increment = 1 default charset=utf8mb4;

-- criar tabela fornecedor do produto
create table produto_fornecedor(
	idFornecedor_prodfor int,
    idProduto_prodfor int,
    constraint fk_idFornecedor_prodfor foreign key(idFornecedor_prodfor) references fornecedor(idFornecedor),
    constraint fk_produto_idProduto_prodfor foreign key(idProduto_prodfor) references produto(idProduto)
);

-- criar table vendedor do produto
create table produto_vendedor(
	idVendedor_prodven int,
    idProduto_prodven int,
    quantidade_prodven int not null,
    constraint fk_idVendedor_prodven foreign key(idVendedor_prodven) references vendedor(idVendedor),
    constraint fk_idProduto_prodven foreign key (idProduto_prodven) references produto(idProduto)
);

-- criar tabela produto em estoque
create table produto_estoque(
	idProduto_prodest int,
    idEstoque_prodest int,
    quantidade_prodest int not null,
    constraint fk_idProduto_prodest foreign key (idProduto_prodest) references produto(idProduto),
    constraint fk_idEstoque_prodest foreign key (idEstoque_prodest) references estoque(idEstoque)
);

-- criar tabela produto em compra
create table produto_compra(
	idProduto_prodcomp int,
    idCompra_prodcomp int,
    quantidade_prodcomp int not null,
    constraint fk_idProduto_prodcomp foreign key(idProduto_prodcomp) references produto(idProduto),
    constraint fk_idCompra_prodcomp foreign key(idCompra_prodcomp) references compra(idCompra)
);

/* 				CASO QUEIRA PERSISTIR OS DADOS ATRAV??S DO CSV
	o arquivo precisa estar dentro do diret??rio do DB dentro do diret??rio do SGBD no SO. Exemplo: C:\ProgramData\MySQL\MySQL Server 8.0\Data\ecommerce
 -- IN??CIO DO C??DIGO
		 load data infile 'clientes.csv'
		 into table cliente
		 fields terminated by ','
		 ignore 1 rows
		 (nome, sobrenome, cpf, nascimento, telefone, email, cep, rua, bairro, cidade, estado);
 -- FIM DO C??DIGO
*/

-- inserindo os dados na tabela cliente
insert into
cliente (nome, sobrenome, cpf, nascimento, telefone, email, cep, rua, bairro, cidade, estado)
values
('Adalmo','Silva Mota','69971884437','1990-10-10','81992898405','adalmosilva@mota.com','54495480','Rua Pitombeira','Barra de Jangada','Jaboat??o dos Guararap??s','PE'),
('Marcos','Aurelio','07316533005','1986-12-19','68986667557','marcos@aurelio.com','69900147','Rua dos Santos','Preventario','Rio Branco','AC'),
('Aridelmo','Nunes de Souza','87553456039','1993-05-20','68994062399','aridelmonunes@souza.com','69903058','Rua Salvador','Conjunto Xavier Maia','Rio Branco','AC'),
('Thiago Andr??','Motta','33561010059','1998-12-16','82982204257','thiagoandre@motta.com','57073670','Quadra T','Cidade Universit??ria','Macei??','AL'),
('Tiago','Sampaio Conceicao','41298100062','2000-09-16','92982977514','tiagosamp@conceicao.com','69099373','Rua 44B','Novo Aleixo','Manaus','AM'),
('Gilsa','Andrade de Oliveira','42076228020','1995-04-18','96982495993','gilsandrandade@oliveira.com','68926400','Travessa Rio Xingu','Fortaleza','Santana','AP'),
('George','Silva Damasceno','37918180070','1989-03-17','71995098047','geosil@damasceno.com','40327075','Avenida Figueiredo','Liberdade','Salvador','BA'),
('Mauro Henrique','Alvarenga Paiva','94546449399','2001-11-05','85998499904','mauhen@alvapaiva.com','62690970','Rua Raimundo Nonato Ribeiro','Centro','Trairi','CE'),
('Monique','Alencar Casagrande','67221035016','1997-07-16','61989357130','monqalen@casagrande.com','70750554','Quadra S Bloco D','Asa Norte','Bras??lia','DF'),
('Marianne','Albuquerque','19211775000','2005-12-23','27993553403','marianne@albuquerque.com','29943760','Rua Santa Ang??lica','Bonsucesso','S??o Mateus','ES'),
('Ian','Morais','10728332043','1999-09-10','62982388977','ian@moorais.com','74303370','Rua C','Setor Sudoeste','Goi??nia','GO'),
('Viviane','dos Santos','68401244013','1995-01-22','27996291529','vivianedos@santos.com','29900117','Rua A','Centro','Linhares','ES'),
('Juliana','Queiroz Miranda','66324578003','1988-04-18','61986589375','juliquei@miranda.com','70330060','Quadra S 102 Bloco F','Asa Azul','Bras??lia','DF'),
('Victor','Santos','73371994066','2002-06-28','85981336930','victor@santos.com','60350800','Vila Perla','Olavo Ribeiro','Fortaleza','CE'),
('Marcelo','de Souza','18514767097','1996-08-13','75987516230','marcelode@souza.com','42808220','Rua Seis','Gravat??','Cama??ari','BA'),
('Karla','Andrade','53389344004','2000-04-15','96998388020','karla@andrade.com','68904809','Passagem Treze de Setembro','Novo Buritizal','Macapa','AP'),
('Antonio Luiz','Bismarques','68711866039','1980-12-11','92995476349','antonioluiz@bismarques.com','69075431','Rua Santo Ant??nio','Mauazinho','Manaus','AM'),
('Isabel','Campos Silva','25718627070','1999-01-26','92984327005','isacamp@silva.com','57304480','Rua Manoel Rosendo de Magalh??es','Cacimbas','Arapiraca','AM'),
('Jackson','Santos Souza','92354144075','1997-02-16','82981328961','jksantos@lousada.com','57073713','Travessa Pajucara','Cidade Universit??ria','Macei??','AL'),
('Felipe','Barbosa Teixeira','80882411462','1987-07-10','81995990887','febarbo@teixeira.com','54250544','Travessa Tres de Maio','Cavaleiro','Jaboat??o dos Guararap??s','PE');

-- inserindo os dados na tabela vendedor
insert into
vendedor (nomefantasia, razao_social, cnpj, nascimento, telefone, email, cep, rua, bairro, cidade, estado)
values
('Osvaldo Guimar??es','Osvaldo Guimar??es Ltda','10159179000188','1980-10-18','85982556368','faleconosco@osmaraes.com.br','60510053','Vila Vilmara','J??quei Clube','Fortaleza','CE'),
('Orbisat','Elaine Souza Meirelles Ltda','36421503000188','1992-05-01','32986395953','atendimento@orbisat.com.br','36092566','Pra??a Sotero Ramos de Faria','Benfica','Juiz de Fora','MG'),
('Quality Brasil','M??rio Davi Teixeira ME','32348818000196','1985-09-11','43984729965','contato@qualitybrasil.com.br','86030530','Rua Alu??zio Lima','Jardim Montecatini','Londrina','PR');

-- inserindo os dados na tabela fornecedor
-- ramo: Inform??tica, Celulares, Vestu??rio, M??veis, Eletrodom??sticos, Brinquedos
insert into
fornecedor (nomefantasia, razao_social, cnpj, telefone, email, cep, rua, bairro, cidade, estado)
values
('G&M Telecom','Guilherme e Mariane Telecom ME','58700838000178','1938818510','ti@guilhermeemarianetelecomme.com.br','13800012','Rua Marciliano','Centro','Mogi Mirim','SP'),
('Use T&R','Thiago e Raul Comercio de Vestu??rios Ltda','24738572000130','12999434242','comunicacoes@trvestuarios.com.br','12311210','Avenida do Cristal','Parque Calif??rnia','Jacare??','SP'),
('VG Eletr??nica','Vitor e Gabrielly Eletr??nica ME','63788279000130','81985737203','contabilidade@vitoregabriellyeletronicame.com.br','53540900','Avenida Ingo Hering','Caet??s II','Abreu e Lima','PE'),
('RR M??veis','Ros??ngela e Renan Marcenaria Ltda','41263731000107','21981735771','sac@rosangelaerenanmarcenarialtda.com.br','24435260','Rua Jaime Figueiredo','Patronato','S??o Gon??alo','RJ'),
('Tudo para o Lar','Liz e Tom??s ME','29777144000130','86997149040','atendimento@tudoparaolar.com.br','64057400','Quadra 01','Vale Quem Tem','Teresina','PI'),
('Toy Kids','Marli e Carlos Eduardo F??brica de Brinquedos Ltda','09414671000173','27999615976','representantes@toykids.com.br','29070460','Rua Professora Jacy Alves Fraga','Maria Ortiz','Vit??ria','ES');

-- inserindo os dados na tabela estoque
insert into
estoque (nome, cep, rua, bairro, cidade, estado)
values
('Estoque 1','53540900','Avenida Ingo Hering','Caet??s II','Abreu e Lima','PE'),
('Estoque 2','24435260','Rua Jaime Figueiredo','Patronato','S??o Gon??alo','RJ'),
('Estoque 3','12311210','Avenida do Cristal','Parque Calif??rnia','Jacare??','SP'),
('Estoque 4','65044467','Travessa da Alegria','Parque Timbiras','S??o Lu??s','MA');

-- inserindo os dados na tabela entregador
insert into
entregador (nomefantasia, razao_social, cnpj, telefone, email, cep, rua, bairro, cidade, estado)
values
('Luno Express','Luciana e Noah Entregas Expressas Ltda','81615533000180','21989607975','fiscal@lucianaenoahentregasexpressasltda.com.br','26070416','Rua Wanestuck de Souza Lopes','Miguel Couto','Nova Igua??u','RJ'),
('BG Transportadora','Bryan e Gustavo Transportes ME','19210851000197','21996815510','ouvidoria@bryanegustavotransportesme.com.br','24937610','Rua dos Rubis','Morada das ??guias','Maric??','RJ'),
('TranspEY','Eduarda e Yuri Transportes Ltda','25723239000110','69995362752','contato@eduardaeyuritransportesltda.com.br','76960240','Avenida Flor de Marac??','Jardim It??lia I','Cacoal','RO');

-- inserindo dados na tabela produtos
-- categoria:'Eletrodom??sticos', 'M??veis', 'Inform??tica', 'Celulares', 'Brinquedos', 'Vestu??rio'
-- classificacao_kids default false
insert into produto (categoria, tipo, marca, descricao, valor, classificacao_kids)
values 	-- Eletrodom??sticos
('Eletrodom??sticos','Geladeira','Brastemp','Geladeira Brastemp Frost Free Duplex 375L Inox - Compartimento Extrafrio Fresh Zone BRM44HK 110V','3039.00', default),
('Eletrodom??sticos','Geladeira','Electrolux','Geladeira Cycle Defrost Electrolux 240 Litros Degelo Pr??tico Branco RE31 - 110V','1723.92', default),
('Eletrodom??sticos','Fog??o','Dako','Fog??o 5 Bocas Preto com Mesa de Vidro e Timer Digital Dako Supreme Black Glass Bivolt','1759.00', default),
('Eletrodom??sticos','Fog??o','Fisher','Fog??o De Embutir Fischer 5 Bocas TC Gran Cheff G??s Com Dourador','2199.80', default),
('Eletrodom??sticos','Liquidificador','Oster','Liquidficador Oster 1,2l jarra vidro 127v preto 750w','264.99', default),
('Eletrodom??sticos','Liquidificador','Kd Eletro','Liquidficador Industrial 10 Litros Baixa Rota????o Kd Eletro','796.52', default),
('Eletrodom??sticos','Micro-ondas','Electrolux','Micro-ondas Electrolux 23L Prata Efficient','671.04', default),
('Eletrodom??sticos','Micro-ondas','Brastemp','Micro-ondas Brastemp 38L Espelhado com Grill - Ative! BMJ38 ARANA','1186.55', default),
('Eletrodom??sticos','M??quina de lavar','Consul','M??quina de Lavar Consul 11Kg Dual Dispenser - Dosagem Extra Econ??mica CWH11BB','1803.27', default),
('Eletrodom??sticos','M??quina de lavar','LG','Lava e Seca Smart LG 11kg VC4 CV5011TS4 Motor - Inverter Intelig??ncia Artificial AIDDTM','4074.55', default),
('Eletrodom??sticos','Fritadeira sem ??leo','Mondial','Fritadeira El??trica sem ??leo/Air Fryer Mondial - Family AF-35-BF Preta 3,5L com Timer','309.43', default),
('Eletrodom??sticos','Fritadeira sem ??leo','Brit??nia','Fritadeira sem ??leo Brit??nia Air Fryer Oven BFR2100P, 12 Litros, 2 em 1, Preta','670.50', default),
('Eletrodom??sticos','Aspirador de p??','Electrolux','Aspirador de P?? Port??til e Vertical Electrolux - STK13 1000W Vermelho','199.00', default),
('Eletrodom??sticos','Aspirador de p??','Multilaser','Aspirador de P?? e ??gua Multilaser Filtro HEPA 60W - AU607 Vermelho','58.79', default),
('Eletrodom??sticos','Purificador de ??gua','Colormaq','Purificador de ??gua Eletr??nico Colormaq Branco Bivolt - Cpuelsaben','389.90', default),
('Eletrodom??sticos','Purificador de ??gua','Philco','Purificador de ??gua Eletr??nico Philco PBE04BF Branco Bivolt','319.90', default),
('Eletrodom??sticos','Cafeteira','Nescaf??','Cafeteira Nescafe Dolce Gusto Mini Me Vermelha e Preta Autom??tica (110v) - Nescaf?? Dolce Gusto','419.90', default),
('Eletrodom??sticos','Cafeteira','Brit??nia','Cafeteira El??trica Brit??nia CP15 15 Caf??s Preto','113.99', default),
('Eletrodom??sticos','Panela de Press??o','Eirilar','Panela de Press??o Eirilar 4,5L Bord?? - 1710','139.90', default),
('Eletrodom??sticos','Panela de Press??o','Clock','Panela de Press??o Clock 4,5L Prata - Original Polida Alum??nio','107.70', default),
-- m??veis: categoria, tipo, marca, descricao, valor, classificacao_kids
('M??veis','Banheiro','M??veis Bechara','Arm??rio De Banheiro G??nova 1 Porta 2 Prateleiras Com Espelho Branco - Bechara - M??veis Bechara','78.20', default),
('M??veis','Banheiro','Multim??veis','Gabinete Banheiro 2 Portas e 1 Gav Retr?? 120cm Multim??veis MP5025 Branco','269.90', default),
('M??veis','Banheiro','Ozini','Arm??rio de Banheiro 3 Portas com Cuba e Espelheira C0082507 Ozini','475.99', default),
('M??veis','Quarto','Panorama M??veis','C??moda 2 Portas 4 Gavetas New Branco - Panorama M??veis','279.90', default),
('M??veis','Quarto','M??veis Europa','Guarda-roupa Casal com Espelho 3 Portas de Correr - 3 Gavetas Europa Maranello 11617.1','1439.91', default),
('M??veis','Quarto','Belaflex','Escrivaninha Penteadeira de Canto 136x136cm com Espelho 1 Porta Star Belaflex','269.90', default),
('M??veis','Quarto','Madesa','Guarda-Roupa Solteiro Madesa Denver 2 Portas de Correr com Espelho','629.99', default),
('M??veis','Quarto infantil','Carolina Baby','C??moda Frald??rio Ariel Branco Brilho Carolina Baby','299.90',true),
('M??veis','Quarto infantil','Carolina Baby','Quarto Infantil Decorado Ariel II Branco - Carolina Baby','1270.75',true),
('M??veis','Quarto infantil','Gabrielli M??veis','Cama Quarto Infantil Carro com Colch??o - GABRIELLI M??VEIS','365.98',true),
('M??veis','Quarto infantil','M??veis Peroba','Quarto de Beb?? Completo com Guarda Roupa Uli 4 Portas C??moda Uli 4 Gavetas M??veis Peroba','861.38',true),
('M??veis','Quarto infantil','M??veis Estrela','Cama Infantil M??veis Estrela - Carruagem 88x188cm','654.32',true),
('M??veis','Sala de Estar','Multim??veis','Rack c/ Painel p/ TV at?? 65" e P??s Retr?? Fl??rida Multim??veis Preto','297.28', default),
('M??veis','Sala de Estar','SMP','Sof?? Retr??til Reclin??vel 3 Lugares Suede - Phormatta Evolution SMP','959.99', default),
('M??veis','Sala de Estar','Cama inBox','Sof?? Retr??til e Reclin??vel Cama inBox Compact 1,50m Tecido Suede Velusoft Castor','799.90', default),
('M??veis','Sala de Estar','Multim??veis','Estante Home Theater para TV at?? 55 Pol. Denver Multim??veis Madeirado/Preto','293.92', default),
('M??veis','Sala de Jantar','Madesa','Conjunto Sala de Jantar Madesa Talita Mesa Tampo de Madeira com 4 Cadeiras','449.99', default),
('M??veis','Sala de Jantar','Rufato','Conjunto de Mesa de Jantar Luna I com Vidro e 6 Cadeiras Gr??cia Veludo Creme e Off White - Rufato','1267.51', default),
('M??veis','Sala de Jantar','HB M??veis','Cristaleira Aura HB M??veis 2 Portas De Vidro 1 Gaveta','1049.85', default),
('M??veis','Sala de Jantar','M??veis Bechara','Cristaleira Adega Scala Sala de Estar P?? de A??o - M??veis Bechara','336.71', default),
('M??veis','Sala de Jantar','Quarta Divis??o M??veis','Cristaleira Tiffany 2 Portas De Vidro Reflecta - Quarta Divis??o M??veis','462.96', default),
-- Inform??tica: categoria, tipo, marca, descricao, valor, classificacao_kids
('Inform??tica','Monitores','Husky Gaming','Monitor Gamer Husky Storm 27 LED Curvo 165 Hz Full HD 1ms Adaptive Sync HDMI/DisplayPort Ajuste de ??ngulo - HGMT001 - Husky Gaming','1199.99', default),
('Inform??tica','Monitores','LG','Monitor Gamer UltraWide LG 26WQ500-B 25,7??? - Full HD 75Hz IPS 1ms HDMI FreeSync','899.10', default),
('Inform??tica','Monitores','Dell','Monitor Dell De 23.8 S2421hn','1231.12', default),
('Inform??tica','Monitores','Samsung','Monitor Full HD Samsung T350 LF24T350FHLMZD - 24??? IPS LED HDMI VGA FreeSync','764.91', default),
('Inform??tica','Perif??ricos','Movitec','Mouse Movitec ??ptico 1000DPI 3 Bot??es - OMFC-01','12.51', default),
('Inform??tica','Perif??ricos','Logitech','Kit Teclado e Mouse Sem Fio Logitech MK220','116.88', default),
('Inform??tica','Perif??ricos','T-Dagger','Teclado Mec??nico Gamer T-Dagger Bora, RGB, Switch Outemu Blue, ABNT2 - T-TGK315-BLUE','149.99', default),
('Inform??tica','Perif??ricos','Megatron','Filtro de linha 6 tomadas Megatron','23.25', default),
('Inform??tica','Perif??ricos','Kingston','SSD Kingston A400 480GB - 500mb/s para Leitura e 450mb/s para Grava????o','269.90', default),
('Inform??tica','Perif??ricos','Centr??o','Suporte Para Notebook Alum??nio Ajust??vel Dobr??vel - Conforto - Centr??o','42.30', default),
('Inform??tica','Perif??ricos','Seagate','HD Externo 1TB Expansion USB 3.0 - SEAGATE','328.06', default),
('Inform??tica','Impressora','Epson','Impressora Multifuncional Epson Ecotank L3250 - Tanque de Tinta Colorida USB Wi-Fi','1169.10', default),
('Inform??tica','Impressora','HP','Impressora Multifuncional HP Smart Tank 514 - Tanque de Tinta Colorida Wi-Fi USB','944.91', default),
('Inform??tica','Impressora T??rmica','Epson','Impressora T??rmica N??o Fiscal Epson - TM-T20X USB','665.10', default),
('Inform??tica','Impressora T??rmica','Goldensky','Impressora Fiscal T??rmica 58mm E Leitor Boleto C??digo Barras - Goldensky','300.00', default),
('Inform??tica','Notebook','Samsung','Notebook Samsung Book Intel Celeron 4GB 256GB SSD - 15,6??? Full HD Windows 11 NP550XDA-KP3BR','1889.10', default),
('Inform??tica','Notebook','Dell','Notebook Gamer Dell G15-i1200-M10P 15.6" FHD 12?? Gera????o Intel Core i5 8GB 256GB SSD NVIDIA RTX 3050 Windows 11','6238.32', default),
('Inform??tica','Notebook','Lenovo','Notebook Lenovo Ideapad 3i Intel Core i3 4GB - 256GB SSD 15,6??? Full HD Windows 11 82MD000ABR','2294.10', default),
('Inform??tica','Notebook','Positivo','Notebook Positivo Motion Intel Atom - 4GB 128GB eMMC 14,1??? LED Windows 10','1599.00', default),
('Inform??tica','Notebook','Acer','Notebook Acer Aspire 5 A514-54-385S Intel Core i3 11?? Gen Windows 11 Home 4GB 256GB SDD 14" Full HD','2375.12', default),
-- Celulares: categoria, tipo, marca, descricao, valor, classificacao_kids
('Celulares','Smartphone','Motorola','Smartphone Motorola Moto G32 128GB Vermelho 4G - Octa-Core 4GB RAM 6,5??? C??m. Tripla + Selfie 16MP','1079.10', default),
('Celulares','Smartphone','Motorola','Smartphone Motorola Edge 30 256GB Grafite 5G - Octa-Core 8GB RAM 6,5??? C??m. Tripla + Selfie 32MP','1999.00', default),
('Celulares','Smartphone','Samsung','Smartphone Samsung Galaxy S22 128GB Ros?? 5G 8GB - RAM Tela 6,1??? C??m. Tripla + Selfie 10MP Snapdragon','4274.05', default),
('Celulares','Smartphone','Samsung','Smartphone Samsung Galaxy A23 128GB Preto 4G - Octa-Core 4GB RAM 6,6??? C??m Qu??drupla + Selfie 8MP','1349.10', default),
('Celulares','Smartphone','Xiaomi','Smartphone Xiaomi Redmi 10A 64Gb, Tela 6.53" C??meras 13MP+2MP Cinza CX341CIN XIAOMI','1212.58', default),
('Celulares','Smartphone','Xiaomi','Smartphone Xiaomi Poco M4 Pro 4G 256GB 8GB RAM Tela 6.43"','2776.48', default),
('Celulares','Smartphone','LG','Smartphone LG Velvet 128GB Aurora White Octa-Core - 6GB RAM Tela 6,8??? C??m. Tripla + Selfie 16MP','2799.00', default),
('Celulares','Smartphone','LG','Smartphone LG K51S 64GB Tit??nio 4G Octa-Core - 3GB RAM 6,55??? C??m. Qu??drupla + Selfie 13MP','1099.00', default),
('Celulares','Smartphone','Apple','Apple iPhone 13 128GB Estelar Tela 6,1??? 12MP - iOS','5114.07', default),
('Celulares','Smartphone','Apple','iPhone 11 Apple 128GB Branco 6,1??? 12MP iOS','3719.07', default),
('Celulares','Celular b??sico','Nokia','Celular Nokia 110 - R??dio FM e Leitor integrado Preto','131.65', default),
('Celulares','Celular b??sico','Red Mobile','Celular Red Mobile Prime 2.4 M012F Dual Chip - 32MB 2G R??dio FM Bluetooth Desbloqueado','97.02', default),
('Celulares','Celular b??sico','Multilaser','Celular do idoso Vita com Base carregadora Teclas falantes e Bot??o SOS P9121 - Multilaser','136.71', default),
('Celulares','Celular b??sico','Lenoxx','Celular Lenoxx CX 908 Dual Chip - R??dio FM Bluetooth MP3 Player','179.10', default),
-- Brinquedos: categoria, tipo, marca, descricao, valor, classificacao_kids
('Brinquedos','Educativo','Chicco','Jogo de Boliche dos Macaquinhos - Chicco','169.99',true),
('Brinquedos','Educativo','Chicco','Mesa de Atividades e Ferramentas 2 em 1 - Chicco','161.99',true),        
('Brinquedos','Musicais, Luzes e Sons','Chicco','Ursinho Rainbow Rosa - Chicco','168.99',true),
('Brinquedos','Musicais, Luzes e Sons','Fun Divirta-se','Mundo Bita Pianinho Musical e Percuss??o - Fun Divirta-se','127.99',true),
('Brinquedos','Musicais, Luzes e Sons','BBR Toys','C??mera M??gica Lan??a Bolhas com Luz e Som Rosa - BBR Toys','69.99',true),
('Brinquedos','Musicais, Luzes e Sons','Yes Toys','Trenzinho Brincalh??o Winfun - Yes Toys','157.99',true),
('Brinquedos','Musicais, Luzes e Sons','Buba Toys','Girafinha Musical Animal Fun - Buba Toys','107.99',true),        
('Brinquedos','Pel??cias','Fun Divirta-se','Kit Pel??cias Disney Mickey e Minnie 20cm - Fun Divirta-se','199.98',true),
('Brinquedos','Pel??cias','Mattel','Pel??cia Lightyear Buzz 20 Cm - Mattel','49.99',true),
('Brinquedos','Pel??cias','Sunny','Pel??cia Squishmallows Disney Sulley - Sunny','89.99',true),        
('Brinquedos','Bonecas','Estrela','Boneca Luluca com Som 42 cm Estrela','199.99',true),
('Brinquedos','Bonecas','Multikids','Boneca Cry Babies Sons e L??grimas de Verdade Flamy Multikids','349.99',true),
('Brinquedos','Bonecas','Hasbro','Boneca - Baby Alive Glo Pixies Sammie Shimmer Fadas F2595 Hasbro','376.10',true),
('Brinquedos','Bonecas','Mattel','Boneca Barbie - Barbie Bailarina Cl??ssica - Roxo - Mattel','59.99 ',true),
('Brinquedos','Bonecas e acess??rios','Mattel','Mega Casa Dos Sonhos da Barbie - Mattel','1533.90',true),
('Brinquedos','Bonecas e acess??rios','Mattel','Playset - Barbie - Trailer dos Sonhos - 32 cm - Mattel','699.99',true),
('Brinquedos','Bonecas e acess??rios','Mattel','Playset e Boneca - Barbie - Estate - Nova Casa Glam - Mattel','381.99',true),
('Brinquedos','Bonecas e acess??rios','Mattel','Playset e Boneca Barbie - Barbie Ginasta - Gin??stica - Mattel','293.99',true),       
('Brinquedos','Patins','Mattel','Patins Barbie 29/32 Fun Rosa','359.99',true),
('Brinquedos','Patins','Multikids','Patins 2 em 1 Marvel Vingadores Inline Tam 31-34 Multikids Azul','219.99',true),
('Brinquedos','Bicicleta','Nathor','Bicicleta - Aro 16 - Capit??o Am??rica - Nathor - Azul','649.90',true),
('Brinquedos','Bicicleta','Caloi','Bicicleta Aro 12 - Cecizinha - Branco - Caloi','279.90',true),
('Brinquedos','Bicicleta','Nathor','Bicicleta 12" Nathor Violet Roxo','376.29',true),
('Brinquedos','Carros','Mattel','Hot Wheels - 2 Jet Z - Legend Tours - GHD99','17.99',true),
('Brinquedos','Carros','Mattel','Carrinho Hot Wheels 2 Jet Z - Legends Tour Cinza Edi????o 2020','59.99',true),
('Brinquedos','Instrumentos Musicais','Candide','Patrulha Canina - Guitarra Eletr??nica - Candide','149.99',true),
('Brinquedos','Instrumentos Musicais','Fun','Guitarra Infantil - Barbie - Dreamtopia com MP3 - Rosa - Fun','189.99 ',true),
('Brinquedos','Instrumentos Musicais','Fun','Teclado - Power Rockers - Fun','99.99',true),
('Brinquedos','Instrumentos Musicais','Elka','Maraca e Pandeiro - Baby Shark - ElkaMaraca e Pandeiro - Baby Shark - Elka','54.99',true),
('Brinquedos','Bonecos','Mimo','Boneco Articulado 55 cm Pantera Negra Ultimato Marvel','299.99',true),
('Brinquedos','Bonecos','Hasbro','Boneca De A????o - Marvel Legends Series Deluxe - Okoye - Hasbro','299.99',true),
('Brinquedos','Lan??a-Dardos','Hasbro','Nerf - Lan??ador Dinosquad Stego-Smash F0806 - Hasbro','119.99',true),
('Brinquedos','Lan??a-Dardos','Hasbro','Lan??ador de Dardos - Nerf - Elite 2.0 - Tetrad QS 4 - Com 4 Dardos - Hasbro','149.99',true),
('Brinquedos','Lan??a-Dardos','Hasbro','Lan??ador De Dardos - Nerf - Elite 2.0 - Schockwave - Hasbro','399.99',true),
('Brinquedos','Lan??a-Dardos','Hasbro','EXCLUSIVO - Lan??ador de Dardos - Nerf - Roblox - Jailbrake Armor - Hasbro','199.99',true),
('Brinquedos','Lan??a-Dardos','Hasbro','Lan??ador de Dardos - Nerf - Fortnite Pump - 4 Dardos - Hasbro','399.99',true),
-- Vestu??rio: categoria, tipo, marca, descricao, valor, classificacao_kids
('Vestu??rio','Infantil masculino','Hawaiian Dreams','Camiseta Hawaiian Dreams Juvenil Especial Estampada Island Preta','47.99',true),
('Vestu??rio','Infantil masculino','GOOD STUFF CLOTHING','Kit 2 Camisetas B??sicas Masculina Manga Curta Confort??vel Branco','139.90',true),
('Vestu??rio','Infantil masculino','Buh','Camiseta Buh Kids Recorte Canelado Branca','88.07',true),
('Vestu??rio','Infantil masculino','Buh','Camiseta Buh Kids Pause Play Stop Preta','75.47',true),
('Vestu??rio','Infantil masculino','Oneill','Camiseta Oneill Lycra Infantil Manga Curta Azul','59.99',true),
('Vestu??rio','Infantil feminino','Anjuss','Camiseta Anjuss Kids Ctrl C Branco','24.99',true),
('Vestu??rio','Infantil feminino','Boca Grande','Blusa Infantil de Manga Longa Boca Grande Panda Cinza','31.99',true),
('Vestu??rio','Infantil feminino','Anjuss','Camiseta Anjuss Kids Swage Cinza','26.39',true),
('Vestu??rio','Infantil feminino','P??tale','Kit 2 Blusas B??sicas Feminina Canelada Ribana Lisa Moderna Rosa','129.99',true),
('Vestu??rio','Infantil feminino','WJU JEANS','Camiseta Juvenil Menino Estampada Azul','46.90',true),
('Vestu??rio','Infantil feminino','Boca Grande','Blusa Infantil de Manga Longa Boca Grande Panda Cinza','31.99',true),
('Vestu??rio','Adulto masculino','Hering','Bermuda Masculina Em Sarja De Algod??o Cinza','199.99', default),
('Vestu??rio','Adulto masculino','GAP','Bermuda Sarja GAP Chino Bolsos Azul-Marinho','124.99', default),
('Vestu??rio','Adulto masculino','MeA Shoes','T??nis Sapat??nis Masculino Casual 7750','74.90', default),
('Vestu??rio','Adulto masculino','Polo Plus','T??nis Casual Confot??vel Masculino Polo Plus Branco','99.90', default),
('Vestu??rio','Adulto masculino','Lupo','Kit 10p??s Cueca Lupo Boxer Logo Azul-Marinho/Vinho','239.99', default),
('Vestu??rio','Adulto masculino','Colcci','Kit 6p??s Cueca Colcci Boxer Logo Branca/Preta','179.90', default),
('Vestu??rio','Adulto masculino','Hering','Bermuda Masculina Em Sarja De Algod??o Cinza','199.9', default),
('Vestu??rio','Adulto feminino','FiveBlue','Vestido FiveBlu Curto Manga Bufante Off-White','89.99', default),
('Vestu??rio','Adulto feminino','FiveBlue','Vestido FiveBlu Midi Canelado Fenda Vermelho','74.99', default),
('Vestu??rio','Adulto feminino','Amaro','Vestido AMARO Curto Alcinha Alfaiataria Leve Vermelho Vivo','199.99', default),
('Vestu??rio','Adulto feminino','Colcci','Vestido Colcci Curto Logo Branco','109.99', default),
('Vestu??rio','Adulto feminino','Lan??a Perfume','Camiseta Lan??a Perfume Logo Preta','69.99', default),
('Vestu??rio','Adulto feminino','GAP','Blusa GAP Logo Azul','79.99', default),
('Vestu??rio','Adulto feminino','Adidas','Camiseta adidas Originals 3 Stripes Preta','129.99', default),
('Vestu??rio','Adulto feminino','Colcci','Camisa Cropped Colcci Lisa Branca','184.99', default),
('Vestu??rio','Adulto feminino','Tommy Jeans','Camisa Tommy Jeans Logo Rosa','294.99', default),
('Vestu??rio','Adulto feminino','Hering','Camisa Hering Bolsos Branca','139.99', default),
('Vestu??rio','Adulto feminino','Diva Shoes','Camiseta Unissex Copa do Mundo Brasil com Strass Preta','112.99', default),
('Vestu??rio','Adulto feminino','Dudalina','Camisa Dudalina Reta Lisa Azul-Marinho','239.99', default);
        
-- escolher o fornecedor que disponibilizar?? cada produto da tabela produto
-- 1: Inform??tica	2: Celulares	3: Vestu??rio	4:M??veis	5:Eletrodom??sticos	6:Brinquedos
insert into produto_fornecedor(idFornecedor_prodfor, idProduto_prodfor)
values
(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9),(5,10),(5,11),(5,12),(5,13),(5,14),(5,15),(5,16),(5,17),(5,18),(5,19),(5,20),
(4,21),(4,22),(4,23),(4,24),(4,25),(4,26),(4,27),(4,28),(4,29),(4,30),(4,31),(4,32),(4,33),(4,34),(4,35),(4,36),(4,37),(4,38),(4,39),(4,40),(4,41),
(1,42),(1,43),(1,44),(1,45),(1,46),(1,47),(1,48),(1,49),(1,50),(1,51),(1,52),(1,53),(1,54),(1,55),(1,56),(1,57),(1,58),(1,59),(1,60),(1,61),
(2,62),(2,63),(2,64),(2,65),(2,66),(2,67),(2,68),(2,69),(2,70),(2,71),(2,72),(2,73),(2,74),(2,75),
(6,76),(6,77),(6,78),(6,79),(6,80),(6,81),(6,82),(6,83),(6,84),(6,85),(6,86),(6,87),(6,88),(6,89),(6,90),(6,91),(6,92),(6,93),(6,94),(6,95),(6,96),(6,97),(6,98),(6,99),
	(6,100),(6,101),(6,102),(6,103),(6,104),(6,105),(6,106),(6,107),(6,108),(6,109),(6,110),(6,111),
(3,112),(3,113),(3,114),(3,115),(3,116),(3,117),(3,118),(3,119),(3,120),(3,121),(3,122),(3,123),(3,124),(3,125),(3,126),(3,127),(3,128),(3,129),
(3,130),(3,131),(3,132),(3,133),(3,134),(3,135),(3,136),(3,137),(3,138),(3,139),(3,140),(3,141);

-- escolher produto e digitar sua quantidade dispon??veis em estoque
-- escolher o produto da tabela "produto", designar em qual estoque estar?? dispon??vel e digitar a quantidade dispon??vel
-- existem 4 estoques cadastrados:  Estoque 1, Estoque 2, Estoque 3 e Estoque 4
-- Eletrodom??sticos: 1 - 20 // M??veis: 21 - 41 // Infom??tica: 42 - 61 // Celulares: 62 - 75 // Brinquedos: 76 - 111 // Vestu??rio:112 - 141
insert into produto_estoque (idProduto_prodest, idEstoque_prodest, quantidade_prodest)
values
-- Eletrodom??sticos
(1,1,15),(2,1,18),(3,1,20),(4,1,16),(5,1,22),(6,2,25),(7,2,11),(8,2,12),(9,2,13),(10,2,22),(11,3,46),(12,3,50),
(13,3,100),(14,3,90),(15,3,43),(16,4,40),(17,4,31),(18,4,33),(19,4,57),(20,4,55),
-- M??veis
(21,1,78),(22,1,56),(23,1,59),(24,1,112),(25,1,124),(26,2,45),(27,2,220),(28,2,84),(29,2,114),(30,2,45),(31,2,50),(32,3,76),
(33,3,75),(34,3,245),(35,3,213),(36,3,154),(37,4,100),(38,4,134),(39,4,90),(40,4,100),(41,4,110),
-- Inform??tica
(42,1,157),(43,1,165),(44,1,134),(45,1,132),(46,1,1100),(47,1,900),(48,2,500),(49,2,600),(50,2,700),(51,2,300),(52,2,330),
(53,3,120),(54,3,154),(55,3,80),(56,3,67),(57,4,178),(58,4,80),(59,4,160),(60,4,200),(61,4,170),
-- Celulares
(62,1,424),(63,1,354),(64,1,242),(65,1,250),(66,2,226),(67,2,267),(68,2,197),(69,2,150),(70,3,165),(71,3,120),
(72,3,89),(73,4,50),(74,4,45),(75,4,46),
-- Brinquedos
(76,1,31),(77,1,45),(78,1,34),(79,1,33),(80,1,32),(81,1,31),(82,1,33),(83,1,120),(84,1,144),(85,2,138),(86,2,254),(87,2,235),(88,2,275),(89,2,266),
(90,2,145),(91,2,139),(92,2,133),(93,2,137),(94,3,312),(95,3,312),(96,3,139),(97,3,152),(98,3,154),(99,3,100),(100,3,100),(101,3,190),(102,3,189),
(103,4,198),(104,4,191),(105,4,179),(106,4,198),(107,4,312),(108,4,324),(109,4,301),(110,4,345),(111,4,323),
-- Vestu??rios
(112,1,78),(113,1,56),(114,1,59),(115,1,112),(116,1,124),(117,1,45),(118,1,220),(119,2,84),(120,2,114),(121,2,45),(122,2,50),(123,2,76),
(124,2,75),(125,2,245),(126,3,213),(127,3,154),(128,3,100),(129,3,134),(130,3,90),(131,3,100),(132,3,110),(133,4,110),(134,4,110),(135,4,110),
(136,4,110),(137,4,110),(138,4,110),(139,4,110),(140,4,110),(141,4,110);


-- escolher produto e digitar sua quantidade dispon??veis por vendedor
-- escolher o produto da tabela "produto", designar qual vendedor o disponibilizar?? e digitar a quantidade dispon??vel
-- existem apenas 3 vendedores cadastrados
-- existem 141 produtos cadastrados
use ecommerce;
SELECT * FROM vendedor;
insert into produto_vendedor (idVendedor_prodven, idProduto_prodven, quantidade_prodven)
values
-- 										VENDEDOR 1
-- Eletrodom??sticos
(1,5),(2,6),(3,6),(4,5),(5,7),(6,8),(7,3),(8,4),(9,4),(10,7),(11,15),(12,16),
(13,33),(14,30),(15,14),(16,13),(17,10),(18,11),(19,19),(20,18),
-- M??veis
(21,26),(22,18),(23,19),(24,37),(25,14),(26,15),(27,73),(28,28),(29,38),(30,15),(31,16),(32,25),
(33,25),(34,81),(35,71),(36,51),(37,33),(38,44),(39,30),(40,33),(41,36),
-- Inform??tica FALTA DAQUI EM DIANTE
(42,157),(43,165),(44,134),(45,132),(46,1100),(47,900),(48,500),(49,600),(50,700),(51,300),(52,330),
(53,120),(54,154),(55,80),(56,67),(57,178),(58,80),(59,160),(60,200),(61,170),
-- Celulares
(62,424),(63,354),(64,242),(65,250),(66,226),(67,267),(68,197),(69,150),(70,165),(71,120),
(72,89),(73,50),(74,45),(75,46),
-- Brinquedos
(76,31),(77,45),(78,34),(79,33),(80,32),(81,31),(82,33),(83,120),(84,144),(85,138),(86,254),(87,235),(88,275),(89,266),
(90,145),(91,139),(92,133),(93,137),(94,312),(95,312),(96,139),(97,152),(98,154),(99,100),(100,100),(101,190),(102,189),
(103,198),(104,191),(105,179),(106,198),(107,312),(108,324),(109,301),(110,345),(111,323),
-- Vestu??rios
(112,78),(113,56),(114,59),(115,112),(116,124),(117,45),(118,220),(119,84),(120,114),(121,45),(122,50),(123,76),
(124,75),(125,245),(126,213),(127,154),(128,100),(129,134),(130,90),(131,100),(132,110),(133,110),(134,110),(135,110),
(136,110),(137,110),(138,110),(139,110),(140,110),(141,110),

-- 										VENDEDOR 2


-- 										VENDEDOR 3
;





-- inserindo dados na tabela compras
insert into compra (valor, frete, qtd_parcela, forma_pagamento, situacao, cod_rastreio, entregador, cliente)
values	(),
		();


-- inserir quantidade de produto que esta em uma compra
-- precisa criar as compras antes
insert into produto_compra (idProduto_prodcomp, idCompra_prodcomp, quantidade_prodcomp)
values	(),
		();
