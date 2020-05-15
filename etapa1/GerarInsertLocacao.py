# -*- coding: utf-8 -*-
# importa os módulos necessários
import random
import time
from datetime import datetime, timedelta, date
import psycopg2

# estabelece conexão com o banco de dados
con = psycopg2.connect(host='localhost', database='locadora', user='postgres', password='postgres123')
cur = con.cursor()

def strTimeProp(start, end, format, prop):
    """
    Função que retorna uma data dentro de um range de duas datas (retirada da web).
    start and end should be strings specifying times formated in the
    given format (strftime-style), giving an interval [start, end].
    prop specifies how a proportion of the interval to be taken after
    start.  The returned time will be in the specified format.
    """

    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(format, time.localtime(ptime))


def randomDate(start, end, prop):
    """
    Função que é chamada para criar a data aleatória
    Start = a data de início
    end = a data final
    prop = modo como a data será sorteada

    """
    return strTimeProp(start, end, '%d/%m/%Y', prop)

def calc_valor(numero, dias):
    """
    Funcão para calcular o valor total do aluguel do veículo
    :param id: Id do veiculo selecionado
    :param dias: quantidade de dias que o veiculo foi alugado
    :return: valor da diaria do veiculo * dias alugados
    """
    if dias == 0:
	dias += 1
    numero = str(numero)
    queryValorDiaria = "SELECT valordiaria FROM Relacional.veiculos WHERE idveiculo = (%s)"
    cur.execute(queryValorDiaria, (numero,))
    resultado = cur.fetchall()
    valor = ''
    for rec in str(resultado):
	if rec.isdigit() or rec == '.':
	    valor += rec
    valor = float(valor)
    return  valor * dias

def random_id(l):
    """
    Função que seleciona um número aleatório
    :param l: Número limite para a função random
    :return: número aleatório entre 1 e o limite passado por parâmetro
    """
    numeroId = ''
    for x in str(l):
	if x.isdigit():
	    numeroId += x
    numeroId = int(numeroId)
    return str(random.randint(1, numeroId))

def define_insert():
    """
    Função que retorna o comando SQL de Insert como uma String
    """

    queryNumeroIdcliente = "SELECT COUNT(*) FROM Relacional.clientes;"  # seleciona o numero de clientes
    cur.execute(queryNumeroIdcliente)  # executa a query
    numeroClientes = cur.fetchall()
    

    queryNumeroIdveiculo = "SELECT COUNT(*) FROM Relacional.veiculos;"  # seleciona o numero de veiculos
    cur.execute(queryNumeroIdveiculo)  # executa a query
    numeroVeiculos= cur.fetchall()

    queryNumeroIddespachante = "SELECT COUNT(*) FROM Relacional.despachantes;"  # seleciona o numero de despachantes
    cur.execute(queryNumeroIddespachante)  # executa a query
    numeroDespachantes = cur.fetchall()

    id_cliente = random_id(numeroClientes)
    id_veiculo = random_id(numeroVeiculos)
    id_despachante = random_id(numeroDespachantes)

    # chama a função para sortear as datas
    data_locacao = randomDate("01/09/2019", "30/04/2020", random.random())  # data em formato string

    d_l = datetime.strptime(data_locacao, "%d/%m/%Y")  # data em formato date
    d_e = d_l + timedelta(days=15)  # a data da entrega sempre terá no máximo 15 dias a mais da data da locação

    data_entrega = randomDate(data_locacao, d_e.strftime('%d/%m/%Y'), random.random())  # data em formato string
    data_entrega_formatada = datetime.strptime(data_entrega, '%d/%m/%Y')  # data entrega em formato Date para calculo de quantidade de dias

    qtd_dias = abs((data_entrega_formatada - d_l).days)  # calcula a quantidade de dias do aluguel do veículo
    valor_total = "%.2f" % calc_valor(id_veiculo, qtd_dias)  # chama a funçao de calcular o valor passando o id do veiculo e a quantidade de dias

    return "INSERT INTO Relacional.Locacao (IDveiculo, IDcliente, IDdespachante, DataLocacao, DataEntrega, ValorTotal) VALUES ('" + id_veiculo + "', '" + id_cliente + "', '" + id_despachante + "', '" + data_locacao + "', '" + data_entrega + "', " + valor_total + "); \n"


# define a quantidade de INSERTS e escreve em arquivo externo em formato SQL
for i in range(0, 150):
    with open('InsertLocacao.sql', 'a') as arquivo:
        arquivo.write(define_insert())
        arquivo.close()
