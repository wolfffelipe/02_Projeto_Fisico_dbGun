CREATE VIEW vw_info_funcionarios
AS
SELECT
	f.mat_func		AS	[Matrícula]
	,u.nm_usuario	AS	[Nome completo]
	,u.lg_usuario	AS	[Login]
	,f.salario_func	AS	[Salário]
	,e.nm_empresa	AS	[Empresa]
	FROM			dbo.tb_usuario u
	JOIN			dbo.tb_funcionario f
	ON				u.id_usuario		=	f.cod_usuario
	JOIN			dbo.tb_empresa e
	ON				e.id_empresa		=	f.cod_empresa