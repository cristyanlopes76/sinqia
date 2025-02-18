-- do Teste Prático de Conhecimento em SQL
-- 1 
SELECT CLI.Nome
  FROM Clientes CLI
 WHERE EXISTS(
         SELECT 1 
		   FROM Cidades CID 
    	  WHERE CID.Nome          = 'TUPÃ' 
		    AND CID.Codigo_Cidade = CLI.Codigo_Cidade
);

-- 2
SELECT CLI.Nome, 
       CID.nome AS Cidade
  FROM Clientes CLI
  JOIN Cidades CID ON CID.Codigo_Cidade = CLI.Codigo_Cidade

-- 3
  SELECT Codigo_Cliente, 
         Nome
    FROM Clientes
ORDER BY Nome;

-- 4
DELETE FROM Clientes
 WHERE Codigo_Cliente BETWEEN 100 AND 200;

-- 5
UPDATE Cidades
   SET Estado = 'SP'
 WHERE Estado = 'PR';

-- 6
INSERT INTO CLIENTES (CGC_CPF_Cliente, Nome, Telefone, Endereco, Bairro, Complemento, E_mail, Codigo_Cidade, Cep)
VALUES 
    ('12345678900', 'Davi Lopes', '(11) 99879-4122', 'Rua Rui Barbosa, 11', 'Jardim Apoema', NULL, 'davifurtado@gmail.com', 1, '01030400');


