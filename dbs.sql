create database IF NOT EXISTS universita;

use universita;

create table IF NOT EXISTS corso_laurea(
 	codice varchar(5) PRIMARY KEY,
 	nome varchar(50) NOT NULL,
 	descrizione varchar(30)
);

insert into corso_laurea(codice,nome,descrizione)
	values('ICD','Informatica e comunicazione digitale','ICD Taranto');

create table IF NOT EXISTS studente (
	nome varchar(30) NOT NULL,
	cognome varchar(30) NOT NULL,
 	matricola numeric (6) CHECK (matricola > 0) PRIMARY KEY,
	codice_fiscale varchar (16) NOT NULL UNIQUE,
	corso_laurea varchar (5),
	FOREIGN KEY (corso_laurea) REFERENCES corso_laurea(codice)
		ON UPDATE CASCADE
		ON DELETE NO ACTION,
	data_nascita date,
	foto blob
);


insert into studente(nome, cognome, matricola, codice_fiscale, 
corso_laurea, data_nascita)
	values('mino', 'gialli', 123456,'mngll73a628b6efg',
	 'ICD', '1998-12-21');


create table IF NOT EXISTS docente(
	nome varchar(30) NOT NULL,
	cognome varchar(30) NOT NULL,
	matricola numeric (6) CHECK (matricola > 0) PRIMARY KEY,
	codice_fiscale varchar(16) NOT NULL UNIQUE,
	dipartimento	varchar(16),
	data_nascita	date,
	foto blob
);

insert into docente (nome, cognome, matricola, codice_fiscale, dipartimento, data_nascita)
	values('pinco', 'pallino', 54321, 'pncpll34a71a730n', 'informatica', '1968-01-03');
	
create table IF NOT EXISTS modulo (
	codice varchar(5) PRIMARY KEY,
	nome varchar(30) NOT NULL,
	descrizione varchar(30),
	cfu smallint CHECK (cfu > 0)
);


insert into modulo (codice, nome, descrizione, cfu)
	values('inf01', 'database', 'corso database', 9);
	


create table IF NOT EXISTS esame (
	matricola_studente numeric(6),
	FOREIGN KEY(matricola_studente) REFERENCES studente(matricola)
					ON UPDATE CASCADE
					ON DELETE NO ACTION,

	codice_modulo varchar(5),
	FOREIGN KEY(codice_modulo) REFERENCES modulo(codice)
					ON UPDATE CASCADE
					ON DELETE NO ACTION,
	
	matricola_docente numeric(6),
	FOREIGN KEY(matricola_docente) REFERENCES docente(matricola)
					ON UPDATE CASCADE
					ON DELETE NO ACTION,
	data date,
	voto numeric(2) CHECK (voto <= 30), 
	note varchar(30),
	PRIMARY KEY(matricola_studente,codice_modulo,matricola_docente)
);

insert into esame (matricola_studente,codice_modulo,matricola_docente,data,voto,note)
	values(123456,'inf01',54321,'2020-06-24',30,'database well built.');

create table IF NOT EXISTS dipartimento(
	codice varchar(5) PRIMARY KEY,
	nome varchar(50) NOT NULL
);

insert into dipartimento(codice, nome)
	values('uniba','informatica bari');

create table IF NOT EXISTS sede(
	codice varchar(5) PRIMARY KEY,
	indirizzo varchar(50) NOT NULL,
	citta varchar(30)
);

insert into sede(codice,indirizzo,citta)
	values('uniba','universita di bari','taranto');

create table IF NOT EXISTS sede_dipartimento(
		codice_sede varchar(5),
		FOREIGN KEY (codice_sede) REFERENCES sede(codice)
				ON UPDATE CASCADE
				ON DELETE NO ACTION,

	codice_dipartimento varchar(5),
	FOREIGN KEY(codice_dipartimento) REFERENCES dipartimento(codice)
						ON UPDATE CASCADE
						ON DELETE NO ACTION,
	note varchar(30),
	PRIMARY KEY (codice_sede, codice_dipartimento)
);

insert into sede_dipartimento(codice_sede,codice_dipartimento,note)
	values('uniba','uniba',NULL);
