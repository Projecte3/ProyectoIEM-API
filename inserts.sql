insert into families_profesionals(nom) values
("Informatica"),
("Administratiu"),
("Automocio"),
("Manteniment i serveis de produccio"),
("Fabricacio mecanica"),
("Aigües");

insert into cicles(nom, familia_profesional) values
("Sistemes microinformatics i xarxes",1),
("Gestio administrativa",2),
("Electromecanica de vehicles automobils",3),
("Manteniment electromecanics",4),
("Mecanitzacio",5),

("Administracio de sistemes informatics en xarxa - orientat a Ciberseguretat",1),
("Desenvolupament d’aplicacions multiplataforma",1),
("Desenvolupament d’aplicacions web",1),
("Administracio i finances",2),
("Assistencia a la direccio",2),
("Automocio",3),
("Mecatronica industrial",4),
("Programacio de la produccio en fabricacio mecanica",5),
("Gestio de l’aigua",6);

INSERT INTO ocupacions(nom, cicle) 
VALUES ("Personal tecnic de suport informatic",1),
("Personal tecnic de xarxes de dades",1),
("Personal reparador de periferics de sistemes microinformatics",1),
("Comercials de microinformatica",1),
("Personal operador de teleassistencia",1),
("Personal operador de sistemes",1),
("Personal auxiliar administratiu",2),
("Personal ajudant d’oficina",2),
("Personal auxiliar administratiu de cobraments i pagaments",2),
("Personal administratiu comercial",2),
("Personal auxiliar administratiu de gestio de personal",2),
("Personal auxiliar administratiu de les administracions publiques",2),
("Recepcionista",2),
("Personal empleat d’atencio al client",2),
("Personal empleat de tresoreria",2),
("Personal empleat de mitjans de pagament",2),
("Electronicistes de vehicles", 3),
("Electricistes electronics de manteniment i reparacio en automocio", 3),
("Personal mecanic d’automobils", 3),
("Electricistes d’automobils", 3),
("Personal electromecanic d’automobils", 3),
("Personal mecanic de motors i els seus sistemes auxiliars d’automobils i motocicletes", 3),
("Personal reparador de sistemes pneumatics i hidraulics", 3),
("Personal reparador de sistemes de transmissio i de frens", 3),
("Personal reparador de sistemes de direccio i suspensio", 3),
("Personal operari d'ITV.", 3),
("Personal instal·lador d’accessoris en vehicles.", 3),
("Personal operari d’empreses dedicades a la fabricacio de recanvis.", 3),
("Personal electromecanic de motocicletes.", 3),
("Personal venedor/distribuïdor de recanvis i d’equips de diagnosi.", 3),
("Mecanic de manteniment",4),
("Muntador industrial",4),
("Muntador d'equips electrics",4),
("Muntador d'equips electronics",4),
("Mantenidor de linia automatitzada",4),
("Muntador de bens d'equip",4),
("Muntador d'automatismes pneumatics i hidraulics",4),
("Instal·lador electricista industrial",4),
("Electricista de manteniment i reparacio d'equips de control, mesura i precisio",4),
('Personal ajustador operari de maquines eina', 5),
('Personal polidor de metalls i afilador d’eines', 5),
('Personal operador de maquines per treballar metalls', 5),
('Personal operador de maquines eina', 5),
('Personal operador de robots industrials', 5),
('Personal treballador de la fabricacio d’eines, mecanic i ajustador, modelista matricer i similars', 5),
('Personal torner, fresador i mandrinador', 5),
('Personal tecnic en administracio de sistemes', 6),
('Responsable d’informatica', 6),
('Personal tecnic en serveis d’Internet', 6),
('Personal tecnic en serveis de missatgeria electronica', 6),
('Personal de recolzament i suport tecnic', 6),
('Personal tecnic en teleassistencia', 6),
('Personal tecnic en administracio de base de dades', 6),
('Personal tecnic de xarxes', 6),
('Personal supervisor de sistemes', 6),
('Personal tecnic en serveis de comunicacions', 6),
('Personal tecnic en entorns web', 6),
('Desenvolupar aplicacions informatiques per a la gestio empresarial i de negoci.', 7),
('Desenvolupar aplicacions de proposit general.', 7),
('Desenvolupar aplicacions en l’ambit de l’entreteniment i la informatica mobil.', 7),
('Programador web', 8),
('Programador multimedia', 8),
('Desenvolupador d’aplicacions en entorns web', 8),('Administratiu d''oficina', 9),
('Administratiu comercial', 9),
('Administratiu financer', 9),
('Administratiu comptable', 9),
('Administratiu de logistica', 9),
('Administratiu de banca i d''assegurances', 9),
('Administratiu de recursos humans', 9),
('Administratiu de l''Administracio publica', 9),
('Administratiu d''assessories juridiques, comptables, laborals, fiscals o gestories', 9),
('Tecnic en gestio de cobraments', 9),
('Responsable d''atencio al client', 9),
( 'Assistent a la direccio', 10 ),
( 'Assistent personal', 10 ),
( 'Secretari de direccio', 10 ),
( 'Assistent de despatxos i oficines', 10 ),
( 'Assistent juridic', 10 ),
( 'Assistent en departaments de recursos humans', 10 ),
( 'Assistent en departaments de recursos humans', 10 ),
('Cap de l’area d’electromecanica', 11),
('Recepcionista de vehicles', 11),
('Cap de taller de vehicles de motor', 11),
('Personal encarregat d’ITV', 11),
('Personal perit taxador de vehicles', 11),
('Cap de servei', 11),
('Personal encarregat d’area de recanvis', 11),
('Personal encarregat d’area comercial d’equips relacionats amb els vehicles', 11),
('Cap de l’area de carrosseria: xapa i pintura', 11),
('Tecnic en planificacio i programacio de processos de manteniment d''instal·lacions de maquinaria i equip industrial.', 12),
('Cap d''equip de muntadors d''instal·lacions de maquinaria i equip industrial.', 12),
('Cap d''equip de mantenidors d''instal·lacions de maquinaria i equip industrial.', 12),
('Tecnic o tecnica en mecanica', 13),
('Encarregat o encarregada d''instal·lacions de processament de metalls', 13),
('Encarregat o encarregada d''operadors de maquines per treballar metalls', 13),
('Encarregat o encarregada de muntadors', 13),
('Programador o programadora de CNC (control numeric amb ordinador)', 13),
('Programador o programadora de sistemes automatitzats en fabricacio mecanica', 13),
('Programador o programadora de la produccio', 13),
('Encargado de montaje de redes de abastecimiento y distribucion de agua.', 14),
('Encargado de montaje de redes e instalaciones de saneamiento.', 14),
('Encargado de mantenimiento de redes de agua.', 14),
('Encargado de mantenimiento de redes de saneamiento.', 14),
('Operador de planta de tratamiento de agua de abastecimiento.', 14),
('Operador de planta de tratamiento de aguas residuales.', 14),
('Tecnico en gestion del uso eficiente del agua.', 14),
('Tecnico en sistemas de distribucion de agua.', 14);



