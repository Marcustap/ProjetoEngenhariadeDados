-- Criacao de Trigger para atualizacao de veiculo alugado ou disponivel
CREATE OR REPLACE FUNCTION atualizar_veiculo()
RETURNS trigger AS
$$
BEGIN
UPDATE Relacional.veiculos SET STATUS = 'Alugado' WHERE New.idveiculo = veiculos.idveiculo;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_veiculo AFTER INSERT ON Relacional.locacao FOR EACH ROW EXECUTE PROCEDURE atualizar_veiculo();


-- Trigger para verificar se veiculo locado esta disponivel
CREATE OR REPLACE FUNCTION verificar_veiculo_disponivel()
RETURNS trigger AS $$
BEGIN
IF (SELECT veiculos.status FROM Relacional.Veiculos WHERE veiculos.idveiculo = NEW.idveiculo) = 'Alugado' THEN
RAISE EXCEPTION 'Veiculo ja em uso';
ELSIF (SELECT veiculos.status FROM Relacional.Veiculos WHERE veiculos.idveiculo = NEW.idveiculo) = 'Indisponivel' THEN
RAISE EXCEPTION 'Veiculo indisponivel';
RETURN NEW;
END IF;
END;
$$
LANGUAGE plpgsql;



CREATE TRIGGER trg_verificar_veiculo_disponivel BEFORE INSERT ON Relacional.locacao FOR EACH ROW EXECUTE PROCEDURE verificar_veiculo_disponivel();


