show databases;
-- drop database ecommerce;
-- Criação do banco de dados para o e-commerce

create database ecommerce;
use ecommerce;
show tables;
-- Criando a tabela cliente
-- drop table clients;
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Mnameinit varchar(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(200),
    constraint unique_cpf_client unique (CPF)
	);

-- Criando a tabela produto

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(45) not null,
    classification_kids bool default false,
    category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    rating float default 0,
    size varchar(10)
	);
    
-- Criando a tabela pedido

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Confirmado', 'compra via web site', 'compra via aplicativo', 'Processando') default 'Processando',
    orderDescription varchar(25),
    shipping_price float default 0.0,
    order_price float,
    paymentCash boolean default 0,
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient)
	);

-- criando tabela estoque 

create table productStock(
	idPstock int auto_increment primary key,
    storageLocation varchar(45),
    quantity int default 0
    );

-- criando tabela fornecedor

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(45) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_suplier unique (CNPJ)
	);
    
-- criando tabela vendedor

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(45) not null,
    AbstName varchar(45),
    CNPJ char(15),
	CPF char(9),
    location varchar(45),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
	constraint unique_cpf_seller unique (CPF)
	);

-- criando table Produto/Vendendor

create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPseller, idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
	);
    
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_porder_product foreign key (idPOproduct) references product(idProduct),
    constraint fk_porder_order foreign key (idPOorder) references orders(idOrder)
	);
    
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(45) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storagel_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storagel_storage foreign key (idLstorage) references productStock(idPstock)
	);
    
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_psupplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_psupplier_product foreign key (idPsProduct) references product(idProduct)
	);