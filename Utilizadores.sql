-- (C) Agência Veritatis 2024
-- Autores: Humberto Gomes

-- CRIAR ROLES
DROP ROLE IF EXISTS
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';
CREATE ROLE
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';

-- RC1 / RM1
GRANT INSERT, UPDATE, SELECT ON Cliente TO
    'administrativo'@'localhost';
GRANT INSERT, UPDATE, DELETE, SELECT ON Emails TO
    'administrativo'@'localhost';
GRANT INSERT, UPDATE, DELETE, SELECT ON Telefones TO
    'administrativo'@'localhost';

-- RM2
GRANT SELECT(Id, Nome) ON Cliente TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';
GRANT SELECT(Id, Designacao, DataInicio, DataTermino, Cliente) ON Caso TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';

-- RM3 / RC2
GRANT
    INSERT(Id, Designacao, DataInicio, CustoAbertura, Cliente),
    SELECT(Id, Designacao, DataInicio, CustoAbertura, Cliente) ON Caso
        TO 'administrativo'@'localhost';

-- RM4
GRANT SELECT(Id, Designacao) ON Funcao TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';
GRANT SELECT(Funcao) ON Exerce TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';

-- RM5 / RC3
GRANT INSERT, SELECT ON Funcao TO
    'administrador'@'localhost';

-- RM6 / RC4
GRANT INSERT, UPDATE, DELETE, SELECT ON Funcionario TO
    'administrador'@'localhost';
GRANT INSERT, DELETE, SELECT ON Exerce TO
    'administrador'@'localhost';

-- RM7
GRANT SELECT(Id, Designacao, DataInicio, Cliente) ON Caso TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';

-- RM8 / RC5
 GRANT INSERT(Id, Tipo, Notas, Data, Caso), SELECT ON Procedimento TO
    'detetive'@'localhost';

-- RM9 / RC6
GRANT INSERT, SELECT ON TipoProcedimento TO
    'administrador'@'localhost';

-- RM10 / RC7
GRANT SELECT(Id, Data, Caso) ON Procedimento TO
    'detetive'@'localhost';
GRANT SELECT(Procedimento, Descricao, Local) ON Provas TO
    'detetive'@'localhost';

-- RM11 / RC8
GRANT UPDATE(DataTermino), SELECT(Id, Designacao, Cliente) ON Caso TO
    'detetive'@'localhost';

-- RM12 / RC9
GRANT UPDATE(Detetive), SELECT(Id, Designacao, Cliente) ON Caso TO
    'administrador'@'localhost';

-- RM13 / RC10
GRANT SELECT(Id, DataInicio, Detetive) ON Caso TO
    'administrador'@'localhost';
GRANT SELECT(Id, Caso, Data) ON Procedimento TO
    'administrador'@'localhost';

-- RM14 / RC11
GRANT SELECT(Id, Designacao, CustoAbertura) ON Caso TO
    'administrador'@'localhost';
GRANT SELECT(Caso, CustoCliente, CustoAgencia) ON Procedimento TO
    'administrador'@'localhost';

-- RM15
GRANT SELECT(Id, Nome) ON Funcionario TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';
GRANT SELECT(Funcionario, Funcao) ON Exerce TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';

-- RM16 / RC12
GRANT UPDATE(DataPagamento), SELECT(Id, Designacao, Cliente) ON Caso TO
    'administrativo'@'localhost';

-- RM17
GRANT SELECT(Id, Nome) ON Cliente TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';
GRANT SELECT(Cliente, Email) ON Emails TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';
GRANT SELECT(Cliente, Telefone) ON Telefones TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';

-- RM18
GRANT SELECT(Id, CustoAbertura) ON Caso TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';
GRANT SELECT(Tipo, CustoCliente, Caso) ON Procedimento TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';
GRANT SELECT(Id, Designacao) ON TipoProcedimento TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';

-- RM19
GRANT SELECT(Id, Designacao, DataInicio, DataTermino) ON Caso TO
    'administrativo'@'localhost',
    'detetive'@'localhost',
    'administrador'@'localhost';

-- EXTRAS
GRANT UPDATE(CustoAgencia, CustoCliente) ON TipoProcedimento TO
    'administrador'@'localhost';
GRANT INSERT On Provas TO
    'detetive'@'localhost';

-- FIX MySQL BUG IN RM3
REVOKE INSERT ON Caso FROM
    'administrador'@'localhost',
    'detetive'@'localhost';

-- CRIAR UTILIZADORES
DROP USER IF EXISTS
    'elias.ribeiro'@'localhost',
    'orlando.feio'@'localhost',
    'jacinto.fonseca'@'localhost';
CREATE USER
    'elias.ribeiro'@'localhost'   IDENTIFIED BY 'donodistotudo',
    'orlando.feio'@'localhost'    IDENTIFIED BY 'alterego',
    'jacinto.fonseca'@'localhost' IDENTIFIED BY 'fonmolhada';

GRANT 'administrador'@'localhost' TO 'elias.ribeiro'@'localhost';
SET DEFAULT ROLE 'administrador'@'localhost' TO 'elias.ribeiro'@'localhost';

GRANT 'detetive'@'localhost' TO 'orlando.feio'@'localhost';
SET DEFAULT ROLE 'detetive'@'localhost' TO 'orlando.feio'@'localhost';

GRANT 'administrativo'@'localhost' TO 'jacinto.fonseca'@'localhost';
SET DEFAULT ROLE 'administrativo'@'localhost' TO 'jacinto.fonseca'@'localhost';
