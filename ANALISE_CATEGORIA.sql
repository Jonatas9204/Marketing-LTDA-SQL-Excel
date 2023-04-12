

--ANALISE DE VENDAS POR CATEGORIA DO PRODUTO--
--------------------------------------------------------------
--Na análise da tabela foi identificado na coluna de         -
--categoria do produto campos em branco que foram convertidos- 
--para nulo, nesse CASE desconsideraremos Nulo para          -  
--uma construção mais clean do dashboard.                    -
--------------------------------------------------------------
SELECT * FROM TB_ACT_OLIST_PRODUCTS
WHERE PRODUCT_CATEGORY_NAME is null;

UPDATE TB_ACT_OLIST_PRODUCTS
SET PRODUCT_CATEGORY_NAME = NULL
WHERE PRODUCT_CATEGORY_NAME = ' ';

SELECT TOP 10 *   FROM [Olist].[dbo].[TB_ACT_OLIST_ORDER_ITEM]
SELECT TOP 10 *   FROM TB_ACT_OLIST_PRODUCTS

------------------------------------------------
--ANALISE DE AGRUPAMENTO  PRODUTO/CATEGORIA--
------------------------------------------------
SELECT P.PRODUCT_ID, SUM(PRICE + FREIGHT_VALUE) AS PRECO_MAIS_FRETE, P.PRODUCT_CATEGORY_NAME 
FROM TB_ACT_OLIST_ORDER_ITEM AS ITEM
JOIN TB_ACT_OLIST_PRODUCTS AS P ON ITEM.PRODUCT_ID = P.PRODUCT_ID
WHERE PRODUCT_CATEGORY_NAME is not NULL
GROUP BY P.PRODUCT_ID, PRODUCT_CATEGORY_NAME;

----------------------------------------
--ANALISE DE AGRUPAMENTO POR CATEGORIA--
----------------------------------------

CREATE VIEW VW_VENDEDOR_CATEGORIA1 

AS 

SELECT S.SELLER_ID AS VENDEDOR, s.seller_state as Estado_Vendedor, P.PRODUCT_CATEGORY_NAME, SUM(PRICE + FREIGHT_VALUE) AS Vendido 
FROM TB_ACT_OLIST_ORDER_ITEM AS ITEM
JOIN TB_ACT_OLIST_PRODUCTS AS P ON ITEM.PRODUCT_ID = P.PRODUCT_ID
join TB_ACT_OLIST_SELLERS as S ON ITEM.SELLER_ID = S.SELLER_ID
WHERE PRODUCT_CATEGORY_NAME is not NULL
GROUP BY S.SELLER_ID, PRODUCT_CATEGORY_NAME, SELLER_STATE ;

SELECT * FROM VW_VENDEDOR_CATEGORIA1

