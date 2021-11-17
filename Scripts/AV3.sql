CREATE TABLE pessoa (
    pessoa_nome VARCHAR(255) NOT NULL,
    cpf NUMERIC(11),
    sexo VARCHAR (25) NOT NULL,
    data_nascimento NUMERIC(8) NOT NULL, 
    CONSTRAINT cpf_pk PRIMARY KEY (cpf),
    CHECK (cpf > 0)
);

ALTER TABLE pessoa RENAME COLUMN pessoa_nome TO pessoa_name;

CREATE INDEX pessoa_index_ ON pessoa (cpf, pessoa_name);

CREATE SEQUENCE id_seq
    MINVALUE 1
    MAXVALUE 99999999999
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE cliente (
    cliente_cpf NUMERIC (11),
    cliente_tipo VARCHAR(255) NOT NULL,
    cliente_telefone NUMERIC (9) NOT NULL,
    CONSTRAINT cliente_cpf_pk PRIMARY KEY (cliente_cpf)
    CONSTRAINT cliente_cpf_fk 
        FOREIGN KEY cliente_cpf
        REFERENCES pessoa(cpf)
);

CREATE TABLE enderecoPessoa (
    pessoa_cpf NUMERIC(11) NOT NULL,
    endereco_cep NUMERIC(8) NOT NULL,
    endereco_numero NUMERIC(5) NOT NULL,
    endereco_rua VARCHAR(255) NOT NULL,
    endereco_bairro VARCHAR(255) NOT NULL,
    endereco_complemento VARCHAR(255) NOT NULL,
    CONSTRAINT endereco_cep_pk PRIMARY KEY (endereco_cep),
    CONSTRAINT enderecoPessoa_pessoa_cpf_fk
        FOREIGN KEY(pessoa_cpf)
        REFERENCES pessoa(cpf)  
);

CREATE TABLE funcionario (
    cpf_funcionario NUMERIC (11), 
    cargo VARCHAR(255) NOT NULL,
    horario_entrada NUMERIC(2) NOT NULL,
    horario_saida NUMERIC(2) NOT NULL,
    salario NUMERIC(9) NOT NULL
);

ALTER TABLE funcionario ADD (cpf_supervisor NUMERIC (11));
ALTER TABLE funcionario ADD (CONSTRAINT cpf_supervisor_fk FOREIGN KEY (cpf_supervisor) REFERENCES funcionario(cpf_funcionario));

CREATE TABLE ligacao (
    inicio_ligacao NUMERIC(99999) NOT NULL,
    fim_ligacao NUMERIC (9999) NOT NULL,
    tipo_chamada VARCHAR(255) NOT NULL,
    protocolo NUMERIC(9) NOT NULL,
    CONSTRAINT protocolo_pk PRIMARY KEY (protocolo)
);

CREATE TABLE promocao (
    desconto NUMERIC(9) NOT NULL,
    cupom VARCHAR(9) NOT NULL,
    CONSTRAINT cupom_pk PRIMARY KEY (cupom)
);

CREATE TABLE contratante ( 
    contratante_nome VARCHAR(255) NOT NULL,
    contratante_cnpj VARCHAR(255) NOT NULL,
    CONSTRAINT contratante_cnpj_pk PRIMARY KEY (contratante_cnpj)
);

CREATE TABLE produto (
    produto_nome VARCHAR(255) NOT NULL,
    produto_numero NUMERIC (9) NOT NULL,
    produto_tipo VARCHAR(255) NOT NULL,
    produto_preco NUMERIC(99) NOT NULL,
    contratante_cnpj VARCHAR(255) NOT NULL,
    CONSTRAINT produto_pk PRIMARY KEY (contratante_cnpj, produto_numero),
    CONSTRAINT produto_contratante_cnpj_fk 
        FOREIGN KEY (contratante_cnpj) 
        REFERENCES contrante(contratante_cnpj)
);

CREATE TABLE departamento ( 
    setor_departamento VARCHAR (255) NOT NULL,
    numero_departamento NUMERIC (9) NOT NULL,
    CONSTRAINT numero_departamento_pk PRIMARY KEY (numero_departamento)
);

CREATE TABLE atende(
    numero_protocolo NUMERIC (9),
    cpf_funcionario NUMERIC (11),
    cpf_cliente NUMERIC (11),
    data_hora NUMERIC(8) NOT NULL,
    CONSTRAINT numero_protocolo_pk PRIMARY KEY (numero_protocolo, data_hora, cpf_cliente, cpf_funcionario)
    CONSTRAINT atente_cliente_cpf_fk
        FOREIGN KEY (cpf_cliente)
        REFERENCES cliente(cliente_cpf)
);

CREATE TABLE desconta(

);

CREATE TABLE compra(

);

-- (pessoa_nome, cpf, sexo, data_nascimento)

INSERT INTO pessoa VALUES ('Dr. Estranho', 11111111111, 'masculino', 01012001);
INSERT INTO pessoa VALUES ('Mulher Maravilha', 22222222222, 'feminino', 02022002);
INSERT INTO pessoa VALUES ('Batman', 33333333333, 'masculino', 03032003);
INSERT INTO pessoa VALUES ('Homem Aranha', 44444444444, 'masculino', 04042004);
INSERT INTO pessoa VALUES ('Shang-Chi', 55555555555, 'masculino', 05052005);
INSERT INTO pessoa VALUES ('Viuva Negra', 66666666666, 'feminino', 06062006);
INSERT INTO pessoa VALUES ('Magneto', 77777777777, 'masculino', 07072007);
INSERT INTO pessoa VALUES ('Super Man', 88888888888, 'masculino', 08082008);
INSERT INTO pessoa VALUES ('Wolverine', 99999999999, 'masculino', 09092009);

-- (cliente_tipo, cliente_telefone)

INSERT INTO cliente VALUES ('A',111111111);
INSERT INTO cliente VALUES ('B',222222222);
INSERT INTO cliente VALUES ('A',333333333);
INSERT INTO cliente VALUES ('B',444444444);
INSERT INTO cliente VALUES ('C',555555555);

--  (pessoa_cpf, endereco_cep, endereco_numero, endereco_rua, endereco_bairro, endereco_complemento)

INSERT INTO enderecoPessoa VALUES (11111111111, 50750370, 44,'rua senador fabio de barros', 'atras da mc donalds');
INSERT INTO enderecoPessoa VALUES (22222222222, 84957324, 55,'praca do derby', 'perto da subway');
INSERT INTO enderecoPessoa VALUES (33333333333, 69696969, 66,'rua do corredor do cin', 'perto do bebedouro');
INSERT INTO enderecoPessoa VALUES (44444444444, 78787878, 77,'avenida do bloco c', 'no totem');
INSERT INTO enderecoPessoa VALUES (55555555555, 84848484, 48,'rua do shopping plaza', 'no estacionamento');
INSERT INTO enderecoPessoa VALUES (66666666666, 95959595, 69,'rua show do milhao', 'quem quer dinheiro');
INSERT INTO enderecoPessoa VALUES (77777777777, 62626262, 68,'rua casemiro soares', 'meteu essa do nada');
INSERT INTO enderecoPessoa VALUES (88888888888, 32323232, 33,'rua celcio portiolli', 'posso perguntar aos universitarios');
INSERT INTO enderecoPessoa VALUES (99999999999, 14141414, 11,'rua luiz inacio', 'trava na poze chama no zoom da o close');

-- (cpf_funcionario, cargo, horario_entrada, horario_saida, salario)

INSERT INTO funcionario VALUES (11111111111,'chefe', 08, 18, 8000);
INSERT INTO funcionario VALUES (22222222222,'supervisor', 08, 18, 6500);
INSERT INTO funcionario VALUES (33333333333,'func1', 08, 18, 2500);
INSERT INTO funcionario VALUES (44444444444,'func2', 08, 16, 1800);

-- (inicio_ligacao, fim_ligacao, tipo_chamada, protocolo)

INSERT INTO ligacao VALUES (1253, 1300, 'curta', 121212121);
INSERT INTO ligacao VALUES  (1250, 1350, 'curta', 131313131);
INSERT INTO ligacao VALUES  (1259, 1340, 'media', 141414141);
INSERT INTO ligacao VALUES (1351, 1359, 'media', 151515151);
INSERT INTO ligacao VALUES (1458, 1500, 'media', 161616161);
INSERT INTO ligacao VALUES (1756, 1800, 'longa', 171717171);
INSERT INTO ligacao VALUES (1354, 1400, 'longa', 181818181);

-- (desconto, cupom)

INSERT INTO promocao VALUES (100, 'JANIBAIJ2');
INSERT INTO promocao VALUES (90, 'ASDASD12D');
INSERT INTO promocao VALUES (85, 'LAKSDKJ12');
INSERT INTO promocao VALUES (15, 'daleno015');

-- (contratante_nome, contratante_cnpj)

INSERT INTO contrante VALUES ('BOMBRIL', '34.227.757/0001-34');
INSERT INTO contrante VALUES ('PARMALAT', '33.338.848/0002-43');
INSERT INTO contrante VALUES ('SOFTWEB', '44.997.757/0001-34');

-- (produto_nome, produto_numero, produto_tipo, produto_preco, contratante_cnpj)

INSERT INTO produto VALUES ('antivirus', 1,'remedio', 09, '34.227.757/0001-34');
INSERT INTO produto VALUES ('ivermectina', 2,'remedio', 08, '34.227.757/0001-34');
INSERT INTO produto VALUES ('dorflex', 3,'remedio', 12, '34.227.757/0001-34');
INSERT INTO produto VALUES ('copo de plastico', 4,'utensilio', 15, '33.338.848/0002-43');
INSERT INTO produto VALUES ('garfinho de aniversario', 5,'utensilio', 13, '33.338.848/0002-43');
INSERT INTO produto VALUES ('teclado mecanico', 6,'periferico', 33, '44.997.757/0001-34');
INSERT INTO produto VALUES ('mouse optico', 7,'periferico',12, '44.997.757/0001-34');
INSERT INTO produto VALUES ('microfone', 8,'periferico', 99, '44.997.757/0001-34');
INSERT INTO produto VALUES ('lactopurga', 9,'remedio', 2, '34.227.757/0001-34');

CREATE SEQUENCE passarela INCREMENT BY 1 START WITH 1; 

-- (setor_departamento, numero_departamento)

INSERT INTO departamento VALUES ('atendimento', passarela.nextVal);
INSERT INTO departamento VALUES ('financas', passarela.nextVal);
INSERT INTO departamento VALUES ('vendas', passarela.nextVal);

