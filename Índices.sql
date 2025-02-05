-- (C) Agência Veritatis 2024
-- Autor: Ivo Vieira

-- RM2 e RM7
CREATE INDEX idxCasoCliente ON Caso(Cliente);

-- RM4 e RM15
CREATE INDEX idxExerceFuncao ON Exerce(Funcao);

-- RM7
CREATE INDEX idxCasoDataInicio ON Caso(DataInicio);

-- RM15
CREATE INDEX idxFuncionarioNome ON Funcionario(Nome);
CREATE INDEX idxExerceFuncionario ON Exerce(Funcionario);

-- RM10
CREATE INDEX idxProcedimentoData ON Procedimento(Data);
CREATE INDEX idxProcedimentoCaso ON Procedimento(Caso);
CREATE INDEX idxProvasProcedimento ON Provas(Procedimento);

-- RM17
CREATE INDEX idxEmailsCliente ON Emails(Cliente);
CREATE INDEX idxTelefonesCliente ON Telefones(Cliente);
