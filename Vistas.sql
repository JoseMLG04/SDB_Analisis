-- VIEW 1
/*
Resumen de los servicios
*/
CREATE VIEW vw_customer_services AS
SELECT 
    cust.CUS_ID,
    cust.CUS_FIRST_NAME,
    cust.CUS_LAST_NAME,
    srv.SER_SERVICENAME,
    srv.SER_VALUE
FROM 
    SDB_CUSTOMER cust
JOIN 
    SDB_ORDER ord ON cust.CUS_ID = ord.CUS_ID
JOIN 
    SDB_SERVICE srv ON ord.SER_ID = srv.SER_ID;

-- VIEW 2
/*
Resumen de los clientes
*/
CREATE VIEW vw_customer_orders_summary AS
SELECT 
    cust.CUS_ID,
    cust.CUS_FIRST_NAME,
    cust.CUS_LAST_NAME,
    COUNT(ord.ORD_ID) AS total_orders,
    SUM(ord.ORD_TOTAL) AS total_spent
FROM 
    SDB_CUSTOMER cust
JOIN 
    SDB_ORDER ord ON cust.CUS_ID = ord.CUS_ID
GROUP BY 
    cust.CUS_ID, cust.CUS_FIRST_NAME, cust.CUS_LAST_NAME;

-- VIEW 3
/*
Información de las órdenes, cliente, producto, y detalles del pedido
*/
CREATE VIEW vw_order_details AS
SELECT 
    ord.ORD_ID,
    cust.CUS_FIRST_NAME,
    cust.CUS_LAST_NAME,
    prod.PRO_NAME,
    ord.ORD_QUANTITY,
    ord.ORD_TOTAL,
    ord.ORD_ORDER_DATE
FROM 
    SDB_ORDER ord
JOIN 
    SDB_CUSTOMER cust ON ord.CUS_ID = cust.CUS_ID
JOIN 
    SDB_PRODUCT prod ON ord.PRO_ID = prod.PRO_ID;
    
-- VIEW 4
/*
Los productos y detalles suministrados por cada proveedor
*/
CREATE VIEW vw_products_by_supplier AS
SELECT 
    sup.SUP_ID,
    sup.SUP_NAME,
    prod.PRO_ID,
    prod.PRO_NAME,
    prod.PRO_QUANTITY,
    prod.PRO_DESCRIPTION,
    prod_det.PRD_CATEGORY_NAME,
    prod_det.PRD_MINIMUM_STOCK
FROM 
    SDB_SUPPLIER sup
JOIN 
    SDB_PRODUCT prod ON sup.SUP_ID = prod.SUP_ID
JOIN 
    SDB_PRODUCT_DETAIL prod_det ON prod.PRO_ID = prod_det.PRO_ID;
    
-- VIEW 5
/*
Productos que han sido despachados, cliente y detalles de la salida
*/
CREATE VIEW vw_departures_summary AS
SELECT 
    dep.DEP_ID,
    cust.CUS_FIRST_NAME,
    cust.CUS_LAST_NAME,
    prod.PRO_NAME,
    dep.DEP_OUTDATE,
    dep.DEP_QUANTITY,
    dep.DEP_VALUE
FROM 
    SDB_DEPARTURE dep
JOIN 
    SDB_CUSTOMER cust ON dep.CUS_ID = cust.CUS_ID
JOIN 
    SDB_PRODUCT prod ON dep.PRO_ID = prod.PRO_ID;

-- VIEW 6
/*
Relación entre órdenes y facturación
*/
CREATE VIEW vw_billing_summary AS
SELECT 
    bill.BIL_ID,
    bill.BIL_SERIE,
    bill.BIL_NUMBER,
    ord.ORD_ID,
    cust.CUS_FIRST_NAME,
    cust.CUS_LAST_NAME,
    ord.ORD_TOTAL
FROM 
    SDB_BILLING bill
JOIN 
    SDB_ORDER ord ON bill.ORD_ID = ord.ORD_ID
JOIN 
    SDB_CUSTOMER cust ON ord.CUS_ID = cust.CUS_ID;

SELECT * FROM vw_customer_services;

