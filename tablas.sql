drop table if exists ocupacions;
drop table if exists cicles;
drop table if exists families_profesionals;
drop table if exists ranking;

create table if not exists families_profesionals (
	id integer primary key auto_increment,
    nom varchar(100)
);

create table if not exists cicles (
	id integer primary key auto_increment,
    nom varchar(100),
    familia_profesional integer,
    foreign key (familia_profesional) references families_profesionals(id)
);

create table if not exists ocupacions (
	id integer primary key auto_increment,
    nom varchar(400),
    cicle integer,
    foreign key (cicle) references cicles(id)
);

create table if not exists ranking (
	id integer primary key auto_increment,
    nom_jugador varchar(100),
    cicle varchar(100),
    puntuacio float,
    temps_emprat double,
    items_correctes integer,
    items_incorrectes integer,
    ip_origen varchar(100),
    dispositiu varchar(100),
    ocult boolean
);

create table if not exists connexions (
    id integer primary key auto_increment,
    ip_origen varchar(100),
    hora_conexion timestamp,
    tipus_connexio varchar(100)
);