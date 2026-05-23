-- ======================================================
-- SCRIPT DE ESTRUTURAÇÃO DO BANCO DE DADOS (POSTGRESQL)
-- PROJETO: ANÁLISE ENEM ASSIS-SP
-- ======================================================

-- 1. Criação da tabela principal com regras de integridade (CHECK)
CREATE TABLE tb_enem_assis (
    nu_inscricao BIGINT PRIMARY KEY,
    no_municipio_prova VARCHAR(50),
    tp_escola INT CHECK (tp_escola IN (2, 3)), -- 2=Pública, 3=Privada
    nu_nota_mt DECIMAL(5,1),
    nu_nota_redacao DECIMAL(5,1)
);

-- 2. Inserção de amostra para validação do esquema
INSERT INTO tb_enem_assis (nu_inscricao, no_municipio_prova, tp_escola, nu_nota_mt, nu_nota_redacao)
VALUES 
(240001, 'Assis', 2, 510.5, 620.0),
(240002, 'Assis', 3, 715.2, 880.0),
(240003, 'Assis', 2, 480.0, 540.0);

-- 3. Criação da VIEW para análise de médias por rede de ensino
CREATE VIEW v_medias_por_escola AS
SELECT 
    CASE WHEN tp_escola = 2 THEN 'Pública' ELSE 'Privada' END AS rede_ensino,
    ROUND(AVG(nu_nota_mt), 2) AS media_matematica,
    ROUND(AVG(nu_nota_redacao), 2) AS media_redacao
FROM tb_enem_assis
GROUP BY tp_escola;

-- 4. Consulta de verificação final
SELECT * FROM v_medias_por_escola;
