/*		CONSULTAS
		Quanto de cada mercadorias cada vendendor possui disponível. Quanto equivale isso em dinheiro. Gerar uma estimativa de faturamento
		Quanto de cada mercadoria estão disponíveis em cada estoque.
		Cada consulta acima deve retorna o seguinte: Poucas unidade/Requer nova aquisição de remessa/Bastante unidades em estoque
        Quem fornece, quem vende e onde está estocado cada produto
*/ 

-- retorna a quantidade de determinado produto em determinado estoque
select tipo as Produto, marca as Marca, quantidade_prodest as Quantidade, nome as Estoque from produto_estoque as pe
inner join produto on idProduto = pe.idProduto_prodest
inner join estoque on idEstoque = pe.idEstoque_prodest
;

-- retorna a quantidade de determinado produto disponível por cada vendedor
select nomefantasia as Vendedor, tipo as Produto, marca as Marca, quantidade_prodven as Quantidade from produto_vendedor
inner join vendedor on idVendedor = idVendedor_prodven
inner join produto on idProduto = idProduto_prodven
;


-- seleciona todos os produtos com menos de 100 unidades em estoque
select tipo as Produto, marca as Marca, quantidade_prodest as Quantidade, nome as Estoque from produto_estoque as pe
inner join produto on idProduto = pe.idProduto_prodest
inner join estoque on idEstoque = pe.idEstoque_prodest
having quantidade < 100;

