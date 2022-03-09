set nocount on

--begin transaction

declare @func int, @arma int, @fase int, @mes int, @dia int, @data1 varchar(10), @data2 varchar(10), @valor float, @pg bit

declare @quantos_registros int
set @quantos_registros = 0
while @quantos_registros <= 200000
begin
	exec sp_gera_num_aleatorio	@qnt_min = 100, @qnt_max = 10000,	@aleatorio = @valor		OUTPUT
	exec sp_gera_num_aleatorio	@qnt_min = 0,	@qnt_max = 1,		@aleatorio = @pg		OUTPUT
	exec sp_gera_num_aleatorio	@qnt_min = 1,	@qnt_max = 5,		@aleatorio = @arma		OUTPUT
	exec sp_gera_num_aleatorio	@qnt_min = 1,	@qnt_max = 9,		@aleatorio = @fase		OUTPUT

	exec sp_gera_num_aleatorio	@qnt_min = 1,	@qnt_max = 12,		@aleatorio = @mes		OUTPUT
	exec sp_gera_num_aleatorio	@qnt_min = 1,	@qnt_max = 30,		@aleatorio = @dia		OUTPUT
		set @data1 = concat('2024-', @mes, '-', @dia)

	exec sp_gera_num_aleatorio	@qnt_min = 1,	@qnt_max = 12,		@aleatorio = @mes		OUTPUT
	exec sp_gera_num_aleatorio	@qnt_min = 1,	@qnt_max = 30,		@aleatorio = @dia		OUTPUT
		set @data2 = concat('2025-', @mes,'-', @dia)

	exec sp_gera_num_aleatorio	@qnt_min = 1,	@qnt_max = 12,		@aleatorio = @func		OUTPUT
	if @func = 2 set @func = 1

	BEGIN TRY
		INSERT INTO [dbo].[tb_manutencao] ([dt_entrada],[dt_atualiza],[valor_manut],[pg_manut],[cod_mat_func],[cod_arma],[cod_fase])
		VALUES (@data1,@data2,@valor,@pg
		,@func --1 3 4 ou 5 
		,@arma --1 2 3 4 ou 5
		,@fase -- 1 ao 9
		)
		set @quantos_registros += 1
		--commit
	END TRY
	BEGIN CATCH
		set @quantos_registros = @quantos_registros
	END CATCH
end

select * from tb_manutencao order by id_manut desc offset 0 rows fetch next 5 rows only
select count(*) from tb_manutencao

-------------------------- DOBRAR VALORES DA TABELA
--INSERT INTO tb_manutencao ([dt_entrada],[dt_atualiza],[valor_manut],[pg_manut],[cod_mat_func],[cod_arma],[cod_fase])
--SELECT      M.[dt_entrada],M.[dt_atualiza],M.[valor_manut],M.[pg_manut],M.[cod_mat_func],M.[cod_arma],M.[cod_fase]
--FROM        tb_manutencao M
--select * from tb_manutencao

---------------------------TESTE
--declare @teste bit
--exec sp_gera_num_aleatorio @qnt_min = 0, @qnt_max = 1, @aleatorio = @teste OUTPUT
--print @teste

---------------------------DELETAR
--delete from tb_manutencao where id_manut = 3

---------------------------VOLTAR
--rollback

---------------------------FINALIZAR
--commit