Server=localhost\SQLEXPRESS;Database=master;Trusted_Connection=True;
DESKTOP-ACBC9GS\Cristyan
SQLENGINE
16.0.1000.6, RTM

USE DBDados;

CREATE TABLE CIDADES (
    Codigo_Cidade INT PRIMARY KEY IDENTITY(1,1), 
    Nome VARCHAR(100) NOT NULL,                 
    Estado CHAR(2) NOT NULL,                   
    Cep_Inicial CHAR(8) NOT NULL,               
    Cep_Final CHAR(8) NOT NULL,                 
    CONSTRAINT CHK_Cep_Range CHECK (Cep_Inicial <= Cep_Final) 
);

INSERT INTO CIDADES (Nome, Estado, Cep_Inicial, Cep_Final)
VALUES 
    ('São Paulo', 'SP', '01000000', '05999999'),
    ('Rio de Janeiro', 'RJ', '20000000', '28999999'),
    ('Tupã', 'SP', '17600000', '17699999'),
    ('Tanabi', 'SP', '15170000', '15179999');

CREATE FUNCTION dbo.ValidarCep (@Codigo_Cidade INT, @Cep CHAR(8))
RETURNS BIT
AS
BEGIN
    DECLARE @Resultado BIT = 0;

    IF EXISTS (
        SELECT 1
        FROM CIDADES
        WHERE Codigo_Cidade = @Codigo_Cidade
          AND @Cep BETWEEN Cep_Inicial AND Cep_Final
    )
    BEGIN
        SET @Resultado = 1;
    END

    RETURN @Resultado;
END;

CREATE TABLE CLIENTES (
    Codigo_Cliente INT PRIMARY KEY IDENTITY(1,1),
    CGC_CPF_Cliente VARCHAR(14) NOT NULL UNIQUE,
    Nome VARCHAR(100) NOT NULL,                 
    Telefone VARCHAR(15),                       
    Endereco VARCHAR(200) NOT NULL,             
    Bairro VARCHAR(100) NOT NULL,               
    Complemento VARCHAR(100),                   
    E_mail VARCHAR(100),                        
    Codigo_Cidade INT NOT NULL,                 
    Cep CHAR(8) NOT NULL,                       
    CONSTRAINT FK_CLIENTES_CIDADES FOREIGN KEY (Codigo_Cidade) REFERENCES CIDADES(Codigo_Cidade),      
    CONSTRAINT CHK_Cep_Valido CHECK (dbo.ValidarCep(Codigo_Cidade, Cep) = 1)
);

INSERT INTO CLIENTES (CGC_CPF_Cliente, Nome, Telefone, Endereco, Bairro, Complemento, E_mail, Codigo_Cidade, Cep)
VALUES 
    ('26884980885', 'Cristyan Lopes', '(17) 99119-6169', 'Rua Liberdade, 145', 'Jardim Ideal', 'Apto 10', 'cristyanlopes@hotmail.com', 3, '17603280'),
    ('30208685804', 'Priscila Furtado', '(17) 99717-6152', 'Rua Pedro Garcia Cano, 90', 'Nova Tanabi', NULL, 'pfurtado@gmail.com', 4, '15170010');
	

CREATE PROCEDURE sp_ListarClientes
    @Codigo_Cliente_Inicial INT = 0,
    @Codigo_Cliente_Final INT = 0,
    @Codigo_Cidade_Inicial INT = 0,
    @Codigo_Cidade_Final INT = 0,
    @Estado NVARCHAR(2) = ''
AS
BEGIN
    SET NOCOUNT ON;

		SELECT Cli.Codigo_Cliente,
			   Cli.Nome,
			   Cli.Codigo_Cidade,
			   CID.Nome as Cidade,
			   CID.Estado
          FROM Clientes Cli
    INNER JOIN Cidades CID ON CID.Codigo_Cidade = Cli.Codigo_Cidade
         WHERE (@Codigo_Cliente_Inicial = 0 OR Cli.Codigo_Cliente >= @Codigo_Cliente_Inicial)
           AND (@Codigo_Cliente_Final   = 0 OR Cli.Codigo_Cliente <= @Codigo_Cliente_Final)
           AND (@Codigo_Cidade_Inicial  = 0 OR Cli.Codigo_Cidade  >= @Codigo_Cidade_Inicial)
           AND (@Codigo_Cidade_Final    = 0 OR Cli.Codigo_Cidade  <= @Codigo_Cidade_Final)
           AND (@Estado = '' OR CID.Estado = @Estado)
    ORDER BY CID.Nome, Cli.Nome;
END;
	