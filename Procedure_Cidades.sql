-- Procedure Cidades
-- 8
CREATE PROCEDURE sp_ManageCidades (
    @Operacao CHAR(1),
    @Codigo_Cidade INT = NULL,
    @Cidade NVARCHAR(100) = NULL,
    @Estado CHAR(2) = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @Operacao = 'I' -- Inserir
    BEGIN
        INSERT INTO Cidades (Nome, Estado) VALUES (@Cidade, @Estado);
    END
    ELSE IF @Operacao = 'U' -- Atualizar
    BEGIN
        UPDATE Cidades SET Nome = @Cidade, Estado = @Estado WHERE Codigo_Cidade = @Codigo_Cidade;
    END
    ELSE IF @Operacao = 'D' -- Deletar
    BEGIN
        DELETE FROM Cidades WHERE Codigo_Cidade = @Codigo_Cidade;
    END
END;
