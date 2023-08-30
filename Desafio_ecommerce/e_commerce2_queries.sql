use ecommerce2;

show tables;

select * from orders;
select * from clients;

-- Recuperar preços de frete e de pedidos por tipo de cliente
select c.idClient, c.ClientType, o.idOrder, o.shipping_price as Shipping, o.order_price as Price from clients c
		inner join orders o ON o.idOrderClient = c.idClient;
        
-- Recuperar nome e preços de frete e de pedidos por clientes PF

select cpf.Fname, c.idClient, cpf.CPF, o.idOrder, o.shipping_price as Shipping, o.order_price as Price from clients c
		inner join orders o ON o.idOrderClient = c.idClient
        inner join clientPF cpf ON cpf.Client_idClient = c.idClient;

-- Valor total frete+pedido para clientes PF 

select concat(cpf.Fname, ' ', cpf.Lname) as Nome, o.idOrder, round(o.shipping_price + o.order_price,2) as Total from clients c
		inner join orders o ON o.idOrderClient = c.idClient
        inner join clientPF cpf ON cpf.Client_idClient = c.idClient;

-- Valor total frete+pedido para clientes PF ordenados por valor
select concat(cpf.Fname, ' ', cpf.Lname) as Nome, o.idOrder, round(o.shipping_price + o.order_price,2) as Total from clients c
		inner join orders o ON o.idOrderClient = c.idClient
        inner join clientPF cpf ON cpf.Client_idClient = c.idClient
        order by Total;
        
-- Valor total frete+pedido para clientes PF ordenados por valor, compras com frete gratis
select concat(cpf.Fname, ' ', cpf.Lname) as Nome, o.idOrder, round(o.shipping_price + o.order_price,2) as Total from clients c
		inner join orders o ON o.idOrderClient = c.idClient
        inner join clientPF cpf ON cpf.Client_idClient = c.idClient
        where o.shipping_price = 0;
        
-- Clientes que fizeram mais de 1 pedido

select c.idClient, cpf.Fname, count(*) as Number_of_orders from clients c
		inner join orders o ON c.idClient = o.idOrderClient
        inner join clientPF cpf ON c.idClient = cpf.Client_idClient
		group by idClient
        having Number_of_orders > 1;