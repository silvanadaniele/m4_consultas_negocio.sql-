/* TOTAL FACTURADO, CANTIDAD DE PEDIDOS Y TICKET PROMEDIO
CONSULTA 1*/

SELECT
  MONTH(fecha_venta) AS mes,
  SUM(cantidad*precio_unitario) AS total_facturado,
  COUNT (id_venta) AS cantidad_pedidos,
  CAST (AVG (cantidad*precio_unitario) AS DECIMAL(10,2) )  ticket_promedio

  FROM ventas
  GROUP BY MONTH (fecha_venta)
  ORDER BY mes;

  --CONSULTA 2 

  SELECT TOP 5
      id_productos,
      SUM(cantidad) unidades_vendidas,
      CAST(SUM(cantidad*precio_unitario) AS DECIMAL (12,2)) AS total_facturado

      FROM ventas
      GROUP BY id_productos
      ORDER BY total_facturado DESC;

--CONSULTA 3

 SELECT 
  id_clientes AS clientes,
  COUNT(id_venta) AS cantidad_pedidos
   FROM ventas
   GROUP BY id_clientes;

--CONSULTA 4

 WITH VentasPorProducto AS (
    SELECT
        id_productos,
        SUM(cantidad * precio_unitario) AS Total_Facturado
    FROM ventas
    GROUP BY id_productos
)

SELECT
    id_productos AS id_producto,
    CAST(Total_Facturado AS DECIMAL(12,2)) AS Total_Facturado,
    CASE
        WHEN Total_Facturado > (
            SELECT AVG(Total_Facturado)
            FROM VentasPorProducto
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS Comparacion_Promedio
FROM VentasPorProducto
ORDER BY Total_Facturado DESC;

    
--Durante marzo de 2024 se registraron 10 ventas,con una facturacion total de 6444.00 y unticket promedio de 644.40.

--El producto 1 (Laptop Pro 15) fue el que genero mayor facturacion,con 3600.00,
--representando el 55.87% del total facturado.

--Todos los clientes tuvieron la misma cantidad de pedidos