-- (C) Agência Veritatis 2024
-- Autores: José Matos

INSERT INTO Funcao(Id, Designacao) VALUES
    (1, 'Gestor financeiro'),
    (2, 'Gestor de recursos humanos'),
    (3, 'Administrativo'),
    (4, 'Detetive'),
    (5, 'Assistente operacional');

INSERT INTO Funcionario(Id, Nome, NIF, Salario, SeguroVida, Email, Telefone) VALUES
    (1, 'Elias Ribeiro', 132164128, 4000.00, NULL, 'ddt@veritatis.pt', 936563339),
    (2, 'Orlando Feio', 128256512, 2500.00, 753638026, 'feio@veritatis.pt', 253000111),
    (3, 'Jacinto Fonseca', 170169196, 1200.00, NULL, 'fonseca@veritatis.pt', NULL),
    (4, 'Efigénia Leite', 143233777, 2300.00, 752742000, 'leite@veritatis.pt', 253000222);

INSERT INTO Cliente(Id, Nome, Morada, NIF, LocalTrabalho) VALUES
    (1, 'Orlando Manuel Oliveira Belo', NULL, 128129130, 'Universidade do Minho'),
    (2, 'João Miguel Lobo Fernandes', NULL, 155200200, 'Universidade do Minho'),
    (3, 'Vitor Francisco Mendes Freitas Gomes Fonte', NULL, 177188199, 'Universidade do Minho'),
    (4, 'João Alexandre Baptista Vieira Saraiva', NULL, 221196677, 'Universidade do Minho'),
    (5, 'Pedro Miguel Silva Paiva António', 'Ed.7, Sala 1.04, Rua da Universidade, Braga 4710-057', 111222333, 'Universidade do Minho'),
    (6, 'Paulo Manuel Martins Carvalho', NULL, 314782421, 'Universidade do Minho');

INSERT INTO Exerce(Funcao, Funcionario) VALUES
    (1, 1),
    (2, 1),
    (3, 3),
    (4, 2),
    (4, 4);

INSERT INTO Caso(Id, Designacao, DataInicio, DataTermino, DataPagamento, CustoAbertura, Cliente, Detetive) VALUES
    (1, 'Clube da Luta', '2020-12-05', '2021-05-04', '2021-05-10', 300.00, 1, 2),
    (2, 'Atrasos Suspeitos', '2021-06-12', '2021-09-24', '2021-10-01', 300.00, 2, 2),
    (3, 'Ministros, Coitados', '2022-04-01', '2022-07-07', '2022-08-01', 300.00, 3, 4),
    (4, 'O Silêncio Dos Inocentes', '2023-01-01', '2023-05-16', '2023-05-19', 350.00, 4, 2),
    (5, 'Vermes na Cantina', '2023-09-09', '2024-02-29', '2024-03-13', 400.00, 5, 4),
    (6, 'Meias Rotas', '2024-01-01', '2024-03-30', NULL, 450.00, 1, 2),
    (7, 'Operação Visconde', '2024-02-12', NULL, NULL, 450.0, 6, 4),
    (8, 'O Barulho Dos Culpados', '2024-03-13', NULL, NULL, 450.00, 3, 2);

INSERT INTO TipoProcedimento (Id, Designacao, CustoAgencia, CustoCliente, Descricao) VALUES
    (1, 'Observação de Manchas de Sangue', 0020.00, 0049.99, 'Através da topografia das manchas, é possível (...)'),
    (2, 'Revistar o Local de Trabalho', 0100.00, 0199.99, 'Abordagem ao cliente, de modo a (...)'),
    (3, 'Monitorização de Suspeitos', 0100.00, 0305.00, 'Consiste na observação detalhada do dia a dia (...)'),
    (4, 'Inquérito', 0000.00, 0160.99, 'Com o objetivo de serem esclarecidas possíveis (...)'),
    (5, 'Pizza Party', 0600.20, 0999.00, 'Os agentes também merecem alguma diversão');

INSERT INTO Emails (Cliente, Email) VALUES
    (1, 'obelo@di.uminho.pt'),
    (2, 'jmf@di.uminho.pt'),
    (3, 'vff@di.uminho.pt'),
    (4, 'saraiva@di.uminho.pt'),
    (5, 'd12943@di.uminho.pt'),
    (6, 'pmc@di.uminho.pt'),
    (6, 'd1542@di.uminho.pt');

INSERT INTO Telefones (Cliente, Telefone) VALUES
    (1, '253604476'),
    (1, '91600900'),
    (3, '253604485'),
    (6, '253604432');

INSERT INTO Procedimento (Id, Tipo, Notas, Data, CustoAgencia, CustoCliente, Caso) VALUES
    (1, 1, 'Salpicos, projeção do sangue feita sob impulso', '2020-12-10', 0015.00, 0039.99, 1),
    (2, 3, 'Suspeitos ocupados a tentar passar às outras cadeiras', '2020-12-19', 0085.00, 170.00, 1),
    (3, 2, 'O escritório da vítima contém testes todos com classificações negativas', '2021-06-13', 0100.00, 0199.99, 2),
    (4, 2, 'Dez dias depois, todos os testes tinham classificação de 20', '2021-06-23', 0100.00, 0199.99, 2),
    (5, 4, 'Parece que o trabalho de LI3 é fazer uma base de dados para o ministério', '2022-04-10', 0000.00, 0160.99, 3),
    (6, 2, 'Demasiado barulho...', '2023-01-14', 0100.00, 0199.99, 4),
    (7, 2, 'É impossível isto ser regulado pela ASAE...', '2023-09-09', 0100.00, 0199.99, 5),
    (8, 5, 'Isto foi preciso depois de ver a comida', '2023-09-10', 0600.20, 0999.00, 5),
    (9, 2, 'Demasiadas meias, os buracos formam um padrão...', '2024-02-10', 0100.00, 0199.99, 6),
    (10, 3, 'O suspeito é regular de um café na rua vermelha', '2024-02-15', 0100.00, 0305.00, 6);

INSERT INTO Provas (Procedimento, Descricao, Local) VALUES
    (3, 'Teste do suspeito principal (2.3 valores)', 'Gabinete 3.22, Ed. 7, Universidade do Minho'),
    (3, 'Pauta final da UC', 'Gabinete 3.22, Ed. 7, Universidade do Minho'),
    (6, 'Nota escrita por uma testemunha inocente (os inocentes quebraram o silêncio)', 'Edifício de Psicologia, Universidade do Minho, Gualtar'),
    (7, 'Lasanha envenenada com sementes de Ricinus communis L.', 'Grill, Universidade do Minho, Gualtar'),
    (9, 'Faca usada para romper as meias cravada na secretária', 'Gabinete 3.08, Ed. 7, Universidade do Minho'),
    (10, 'Bilhete rasgado depositado no lixo pelo suspeito', 'Shady Coffee, Rua Vermelha, Gualtar');
