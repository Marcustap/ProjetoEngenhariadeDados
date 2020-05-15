# ProjetoEngenhariadeDados
Projeto prático proposto como encerramento do curso Engenharia de Dados: Domine BigData!

Projeto proposto como encerramento do Curso Engenharia de DadosComo proposta de encerramento do curso, foi proposto a realização de um projeto dividido em quatro partes:

1ª Parte: Criação de um Banco de Dados com Modelo Relacional de uma empresa fictícia de locação de carros autônomos. 
  - Todos os dados fictícios usados para popular o Banco de Dados foram oferecidos no curso; 
  - Entretanto, a tabela Relacional.locacao foi preenchida através do arquivo "GerarInsertLocacao.py" que gera a quantidade necessária de Inserts de maneira aleatória.
  - PostgreSQL foi o banco de dados utilizado.
  
2ª Parte: Criar Modelo Dimensional do Banco de Dados para oferecer relatórios analíticos. 
  - Nesta etapa foram criadas Views para responder as seguintes questões: 
    - Quais e quantos veículos foram locados por mês; 
    - Quais despachantes locaram quais veículos por mês; 
    - Qual o faturamento por veículo por mês; 
    - Qual o faturamento por despachante por mês.
    
3ª Parte: Criação de sistema para armazenamento de contratos eletrônicos. 
  - Aqui os dados em formato json foram importados para um banco de dados no MongoDB.
  
4ª Parte: Gerenciar o número de contratos de risco. 
  - Como a indicação se um contrato é de risco ou não está localizada no corpo do contrato, a questão foi solucionada através de uma aplicação utilizando Pyspark que conta as vezes que a palavra "risco" aparece no arquivo json.
