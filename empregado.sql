SET search_path TO empresa;

CREATE TABLE projeto(
	codprojeto INTEGER PRIMARY KEY,
	nomeprojeto VARCHAR(60),
	coddepartamento INTEGER
);

CREATE TABLE cidade(
	codcidade INTEGER PRIMARY KEY,
	nomecidade VARCHAR(60) NOT NULL
);

CREATE TABLE empregado_projeto(
	codempregado INTEGER,
	codprojeto INTEGER,
	horas INTEGER NULL,
	CONSTRAINT pk_empregado_projeto PRIMARY KEY (codempregado, codprojeto)
);

CREATE TABLE departamento(
	coddepartamento INTEGER PRIMARY KEY,
	nomedepartamento VARCHAR(60),
	datainicioger TIMESTAMP NULL,
	codempregado INTEGER NULL,
	codcidade INTEGER NOT NULL
);

CREATE TABLE dependente(
	codempregado INTEGER,
	coddependente INTEGER,
	nomedep VARCHAR(60) NULL,
	sexodep CHAR(1) NULL,
	datanascdep TIMESTAMP NULL,
	tipodep CHAR(1) NULL, 
	CONSTRAINT pk_dependente PRIMARY KEY (codempregado, coddependente)
);

CREATE TABLE empregado(
	codempregado INTEGER PRIMARY KEY,
	nomeinic VARCHAR(20),
	nomeint CHAR(1) NULL,
	nomefin VARCHAR(20) NULL,
	datanasc TIMESTAMP NULL,
	endereco VARCHAR(60) NULL,
	sexo CHAR(1) NULL,
	salario NUMERIC(11,2) NULL,
	coddepartamento INTEGER,
	supcodempregado INTEGER NULL
);

ALTER TABLE departamento ADD CONSTRAINT pk_codcidade FOREIGN KEY (codcidade) REFERENCES cidade(codcidade);
ALTER TABLE departamento ADD CONSTRAINT fk_codempregado FOREIGN KEY (codempregado) REFERENCES empregado(codempregado);
ALTER TABLE projeto ADD CONSTRAINT fk_coddepartamento FOREIGN KEY (coddepartamento) REFERENCES departamento(coddepartamento);
ALTER TABLE empregado_projeto ADD CONSTRAINT fk_empregado_projeto FOREIGN KEY (codprojeto) REFERENCES projeto(codprojeto);
ALTER TABLE empregado_projeto ADD CONSTRAINT fk_empregado_projeto_2 FOREIGN KEY (codempregado) REFERENCES empregado(codempregado);
--ALTER TABLE empregado_projeto ADD CONSTRAINT pk_empregado_projeto PRIMARY KEY (codempregado, codprojeto);
ALTER TABLE empregado ADD CONSTRAINT fk_supcodempregado FOREIGN KEY (supcodempregado) REFERENCES empregado(codempregado);
ALTER TABLE dependente ADD CONSTRAINT fk_dependente FOREIGN KEY (codempregado) REFERENCES empregado(codempregado);
