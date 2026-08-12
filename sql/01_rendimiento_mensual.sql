WITH largo AS (
    SELECT "Date", ticker, precio 
    FROM precios_cierre
    CROSS JOIN LATERAL (VALUES
        ('ALUA.BA', "ALUA.BA"),
        ('BMA.BA',  "BMA.BA"),
        ('GGAL.BA', "GGAL.BA"),
        ('TXAR.BA', "TXAR.BA"),
        ('YPFD.BA', "YPFD.BA")
    ) AS t(ticker, precio)
),
mensual AS (
    SELECT
        DATE_TRUNC('month', "Date") AS mes,
        ticker,
        LAST_VALUE(precio) OVER (
            PARTITION BY DATE_TRUNC('month', "Date"), ticker
            ORDER BY "Date"
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS precio_cierre_mes
    FROM largo
),
distinct_mensual AS (
    SELECT DISTINCT mes, ticker, precio_cierre_mes
    FROM mensual
),
con_anterior AS (
    SELECT
        mes, ticker, precio_cierre_mes,
        LAG(precio_cierre_mes) OVER (
            PARTITION BY ticker ORDER BY mes
        ) AS precio_mes_anterior
    FROM distinct_mensual
)
SELECT
    mes,
    ticker,
    ROUND(CAST(precio_cierre_mes AS NUMERIC), 2) AS precio_cierre,
    ROUND(
        CAST((precio_cierre_mes / NULLIF(precio_mes_anterior, 0) - 1) * 100 AS NUMERIC)
    , 2) AS rendimiento_mensual_pct
FROM con_anterior
WHERE precio_mes_anterior IS NOT NULL
ORDER BY ticker, mes;