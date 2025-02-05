-- (C) Agência Veritatis 2024
-- Autores: Humberto Gomes

-- RM2
SELECT Cliente.Id, Cliente.Nome, Caso.Id, Caso.Designacao, Caso.DataInicio
    FROM Caso INNER JOIN Cliente ON Caso.Cliente = Cliente.Id
    WHERE Caso.DataTermino IS NULL
    ORDER BY Cliente.Nome ASC;

-- RM4
SELECT DISTINCT Funcao.Id, Funcao.Designacao
    FROM Exerce INNER JOIN Funcao ON Exerce.Funcao = Funcao.Id;

-- RM7
PREPARE RM7 FROM
    'SELECT Caso.Id, Caso.Designacao, Caso.DataInicio
        FROM Caso
        WHERE Caso.Cliente = ?
        ORDER BY Caso.DataInicio ASC;';

SET @RM7Cliente = 1;
EXECUTE RM7 USING @RM7Cliente;
DEALLOCATE PREPARE RM7;

-- RM10
PREPARE RM10 FROM
    'SELECT Provas.Descricao, Provas.Local, Procedimento.Data
        FROM Provas INNER JOIN Procedimento ON Provas.Procedimento = Procedimento.Id
        WHERE Procedimento.Caso = ?
        ORDER BY Procedimento.Data ASC;';

SET @RM10Caso = 6;
EXECUTE RM10 USING @RM10Caso;
DEALLOCATE PREPARE RM10;

-- RM13
PREPARE RM13 FROM
    'SELECT Casos.Detetive, Casos.Casos, COALESCE(Procedimentos.Procedimentos, 0) AS Procedimentos
        FROM (
            SELECT Caso.Detetive, COUNT(Caso.Id) AS Casos
                FROM Caso
                WHERE Caso.DataInicio > ?
                GROUP BY Caso.Detetive
        ) AS Casos LEFT JOIN (
            SELECT Caso.Detetive, COUNT(Procedimento.Id) AS Procedimentos
                FROM Procedimento INNER JOIN Caso ON Procedimento.Caso = Caso.Id
                WHERE Procedimento.Data > ?
                GROUP BY Caso.Detetive
        ) As Procedimentos ON Casos.Detetive = Procedimentos.Detetive;';

SET @RM13Data = '2020-01-01';
EXECUTE RM13 USING @RM13Data, @RM13Data;
DEALLOCATE PREPARE RM13;

-- RM14
SELECT
    Caso.Id,
    Caso.Designacao,
    COALESCE(CustosProcedimentos.CustoCliente, 0) + Caso.CustoAbertura AS CustoCliente,
    COALESCE(CustosProcedimentos.CustoAgencia, 0) AS CustoAgencia,
    COALESCE(CustosProcedimentos.CustoCliente, 0) + Caso.CustoAbertura - COALESCE(CustosProcedimentos.CustoAgencia, 0) AS Balanco
    FROM (
        SELECT
            Procedimento.Caso,
            SUM(Procedimento.CustoCliente) AS CustoCliente,
            SUM(Procedimento.CustoAgencia) AS CustoAgencia
            FROM Procedimento
            GROUP BY Procedimento.Caso
        ) AS CustosProcedimentos
        RIGHT JOIN Caso ON CustosProcedimentos.Caso = Caso.Id;

-- RM15
PREPARE RM15 FROM
    'SELECT Funcionario.Id, Funcionario.Nome
        FROM Exerce INNER JOIN Funcionario ON Exerce.Funcionario = Funcionario.Id
        WHERE Exerce.Funcao = ?
        ORDER BY Funcionario.Nome ASC;';

SET @RM15Funcao = 4;
EXECUTE RM15 USING @RM15Funcao;
DEALLOCATE PREPARE RM15;

-- RM17
PREPARE RM17 FROM
    'SELECT * FROM (
            SELECT Cliente.Id, Cliente.Nome, Emails.Email AS Contacto, ''Email'' AS Tipo
                FROM Emails INNER JOIN Cliente ON Emails.Cliente = Cliente.Id
                WHERE Cliente.Nome LIKE CONCAT(''%'', ?, ''%'')
        UNION
            SELECT Cliente.Id, Cliente.Nome, Telefones.Telefone AS Contacto, ''Telefone'' AS Tipo
                FROM Telefones INNER JOIN Cliente ON Telefones.Cliente = Cliente.Id
                WHERE Cliente.Nome LIKE CONCAT(''%'', ?, ''%'')
    ) AS Contactos
    ORDER BY Contactos.Nome ASC;';

SET @RM17Nome = 'Miguel';
EXECUTE RM17 USING @RM17Nome, @RM17Nome;
DEALLOCATE PREPARE RM17;

-- RM18 implementado como uma função

-- RM19
SELECT Id, Designacao, DataInicio
    FROM Caso
    WHERE DataTermino IS NULL;
