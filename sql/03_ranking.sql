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
),
stats AS (
    SELECT
        ticker,
        STDDEV(rendimiento) * SQRT(252) AS volatilidad,
        AVG(rendimiento) * 252          AS rendimiento_anualizado
    FROM largo
    WHERE rendimiento IS NOT NULL
    GROUP BY ticker
)
SELECT
    RANK() OVER (
        ORDER BY rendimiento_anualizado / NULLIF(volatilidad, 0) DESC
    ) AS posicion,
    ticker,
    ROUND(CAST(rendimiento_anualizado AS NUMERIC), 2) AS rendimiento_pct,
    ROUND(CAST(volatilidad AS NUMERIC), 2)            AS volatilidad_pct,
    ROUND(CAST(
        rendimiento_anualizado / NULLIF(volatilidad, 0) AS NUMERIC
    ), 4) AS sharpe_ratio,
    CASE
        WHEN rendimiento_anualizado / NULLIF(volatilidad, 0) > 0
        THEN 'Compensó el riesgo'
        ELSE 'No compensó el riesgo'
    END AS evaluacion
FROM stats
ORDER BY sharpe_ratio DESC;