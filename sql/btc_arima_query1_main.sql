-- ARIMA+ model 

-- 1. Готуємо таблицю для моделі
CREATE OR REPLACE TABLE `btc-forecast-475211.btc_data.btc_daily_clean` AS
SELECT
  DATE(snapped_at) AS record_date,   -- перетворюємо TIMESTAMP на DATE
  price AS price_usd,
  market_cap AS market_capitalization,
  total_volume AS total_volume_usd,
  circulating_supply AS circulating_supply_btc
FROM `btc-forecast-475211.btc_data.btc_daily`
WHERE price IS NOT NULL
ORDER BY record_date
;


-- 2. Створюємо МОДЕЛЬ ARIMA+
CREATE OR REPLACE MODEL `btc-forecast-475211.btc_data.btc_arima`
OPTIONS(
  model_type = 'ARIMA_PLUS',
  time_series_timestamp_col = 'record_date',
  time_series_data_col = 'price_usd'
) AS
SELECT record_date, price_usd
FROM `btc-forecast-475211.btc_data.btc_daily_clean`
;

-- 3. Робимо прогноз на 30 днів
SELECT
  forecast_timestamp AS forecast_date,
  forecast_value AS predicted_price,
  prediction_interval_lower_bound AS lower_bound,
  prediction_interval_upper_bound AS upper_bound
FROM ML.FORECAST(
  MODEL `btc-forecast-475211.btc_data.btc_arima`,
  STRUCT(30 AS horizon, 0.9 AS confidence_level)
);

-- 3.1. Перевірка якості моделі
SELECT *
FROM ML.EVALUATE(MODEL `btc-forecast-475211.btc_data.btc_arima`);


-- 4. Робимо табл для LOOKER
-- Об'єднуємо історичні дані (actual) та прогноз (forecast)

CREATE OR REPLACE TABLE `btc-forecast-475211.btc_data.btc_actual_vs_forecast` AS
-- Реальні дані
SELECT
  record_date AS date,
  price_usd AS actual_price,
  NULL AS predicted_price,
  market_capitalization,
  total_volume_usd,
  circulating_supply_btc,
  'Actual' AS data_type
FROM `btc-forecast-475211.btc_data.btc_daily_clean`
UNION ALL
-- Прогнозовані дані
SELECT
  DATE(forecast_timestamp) AS date,
  NULL AS actual_price,
  forecast_value AS predicted_price,
  NULL AS market_capitalization,   -- капіталізацію можна теж спрогнозувати пізніше
  NULL AS total_volume_usd,
  NULL AS circulating_supply_btc,
  'Forecast' AS data_type
FROM ML.FORECAST(
  MODEL `btc-forecast-475211.btc_data.btc_arima`,
  STRUCT(30 AS horizon, 0.9 AS confidence_level)
)
ORDER BY date
;

-- 4.1. Таблиця останньої прогнозної та фактичної ціни для Лукеру / та їх різниця

CREATE OR REPLACE TABLE `btc-forecast-475211.btc_data.btc_forecast_for_looker` AS

WITH 
-- Остання фактична ціна
last_actual AS (
  SELECT 
    date AS last_actual_date,
    actual_price AS last_actual_price
  FROM `btc-forecast-475211.btc_data.btc_actual_vs_forecast`
  WHERE data_type = 'Actual'
  ORDER BY date DESC
  LIMIT 1
),
-- Остання прогнозна ціна
last_forecast AS (
  SELECT 
    date AS last_forecast_date,
    predicted_price AS last_predicted_price
  FROM `btc-forecast-475211.btc_data.btc_actual_vs_forecast`
  WHERE data_type = 'Forecast'
  ORDER BY date DESC
  LIMIT 1
)
-- Об’єднуємо обидва результати + рахуємо дельту
SELECT
  a.last_actual_date, 
  a.last_actual_price, 
  f.last_forecast_date, 
  f.last_predicted_price, 
  -- абсолютна різниця ($)
  ROUND(f.last_predicted_price - a.last_actual_price, 2) AS price_diff_usd, 
  -- відносна різниця (%)
  ROUND(((f.last_predicted_price - a.last_actual_price) / a.last_actual_price) , 4) AS price_diff_pct
FROM last_actual a
CROSS JOIN last_forecast f;

