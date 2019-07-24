ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
FLUSH privileges;

CREATE DATABASE ace;

use ace;

CREATE TABLE ace.tbl_ace_tipos_regla(
	id smallint unsigned not null auto_increment,
	descripcion varchar(100) NOT NULL,
	es_multi_producto CHAR(1) NULL,
	constraint pk_tipo_regla PRIMARY KEY (id));

INSERT INTO ace.tbl_ace_tipos_regla(descripcion, es_multi_producto) values('Autogestion', 'S');
INSERT INTO ace.tbl_ace_tipos_regla(descripcion, es_multi_producto) values('Relacionados', 'S');

CREATE TABLE ace.tbl_ace_reglas(
	id int unsigned not null auto_increment,
	descripcion varchar(100) NOT NULL,
	estado NUMERIC(2,0) NULL,
	permite_aprobacion CHAR(1) NULL,
	tipo_regla_id smallint unsigned NOT NULL,
	usuario_modificacion varchar(50) NOT NULL,
	fecha_modificacion TIMESTAMP NOT NULL,
	constraint pk_regla PRIMARY KEY(id));

ALTER TABLE ace.tbl_ace_reglas ADD CONSTRAINT FK_regla_tipoRegla FOREIGN KEY(tipo_regla_id)
REFERENCES ace.tbl_ace_tipos_regla(id);

INSERT INTO ace.tbl_ace_reglas(descripcion, estado, permite_aprobacion, tipo_regla_id, usuario_modificacion, fecha_modificacion) 
values('Regla de Autogestión', 1, 'N', 1, 'User', NOW());
INSERT INTO ace.tbl_ace_reglas(descripcion, estado, permite_aprobacion, tipo_regla_id, usuario_modificacion, fecha_modificacion) 
values('Regla de Relacionados', 1, 'N', 2, 'User', NOW());

CREATE TABLE ace.tbl_ace_tipos_caracteristica(
	id smallint unsigned not null auto_increment,
	nombre varchar(100) NOT NULL,
	es_obligatorio CHAR(1) NULL,
	es_multiple CHAR(1) NULL,
	constraint pk_tipo_caracteristica PRIMARY KEY(id));

CREATE TABLE ace.tbl_ace_caracteristicas(
	id int unsigned not null auto_increment,
	regla_id int unsigned NOT NULL,
	tipo_caracteristica_id smallint unsigned NOT NULL,
	valor varchar(500) NOT NULL,
	constraint pk_caracteristica PRIMARY KEY(id));

ALTER TABLE ace.tbl_ace_caracteristicas ADD CONSTRAINT FK_caracteristica_regla FOREIGN KEY(regla_id)
REFERENCES ace.tbl_ace_reglas(id);

ALTER TABLE ace.tbl_ace_caracteristicas ADD CONSTRAINT FK_caracteristica_tipoCaracteristica FOREIGN KEY(tipo_caracteristica_id)
REFERENCES ace.tbl_ace_tipos_caracteristica(id);


CREATE TABLE ace.tbl_ace_tipos_producto(
	id smallint unsigned not null auto_increment,
	nombre varchar(50) NOT NULL,
	codigo varchar(50) NOT NULL,
	constraint pk_tipo_producto PRIMARY KEY(id));

INSERT INTO ace.tbl_ace_tipos_producto(nombre, codigo) VALUES ('Renta fija', 'RF');
INSERT INTO ace.tbl_ace_tipos_producto(nombre, codigo) VALUES ('Renta variable', 'RV');

CREATE TABLE ace.tbl_ace_productos_regla(
	id int unsigned not null auto_increment,
	regla_id int unsigned NOT NULL,
	tipo_producto_id smallint unsigned NOT NULL,
	valor varchar(100) NULL,
	estado NUMERIC(2,0) NULL,
	constraint pk_producto_regla PRIMARY KEY(id));

ALTER TABLE ace.tbl_ace_productos_regla ADD CONSTRAINT FK_productoRegla_regla FOREIGN KEY(regla_id)
REFERENCES ace.tbl_ace_reglas(id);

ALTER TABLE ace.tbl_ace_productos_regla ADD CONSTRAINT FK_productoRegla_tipoProducto FOREIGN KEY(tipo_producto_id)
REFERENCES ace.tbl_ace_tipos_producto (id);

INSERT INTO ace.tbl_ace_productos_regla(regla_id, tipo_producto_id, estado) VALUES (1, 1, 1);
INSERT INTO ace.tbl_ace_productos_regla(regla_id, tipo_producto_id, estado) VALUES (1, 2, 2);
INSERT INTO ace.tbl_ace_productos_regla(regla_id, tipo_producto_id, estado) VALUES (2, 1, 2);
INSERT INTO ace.tbl_ace_productos_regla(regla_id, tipo_producto_id, estado) VALUES (2, 2, 1);

CREATE TABLE ace.tbl_ace_tipos_periodo(
	id smallint unsigned not null auto_increment,
	nombre varchar(100) NULL,
	num_meses NUMERIC(2,0) NULL,
	num_dias NUMERIC(2,0) NULL,
	constraint pk_tipo_periodo PRIMARY KEY(id));

CREATE TABLE ace.tbl_ace_vigencias(
	id int unsigned not null auto_increment,
	regla_id int unsigned NOT NULL,
	fecha_inicio DATE NULL,
	fecha_final DATE NULL,
	tipo_periodo_id smallint unsigned NULL,
	rango varchar(50) NULL,
	constraint pk_vigencia PRIMARY KEY(id));

ALTER TABLE ace.tbl_ace_vigencias ADD CONSTRAINT FK_vigencia_regla FOREIGN KEY(regla_id)
REFERENCES ace.tbl_ace_reglas (id);

ALTER TABLE ace.tbl_ace_vigencias ADD CONSTRAINT FK_vigencia_tipoPeriodo FOREIGN KEY(tipo_periodo_id)
REFERENCES ace.tbl_ace_tipos_periodo (id);
