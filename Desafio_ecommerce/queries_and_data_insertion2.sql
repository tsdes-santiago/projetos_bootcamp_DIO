-- inserção de dados e queries
use ecommerce2;

show tables;

insert into clients (ClientType)
		values('PF'),
			  ('PF'),
              ('PF'),
              ('PF'),
              ('PF'),
              ('PF');
select * from clients;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into clientPF (Client_idClient, Fname, Mnameinit, Lname, CPF, Address) 
	   values(1, 'Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
		     (2, 'Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores'),
			 (3, 'Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores'),
			 (4,'Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores'),
			 (5,'Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores'),
			 (6,'Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores');

select * from clientPF as cPF , clients as c
		where cPF.Client_idClient = c.idClient;

insert into clients (ClientType)
		values('PJ'),
			  ('PJ'),
              ('PJ');
              
insert into clientPJ (Client_idClient, SocialName, AbstName, CNPJ, Address, contact)
				values(7,'Tech eletronics', null, 123456789456321, 'Rio de Janeiro', 219946287),
					  (8,'Botique Durgas',null, 123456783932412,'Rio de Janeiro', 219567895),
					  (9,'Kids World',null,456789123654485,'São Paulo', 1198657484);

select * from clientPJ as cPJ , clients as c
		where cPJ.Client_idClient = c.idClient;

-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
insert into product (Pname, classification_kids, category, rating, size) values
							  ('Fone de ouvido',false,'Eletrônico','4',null),
                              ('Barbie Elsa',true,'Brinquedos','3',null),
                              ('Body Carters',true,'Vestimenta','5',null),
                              ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null),
                              ('Sofá retrátil',False,'Móveis','3','3x57x80'),
                              ('Farinha de arroz',False,'Alimentos','2',null),
                              ('Fire Stick Amazon',False,'Eletrônico','3',null);

select * from clients;
select * from product;

-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash

-- delete from orders where idOrderClient in  (1,2,3,4);
insert into orders (idOrderClient, orderStatus, orderDescription, shipping_price, order_price) values 
							 (1, default,'compra via aplicativo', default, 80.00),
                             (2,default,'compra via aplicativo',50, 120.00),
                             (3,'Confirmado',null, default, 150.00),
                             (4,default,'compra via web site',150, 1500.00);


select * from orders;

-- Métodos de pagamento 'cartão', 'pix', 'boleto'
insert into Payment (idPaymentOrder, Pmethod) values
				(1, 'cartão'),
                (2, 'boleto'),
                (4, 'cartão'),
                (3, 'pix');
                
select * from Payment;

-- informações frete
-- status 'aguardando coleta', 'enviado', 'em trânsito', 'saiu para entrega', 'entregue'
insert into Delivery (idDeliveryOrder, DeliveryStatus, Courier) values
				(1, 'aguardando coleta', default),
                (2, 'em trânsito', 'DHL'),
                (4, 'entregue', default),
                (3, 'entregue', 'FEDEX');

select * from Delivery;					
-- idPOproduct, idPOorder, poQuantity, poStatus

insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
						 (1,1,2,null),
                         (2,1,1,null),
                         (3,2,1,null);

-- storageLocation,quantity
insert into productStock (storageLocation,quantity) values 
							('Rio de Janeiro',1000),
                            ('Rio de Janeiro',500),
                            ('São Paulo',10),
                            ('São Paulo',100),
                            ('São Paulo',10),
                            ('Brasília',60);

-- idLproduct, idLstorage, location
insert into storageLocation (idLproduct, idLstorage, location) values
						 (1,2,'RJ'),
                         (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier (SocialName, CNPJ, contact) values 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
                            
select * from supplier;
-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity) values
						 (1,1,500),
                         (1,2,400),
                         (2,4,633),
                         (3,3,5),
                         (2,5,10);

-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact) values 
						('Tech eletronics', null, 123456789456321, null, 'Rio de Janeiro', 219946287),
					    ('Botique Durgas',null,null,123456783,'Rio de Janeiro', 219567895),
						('Kids World',null,456789123654485,null,'São Paulo', 1198657484);

select * from seller;
-- idPseller, idPproduct, prodQuantity
insert into productSeller (idPseller, idPproduct, prodQuantity) values 
						 (1,6,80),
                         (2,7,10);

select * from productSeller;

select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from clientPF c, orders o where c.idClientPF = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, shipping_price, order_price) values 
							 (2, default,'compra via aplicativo',default, 250.0);
                             
select count(*) from clients c, orders o 
			where c.idClient = idOrderClient;

select * from orders;

-- recuperação de pedido com produto associado
select * from clientPF c 
				inner join orders o ON c.Client_idClient = o.idOrderClient
                inner join productOrder p on p.idPOorder = o.idOrder
		group by Client_idClient; 

select * from clientPJ c 
				inner join orders o ON c.Client_idClient = o.idOrderClient
                inner join productOrder p on p.idPOorder = o.idOrder
		group by Client_idClient; 

-- Recuperar quantos pedidos foram realizados pelos clientes?

select c.idClient, count(*) as Number_of_orders from clients c
		inner join orders o ON c.idClient = o.idOrderClient
		group by idClient; 
        
-- Acessando o Fname na table clientPF com outro join
select cpf.Fname as First_name from clientPF cpf
				inner join orders o ON cpf.Client_idClient = o.idOrderClient;  
                
select c.idClient, cpf.Fname, count(*) as Number_of_orders from clients c
		inner join orders o ON c.idClient = o.idOrderClient
        inner join clientPF cpf ON c.idClient = cpf.Client_idClient
		group by idClient; 
 