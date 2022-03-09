alter procedure [dbo].[sp_gera_num_aleatorio]
					@qnt_min		int			
					,@qnt_max		int
					,@aleatorio		int			output		
as
	begin
		declare		@conta			int			=		0

		while @conta = 0
			begin
				BEGIN TRY
					set @aleatorio = format(RAND()*@qnt_max,'N0')
					--print @aleatorio
					if (@aleatorio >= @qnt_min and @aleatorio <= @qnt_max)
						set @conta = 1
					else
						set @conta = 0
				END TRY
				BEGIN CATCH
					set @conta = 0
				END CATCH
					
			end
		--waitfor delay '00:00:01'
		return convert(int,@aleatorio)
	end

-- CHAMADA:
--declare @result_proc int
--exec sp_gera_num_aleatorio @qnt_min = 1, @qnt_max = 4, @aleatorio = @result_proc OUTPUT
--print @result_proc


