WITH largo AS (
    SELECT "Date", ticker, rendimiento
    FROM rendimientos_diarios
    CROSS JOIN LATERAL (VALUES
        ('ALUA.BA', "ALUA.BA"),
        ('BMA.BA',  "BMA.BA"),
        ('GGAL.BA', "GGAL.BA"),
        ('TXAR.BA', "TXAR.BA"),
        ('YPFD.BA', "YPFD.BA")
    ) AS t(ticker, rendimiento)
)
SELECT
    ticker,
    ROUND(CAST(STDDEV(rendimiento) * SQRT(252) AS NUMERIC), 2) AS volatilidad_anualizada_pct,
    ROUND(CAST(AVG(rendimiento) * 252 AS NUMERIC), 2)          AS rendimiento_anualizado_pct,
    COUNT(*) AS dias
FROM largo
WHERE rendimiento IS NOT NULL
GROUP BY ticker
ORDER BY volatilidad_anualizada_pct DESC;