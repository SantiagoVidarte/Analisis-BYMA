# Análisis del Panel Líder BYMA — 2025
## Rendimiento, riesgo y correlación de las 5 acciones más negociadas de Argentina

**Autor:** Santiago Vidarte
**Fecha:** Agosto 2026

---

## Descripción

Este proyecto analiza el comportamiento de las 5 acciones del Panel Líder 
de BYMA durante 2025, respondiendo tres preguntas clave para la toma de 
decisiones de inversión:

1. ¿Qué acción tuvo el mayor rendimiento?
2. ¿Cuál presentó mayor riesgo (volatilidad)?
3. ¿Qué tan correlacionadas están entre sí? ¿Ofrecen diversificación real?

---

## Hallazgos principales

- **ALUA** registró el mayor rendimiento del panel (+11,3%) con el mejor 
  Ratio de Sharpe (0.21), indicando la mejor relación riesgo/retorno.
- **TXAR** fue el peor activo del período: rendimiento de -25,2% y Sharpe 
  de -0.48. No compensó el riesgo asumido.
- **BMA y GGAL** presentaron la mayor volatilidad (66% y 63%) y una 
  correlación de 0.94 — tener ambas equivale a duplicar la misma apuesta.
- Para una **cartera conservadora** se recomiendan ALUA e YPFD (baja 
  correlación, volatilidad menor al 55%, Sharpe positivo).
- Para una **cartera de mayor riesgo** se recomiendan ALUA y BMA (mayores 
  rendimientos del panel, correlación baja entre sí: 0.26).

---
## Visualizaciones

![Rendimiento total 2025](graficos/rendimiento.png)

![Volatilidad anualizada 2025](graficos/volatilidad.png)

![Ratio de Sharpe 2025](graficos/sharpe.png)

![Matriz de correlación 2025](graficos/correlacion.png)

## Herramientas

- Python 3.14
- pandas 3.0
- yfinance 1.5
- PostgreSQL 17
- matplotlib
- seaborn
- SQLAlchemy

---

## Dataset

- **Fuente:** Yahoo Finance vía yfinance
- **Mercado:** BYMA (Bolsas y Mercados Argentinos)
- **Período:** enero — diciembre 2025
- **Tickers:** YPFD.BA, GGAL.BA, BMA.BA, TXAR.BA, ALUA.BA
- **Frecuencia:** diaria (243 días hábiles)

---

## Estructura del repositorio