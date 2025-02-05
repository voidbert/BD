-- (C) Agência Veritatis 2024
-- Autores: José Lopes, José Matos e Humberto Gomes

-- EncheBD

-- Ter a BD sempre povoada antes de correr este procedimento
-- SOURCE Criação.sql;

DROP PROCEDURE IF EXISTS EncheBD;

DELIMITER $$
CREATE PROCEDURE EncheBD(IN nrRegistos INT)
BEGIN
    DECLARE dt DATE DEFAULT CURDATE();

    START TRANSACTION;

    REPEAT
        INSERT INTO Funcao(Id, Designacao) VALUES
            (nrRegistos, REPEAT('A', 20));
        INSERT INTO Funcionario(Id, Nome, NIF, Salario, SeguroVida, Email, Telefone) VALUES
            (nrRegistos, REPEAT('A', 30), 100000000 + nrRegistos, 0000.00, 111111111, LPAD(nrRegistos, 30, '0'), LPAD(nrRegistos, 9, '0'));
        INSERT INTO Exerce(Funcao, Funcionario) VALUES
            (nrRegistos, nrRegistos);
        INSERT INTO Cliente(Id, Nome, Morada, NIF, LocalTrabalho) VALUES
            (nrRegistos, REPEAT('A', 30), REPEAT('A', 35), 100000000 + nrRegistos, REPEAT('A', 35));
        INSERT INTO Emails(Cliente, Email) VALUES
            (nrRegistos, LPAD(nrRegistos, 30, '0'));
        INSERT INTO Telefones(Cliente, Telefone) VALUES
            (nrRegistos, LPAD(nrRegistos, 9, '0'));
        INSERT INTO Caso(Id, Designacao, DataInicio, DataTermino, DataPagamento, CustoAbertura, Cliente, Detetive) VALUES
            (nrRegistos, REPEAT('A', 20), dt, dt, dt, 000.00, nrRegistos, nrRegistos);

        IF nrRegistos % 10 = 0 THEN
            INSERT INTO TipoProcedimento(Id, Designacao, CustoAgencia, CustoCliente, Descricao) VALUES
                (nrRegistos, REPEAT('A', 20), 000.00, 000.00, REPEAT('A', 2000));
            INSERT INTO Procedimento(Id, Tipo, Notas, Data, CustoAgencia, CustoCliente, Caso) VALUES
                (nrRegistos, nrRegistos, REPEAT('A', 2000), dt, 000.00, 000.00, nrRegistos);
            INSERT INTO Provas(Procedimento, Descricao, Local) VALUES
                (nrRegistos, REPEAT('A', 2000), REPEAT('A', 35));
        END IF;

        SET nrRegistos = nrRegistos - 1;
    UNTIL nrRegistos = 0
    END REPEAT;

    COMMIT;
END $$
DELIMITER ;

CALL EncheBD(1000);

-- RM18

DROP FUNCTION IF EXISTS RM18;

DELIMITER $$
CREATE FUNCTION RM18(IdCaso INT)
    RETURNS TEXT
    NOT DETERMINISTIC
    SQL SECURITY INVOKER
    READS SQL DATA
BEGIN
    DECLARE Abertura DECIMAL(8, 2);
    DECLARE Total DECIMAL(8, 2);
    DECLARE Fatura TEXT;

    DECLARE Fim INTEGER DEFAULT 0;
    DECLARE Item VARCHAR(100);
    DECLARE Itens CURSOR FOR
        SELECT CONCAT(TipoProcedimento.Designacao, ': ', Procedimento.CustoCliente, '€')
            FROM Procedimento INNER JOIN TipoProcedimento ON Procedimento.Tipo = TipoProcedimento.Id
            WHERE Procedimento.Caso = IdCaso;

    DECLARE CONTINUE HANDLER
        FOR NOT FOUND SET Fim = 1;

    -- Inicialização
    SET Fatura = '';
    SELECT Caso.CustoAbertura INTO Abertura
        FROM Caso
        WHERE Caso.Id = IdCaso;
    SELECT COALESCE(SUM(Procedimento.CustoCliente), 0) + Abertura INTO Total
        FROM Procedimento
        WHERE Procedimento.Caso = IdCaso;

    -- Verificar se o caso existe
    IF Abertura IS NULL THEN
        SET Fatura = CONCAT('Caso ', IdCaso, ' não encontrado!');
        RETURN Fatura;
    END IF;

    -- Mostrar itens da fatura
    OPEN Itens;
    processaItem: LOOP
        FETCH Itens INTO Item;
        IF Fim = 1 THEN
            LEAVE processaItem;
        END IF;

        SET Fatura = CONCAT(Fatura, Item, '\n');
    END LOOP processaItem;
    CLOSE Itens;

    IF Fatura = '' THEN
        SET Fatura = 'Sem procedimentos a apresentar!\n';
    END IF;

    -- Mostrar valores finais
    SET Fatura = CONCAT(Fatura, '\nCustoAbertura: ', Abertura, '€');
    SET Fatura = CONCAT(Fatura, '\nTotal: ', Total, '€');

    RETURN Fatura;
END $$
DELIMITER ;

GRANT EXECUTE ON FUNCTION RM18 TO
    'administrador'@'localhost',
    'administrativo'@'localhost',
    'detetive'@'localhost';

-- Herança de custo dos procedimentos

DROP TRIGGER IF EXISTS ProcedimentoHerdarCusto;

DELIMITER $$
CREATE TRIGGER ProcedimentoHerdarCusto
    BEFORE INSERT ON Procedimento
    FOR EACH ROW
BEGIN
    DECLARE Custo DECIMAL(5, 2);

    IF NEW.CustoAgencia = 0 THEN
        SELECT CustoAgencia INTO Custo
            FROM TipoProcedimento
            WHERE Id = NEW.Tipo;
        SET NEW.CustoAgencia = Custo;
    END IF;

    IF NEW.CustoCliente = 0 THEN
        SELECT CustoCliente INTO Custo
            FROM TipoProcedimento
            WHERE Id = NEW.Tipo;
        SET NEW.CustoCliente = Custo;
    END IF;
END $$
DELIMITER ;
