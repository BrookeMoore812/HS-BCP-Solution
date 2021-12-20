USE HealthStrategy
;
GO
CREATE FUNCTION dbo.ConvertOverpunch (@ValueToConvert VARCHAR(100))
RETURNS BIGINT
AS
BEGIN
	DECLARE @ReturnValue BIGINT;

	SET @ReturnValue = CAST(LEFT(@ValueToConvert, LEN(@ValueToConvert) - 1) AS BIGINT) * 10
	+ 
		IIF(
			ISNUMERIC(RIGHT(@ValueToConvert, 1)) = 1 
			, CAST(RIGHT(@ValueToConvert, 1) AS INT)
			, IIF (
				RIGHT(@ValueToConvert, 1) IN ('{','}')
				, 0
				, IIF (
					RIGHT(@ValueToConvert, 1) < 'J'
					, ASCII(RIGHT(@ValueToConvert, 1)) - ASCII('@')
					, ASCII('I') - ASCII(RIGHT(@ValueToConvert, 1))
				)
			)
		)
	;

	RETURN @ReturnValue
END
GO