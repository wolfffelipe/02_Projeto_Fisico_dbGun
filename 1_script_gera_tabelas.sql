
	IF OBJECT_ID('tb_usuario') IS NOT NULL
		DROP TABLE dbo.tb_usuario
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_usuario
		(
		id_usuario		int				NOT NULL				UNIQUE IDENTITY,
		nm_usuario		varchar(50)		NOT NULL,
		lg_usuario		varchar(30)		NOT NULL				UNIQUE,
		pass_usuario	varchar(8)		NOT NULL,
		dt_cad_usuario	date			NOT NULL,

		CONSTRAINT		PK_tb_usuario	PRIMARY KEY CLUSTERED	(id_usuario)
		)
	COMMIT

	IF OBJECT_ID('tb_empresa') IS NOT NULL
		DROP TABLE dbo.tb_empresa
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_empresa
		(
		id_empresa		int				NOT NULL				UNIQUE IDENTITY,
		nm_empresa		varchar(50)		NOT NULL,
		end_empresa		varchar(50)		NULL					DEFAULT		'Sem endereço',
		tel_empresa		varchar(15)		NULL					DEFAULT		'Sem telefone',

		CONSTRAINT		PK_tb_empresa	PRIMARY KEY CLUSTERED	(id_empresa)
		)
	COMMIT

	IF OBJECT_ID('tb_cliente') IS NOT NULL
		DROP TABLE dbo.tb_cliente
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_cliente
		(
		cpf_cliente		varchar(10)		NOT NULL				UNIQUE,
		craf_cliente	varchar(10)		NOT NULL,
		paf_cliente		varchar(10)		NOT NULL,
		cod_usuario		int				NOT NULL,

		CONSTRAINT		PK_tb_cliente	PRIMARY KEY CLUSTERED	(cpf_cliente),
		CONSTRAINT		FK_tb_cli_user	FOREIGN KEY 			(cod_usuario)	
										REFERENCES				tb_usuario(id_usuario)
		)
	COMMIT

	IF OBJECT_ID('tb_funcionario') IS NOT NULL
		DROP TABLE dbo.tb_funcionario
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_funcionario
		(
		mat_func		int				NOT NULL				UNIQUE IDENTITY,
		dt_adm_func		date			NOT NULL,
		salario_func	float			NULL					DEFAULT		0.0,
		cod_usuario		int				NOT NULL,
		cod_empresa		int				NOT NULL,

		CONSTRAINT		PK_tb_func		PRIMARY KEY CLUSTERED	(mat_func),
		CONSTRAINT		FK_tb_func_user	FOREIGN KEY 			(cod_usuario)	
										REFERENCES				tb_usuario(id_usuario),
		CONSTRAINT		FK_tb_func_emp	FOREIGN KEY 			(cod_empresa)	
										REFERENCES				tb_empresa(id_empresa)
		)
	COMMIT

	IF OBJECT_ID('tb_especializacao') IS NOT NULL
		DROP TABLE dbo.tb_especializacao
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_especializacao
		(
		id_especial		int				NOT NULL				UNIQUE IDENTITY,
		nm_especial		varchar(50)		NOT NULL,
		inst_especial	varchar(50)		NULL					DEFAULT		'Treinamento interno',

		CONSTRAINT		PK_tb_especial	PRIMARY KEY CLUSTERED	(id_especial)
		)
	COMMIT

	IF OBJECT_ID('tb_func_esp') IS NOT NULL
		DROP TABLE dbo.tb_func_esp
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_func_esp
		(
		cod_mat_func	int					NOT NULL,
		cod_especial	int					NOT NULL,

		CONSTRAINT		PK_tb_func_esp		PRIMARY KEY CLUSTERED	(cod_mat_func, cod_especial),
		CONSTRAINT		FK_tb_fe_func		FOREIGN KEY 			(cod_mat_func)	
											REFERENCES				tb_funcionario(mat_func),
		CONSTRAINT		FK_tb_fe_esp		FOREIGN KEY 			(cod_especial)	
											REFERENCES				tb_especializacao(id_especial)
		)
	COMMIT

	IF OBJECT_ID('tb_calibre') IS NOT NULL
		DROP TABLE dbo.tb_calibre
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_calibre
		(
		id_calibre		int					NOT NULL				UNIQUE IDENTITY,
		num_calibre		varchar(5)			NOT NULL,
		med_calibre		varchar(5)			NOT NULL,

		CONSTRAINT		PK_tb_calibre		PRIMARY KEY CLUSTERED	(id_calibre)
		)
	COMMIT

	IF OBJECT_ID('tb_armamento') IS NOT NULL
		DROP TABLE dbo.tb_armamento
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_armamento
		(
		id_arma			int					NOT NULL				UNIQUE IDENTITY,
		num_arma		varchar(20)			NOT NULL,
		model_arma		varchar(30)			NOT NULL,
		cpf_cliente		varchar(10)			NOT NULL,
		cod_calibre		int					NOT NULL,

		CONSTRAINT		PK_tb_arma			PRIMARY KEY CLUSTERED	(id_arma),
		CONSTRAINT		FK_tb_arma_cli		FOREIGN KEY 			(cpf_cliente)	
											REFERENCES				tb_cliente(cpf_cliente),
		CONSTRAINT		FK_tb_arma_cal		FOREIGN KEY 			(cod_calibre)	
											REFERENCES				tb_calibre(id_calibre)
		)
	COMMIT

	IF OBJECT_ID('tb_fase') IS NOT NULL
		DROP TABLE dbo.tb_fase
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_fase
		(
		id_fase			int					NOT NULL				UNIQUE,
		nm_fase			varchar(50)			NOT NULL,

		CONSTRAINT		PK_tb_fase			PRIMARY KEY CLUSTERED	(id_fase)
		)
	COMMIT

	IF OBJECT_ID('tb_manutencao') IS NOT NULL
		DROP TABLE dbo.tb_manutencao
	BEGIN TRANSACTION
	CREATE TABLE dbo.tb_manutencao
		(
		id_manut		int					NOT NULL				UNIQUE IDENTITY,
		dt_entrada		date				NOT NULL,
		dt_atualiza		date				NULL,
		valor_manut		float				NULL					DEFAULT		0.0,
		pg_manut		bit					NULL					DEFAULT		0,
		cod_mat_func	int					NOT NULL,
		cod_arma		int					NOT NULL,
		cod_fase		int					NOT NULL,

		CONSTRAINT		PK_tb_manut			PRIMARY KEY CLUSTERED	(id_manut),
		CONSTRAINT		FK_tb_mnt_func		FOREIGN KEY 			(cod_mat_func)	
											REFERENCES				tb_funcionario(mat_func),
		CONSTRAINT		FK_tb_mnt_arma		FOREIGN KEY 			(cod_arma)	
											REFERENCES				tb_armamento(id_arma),
		CONSTRAINT		FK_tb_mnt_fase		FOREIGN KEY 			(cod_fase)	
											REFERENCES				tb_fase(id_fase)
		)
	COMMIT


