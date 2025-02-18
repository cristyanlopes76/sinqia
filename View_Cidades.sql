-- View Cidades
-- 7
CREATE VIEW vw_Cidades AS
	SELECT Codigo_Cidade, 
	       Nome, 
		   Estado
	  FROM Cidades;
