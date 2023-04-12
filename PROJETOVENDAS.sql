select top 5 * from TB_CG_OLIST_COSTUMER;
select top 5 * from TB_CG_OLIST_GEOLOCATION;
select top 5 * from TB_CG_OLIST_ORDER_ITEMS;
select top 5 * from TB_CG_OLIST_ORDER_PAYMENTS;
select top 5 * from TB_CG_OLIST_ORDERS;
select top 5 * from TB_CG_OLIST_PRODUCTS;
select top 5 * from TB_CG_OLIST_SELLERS;
select top 5 * from TB_CG_PRODUCT_CATEGORY;




--ATUALIZAÇÃO DOS TIPOS DAS COLUNAS E CRIAÇÃO DA TABELA DE PRODUÇÃO--
---------------------------------------------
select top 10 * from TB_CG_OLIST_COSTUMER;

create table TB_ACT_OLIST_CUSTOMER (
COSTUMER_ID Nvarchar (80),
COSTUMER_UNIQUE_ID NVARCHAR (80),
COSTUMER_ZIP_CODE_PREFIX NVARCHAR (15),
COSTUMER_CITY NVARCHAR (80),
COSTUMER_STATE VARCHAR (2)
)

insert into TB_ACT_OLIST_CUSTOMER
select * from TB_CG_OLIST_CUSTOMER;
-----------------------------------------
-----------------------------------------


select top 10 * from TB_CG_OLIST_GEOLOCATION;

create table TB_ACT_OLIST_GEOLOCATION (
GEOLOCATION_ZIP_CODE_PREFIX Nvarchar (10),
GEOLOCATION_LAT NVARCHAR (100),
GEOLOCATION_LNG NVARCHAR (100),
GEOLOCATION_CITY NVARCHAR (80),
GEOLOCATION_STATE VARCHAR (2)
)

insert into TB_ACT_OLIST_GEOLOCATION
select * from TB_CG_OLIST_GEOLOCATION;

-------------------------------------------
-------------------------------------------
select * from TB_ACT_OLIST_ORDER_ITEM;
USE OLIST
create table TB_ACT_OLIST_ORDER_ITEM (
ORDER_ID Nvarchar (100),
ORDER_ITEM_ID NVARCHAR (10),
PRODUCT_ID NVARCHAR (100),
SELLER_ID NVARCHAR (100),
SHIPPING_LIMIT_DATE DATETIME,
PRICE FLOAT,
FREIGHT_VALUE FLOAT
)

insert into TB_ACT_OLIST_ORDER_ITEM
select * from TB_CG_OLIST_ORDER_ITEMS;

-------------------------------------------
------------------------------------------- 
select top 10 * from TB_CG_OLIST_ORDER_PAYMENTS;

create table TB_ACT_OLIST_ORDER_PAYMENTS (
ORDER_ID Nvarchar (100),
PAYMENT_SEQUENTIAL NVARCHAR (30),
PAYMENT_TYPE NVARCHAR (100),
PAYMENT_INSTALLMENTS NVARCHAR (80),
PAYMENT_VALUE float
)

insert into TB_ACT_OLIST_GEOLOCATION
select * from TB_CG_OLIST_GEOLOCATION;

--------------------------------------------
--------------------------------------------

create table TB_ACT_OLIST_ORDERS (
ORDER_ID Nvarchar (100),
CUSTOMER_ID NVARCHAR (100),
ORDER_STATUS NVARCHAR (100),
ORDER_PURCHASE_TIMESTAMP DATETIME,
ORDER_APPROVED_AT DATETIME,
ORDER_DELIVERED_CARRIER_DATE DATETIME,
ORDER_DELIVERED_COSTUMER_DATE DATETIME,
ORDER_ESTIMATED_DELIVERY_DATE DATETIME

)

insert into TB_ACT_OLIST_ORDERS
select * from TB_CG_OLIST_ORDERS;

------------------------------------------
------------------------------------------
select top 10 * from TB_CG_OLIST_PRODUCTS;

create table TB_ACT_OLIST_PRODUCTS (
PRODUCT_ID Nvarchar (100),
PRODUCT_CATEGORY_NAME NVARCHAR (80),
PRODUCT_NAME_LENGHT INT,
PRODUCT_DESCRIPTION_LENGHT INT,
PRODUCT_PHOTOS_QTY INT,
PRODUCT_WEIGHT_G FLOAT,
PRODUCT_LENGHT_CM FLOAT,
PRODUCT_HEIGHT_CM INT,
PRODUCT_WIDTH_CM INT
)

insert into TB_ACT_OLIST_PRODUCTS
select * from TB_CG_OLIST_PRODUCTS;

------------------------------------------
------------------------------------------
select top 10 * from TB_ACT_OLIST_SELLERS;

create table TB_ACT_OLIST_SELLERS (
SELLER_ID Nvarchar (100),
SELLER_ZIP_CODE_PREFIX NVARCHAR (80),
SELLER_CITY NVARCHAR(50),
SELLER_STATE NVARCHAR(2),

)

insert into TB_ACT_OLIST_SELLERS
select * from TB_CG_OLIST_SELLERS;
------------------------------------------------------- --------
--convertendo campos em branco para nulo para converter em data
--(Processo realizado em todas as colunas da tabela orders de data)
----------------------------------------------------------------
update TB_CG_OLIST_ORDERS set ["order_estimated_delivery_date"] = null
where ["order_estimated_delivery_date"]=''

-------------------------------------------------------------
--Área de Negócio solicita uma análise dos dados 
--de vendas, para identificar uma possivel oportunidade de
--marketing direcionado para os ESTADOS com poucas vendas.
-------------------------------------------------------------

select top 5 * from TB_ACT_OLIST_ORDERS
select top 5 * from TB_ACT_OLIST_CUSTOMER
-------------------------------------------------------------------
-------------------------------------------------------------------
--As views abaixo busca as informações por cidade e estado gerando-
--grande volume de linhas, como o CASE solicita por VENDAS/ESTADO,- 
-- utilizaremos a segunda sitaxe agrupando por Estado, trazendo   -
-- apenas 27 linhas.                                              -
--------------------------------------------------------------------
--------------------------------------------------------------------
select o.ORDER_STATUS, c.COSTUMER_STATE, c.COSTUMER_CITY  from TB_ACT_OLIST_ORDERS as o
join TB_ACT_OLIST_CUSTOMER as c on c.COSTUMER_ID = o.CUSTOMER_ID
where ORDER_STATUS = 'delivered';

select count(order_id) as total_vendas, c.costumer_state from tb_act_olist_orders as o
join TB_ACT_OLIST_CUSTOMER as c on c.COSTUMER_ID = o.CUSTOMER_ID
where ORDER_STATUS = 'delivered'
group by c.COSTUMER_STATE
order by total_vendas;
-------------------------------------------------------------------------------------

create VIEW VW_PEDIDOS_ESTADO AS

select count(order_id) as total_vendas, c.costumer_state from tb_act_olist_orders as o
join TB_ACT_OLIST_CUSTOMER as c on c.COSTUMER_ID = o.CUSTOMER_ID
where ORDER_STATUS = 'delivered'
group by c.COSTUMER_STATE

SELECT * FROM VW_PEDIDOS_ESTADO;







