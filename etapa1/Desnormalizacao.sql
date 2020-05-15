SELECT
	clientes.Nome,
	clientes.datanascimento,
	clientes.telefone,
	clientes.status,
	clientes.cpf,
	clientes.numerocnh,
	locacao.datalocacao,
	locacao.dataentrega,
	locacao.valortotal,
	despachantes.nome as nome_desp,
	despachantes.status as status_desp,
	despachantes.filial,
	veiculos.dataaquisicao,
	veiculos.ano,
	veiculos.modelo,
	veiculos.placa,
	veiculos.status as status_veiculo,
	veiculos.valordiaria

	INTO relacional.des_locacao

	FROM Relacional.clientes
	inner join relacional.locacao on clientes.idcliente = locacao.idcliente
	inner join relacional.despachantes on despachantes.iddespachante = locacao.iddespachante
	inner join relacional.veiculos on veiculos.idveiculo = locacao.idveiculo;
