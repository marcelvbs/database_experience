create database ordem_servico
default charset utf8mb4;
use ordem_servico;

create table veiculo(
	idVeiculo int not null auto_increment primary key,
    montadora varchar(100) not null,
    modelo varchar(100) not null,
    placa char(7) not null,
    cor varchar(50) not null,
    cadastro timestamp null default current_timestamp
)auto_increment = 1 default charset = utf8mb4;

create table cliente (
	idCliente int not null auto_increment primary key,
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
    estado char(2) not null default 'ES',
    cadastro timestamp null default current_timestamp,
    veiculo int not null,
    constraint fk_veiculo_cliente foreign key (veiculo) references veiculo(idVeiculo)
    )auto_increment = 1 default charset=utf8mb4;

create table funcionario(
	idFuncionario int not null auto_increment primary key,
	nome varchar(100) not null,
    sobrenome varchar(100) not null,
    cpf char(11) not null unique,
    nascimento date not null,
    departamento enum ('Mecânica','Elétrica','Lanternagem'),
    funcao varchar(45) not null,
    codigo_funcionario varchar(50) not null,
    telefone varchar(11) not null unique,
    email varchar(100) not null unique,
    cep char(8) not null,
    rua varchar(100) not null,
    bairro varchar(100) not null,
    cidade varchar(100) not null,
    estado char(2) not null default 'ES',
    cadastro timestamp null default current_timestamp  
  )auto_increment = 1 default charset=utf8mb4;

create table produto(
	idProduto int not null auto_increment primary key,
    categoria varchar(50) not null, -- onde essa peça fica localizada. Ex: motor
    nome varchar(45) not null, -- Ex: virabrequim
    marca varchar(45) not null,
    descricao varchar(255),
    valor decimal(15,2) not null
 )auto_increment=1 default charset=utf8mb4;

create table requerimento(
	idRequerimento int not null auto_increment primary key,
    tipo_servico enum('Aguardando análise','Mecânico','Elétrico','Lanternagem') default 'Aguardando análise' not null,
    descricao varchar(300) not null,
    dataRequerimento timestamp null default current_timestamp,
    idCliente int not null,
    idVeiculo int not null,
    resposta_analista enum ('Aguardando','Autorizado','Cancelado') default 'Aguardando' not null,
    constraint fk_cliente_requerimento foreign key (idCliente) references cliente(idCliente),
    constraint fk_veiculo_requerimento foreign key (idVeiculo) references veiculo(idVeiculo)
)auto_increment = 1 default charset = utf8mb4;

create table analista_requerimento(
	funcionario int not null,
	requerimento int not null,
	constraint fk_funcionario_anareque foreign key (funcionario) references funcionario(idFuncionario),
	constraint fk_requerimento_anareque foreign key (requerimento) references requerimento(idRequerimento)
  )auto_increment = 1 default charset = utf8mb4;

create table manutencao(
	idManutencao int not null auto_increment primary key,
    tipo enum ('Mecânica','Elétrica','Lanternagem') not null,
    classificacao enum ('Reparo','Revisão') not null,
	descricao varchar(2000) not null,
	valor decimal(15,2) not null
    )auto_increment = 1 default charset = utf8mb4;

create table orcamento(
	idOrcamento int not null auto_increment primary key,
    descricao varchar(1000) not null,
    previsao_entrega date not null,
    requerimento int not null,
    peca_usada int not null,
    mao_obra int not null,
    valor decimal(15,2) not null, -- manutanção + peças usadas
    autorizacao_cliente enum ('Aguardando','Autorizado','Cancelado') default 'Aguardando',
    analista int not null,
    constraint fk_requerimento_orcamento foreign key (requerimento) references requerimento(idRequerimento),
    constraint fk_analista_orcamento foreign key (analista) references funcionario(idFuncionario),
    constraint fk_mao_obra_orcamento foreign key (mao_obra) references manutencao(idManutencao),
    constraint fk_peca_orcamento foreign key (peca_usada) references produto(idProduto)
)auto_increment=1 default charset=utf8mb4;

create table manutencao_orcamento(
manutencao int not null,
orcamento int not null,
constraint fk_manutencao_manorc foreign key(manutencao) references manutencao(idManutencao),
constraint fk_orcamento_manorc foreign key(orcamento) references orcamento(idOrcamento)
)auto_increment=1 default charset=utf8mb4;

create table produto_orcamento(
	produto int not null,
    orcamento int not null,
	quantidade int not null,
    constraint fk_produto_prodorc foreign key(produto) references produto(idProduto),
    constraint fk_orcamento_prodorc foreign key(orcamento) references orcamento(idOrcamento)
)auto_increment=1 default charset=utf8mb4;

create table ordem_servico(
	idOs int not null auto_increment primary key,
	descricao varchar(1000) not null,
	dataRequerimento timestamp null default current_timestamp,
	situacao enum ('Em execução', 'Finalizada', 'Cancelada', 'Aguardando peça') default 'Em execução',
	orcamento int not null,
    constraint fk_orcamento_os foreign key (orcamento) references orcamento(idOrcamento)
    )auto_increment=1 default charset=utf8mb4;

create table executante_os(
	ordem_servico int not null,
	funcionario int not null,
    constraint fk_os_executante foreign key (ordem_servico) references ordem_servico(idOs),
    constraint fk_funcionario_executante foreign key (funcionario) references funcionario(idFuncionario)
)auto_increment=1 default charset=utf8mb4;

