# 🧠 Bitcoin Price Forecast – BigQuery ML + Looker Studio  

## The forecast suggests a **potential 9.3% price increase over the next 30 days (Oct 18–Nov 16, 2025)**, reflecting Bitcoin’s short-term recovery momentum and typical market volatility.


## 📊 Overview
This project demonstrates a **time series forecasting pipeline** built entirely within **BigQuery ML** using the **ARIMA⁺ model**.  
It predicts **Bitcoin (BTC/USD)** prices for the next 30 days and visualizes the results in **Looker Studio**.

---

## ⚙️ Model Details
| Parameter | Value | Description |
|------------|--------|-------------|
| **Model type** | `ARIMA(1, 2, 1)` | Considers one previous price lag (p=1), applies second-order differencing (d=2), and includes one moving average term (q=1). |
| **Drift** | `false` | The model does not assume a fixed growth or decline trend — suitable for volatile assets like BTC. |
| **Seasonality** | `WEEKLY + YEARLY` | Captures both short-term (weekly) and long-term (annual) trading patterns. |
| **AIC** | ≈ 69,568 | Slightly higher than the previous version, reflecting minor market volatility. |
| **Log Likelihood** | ≈ –34,781 | Indicates stable model fitting with sensitivity to new data points. |
| **Variance** | ≈ 2.52 × 10⁵ | Reflects a wider confidence interval due to increased short-term fluctuations. |

---

## 🔍 Model Interpretation
The **ARIMA(1,2,1)** model dynamically adapts to new daily BTC/USD data, capturing both short-term volatility and long-term seasonal patterns.  
With two levels of differencing (d=2), it stabilizes the series during trend shifts, while the moving-average term (q=1) helps correct short-term noise.  
The absence of drift ensures neutrality, preventing bias toward constant growth or decline.  
The forecast suggests a **potential 9.3% price increase over the next 30 days (Oct 18–Nov 16, 2025)**, reflecting Bitcoin’s short-term recovery momentum and typical market volatility.  

---

## 🧩 Pipeline Structure
1. **Data Source:** CoinGecko (daily BTC/USD prices).  
2. **Data Preparation:** Cleaned and uploaded to BigQuery.  
3. **Model Training:** `CREATE MODEL` with `ARIMA_PLUS`.  
4. **Evaluation:** Compared 12 ARIMA configurations by AIC and log likelihood.  
5. **Forecast:** Generated 30-day horizon with 90% confidence interval.  
6. **Visualization:** Built interactive Looker Studio dashboard (Actual vs Forecast, Market Cap, and KPI cards).  

---

## 📈 Results Preview
![Looker Studio Dashboard Screenshot](btc_dashboard_preview.png)

> The dashboard presents actual vs forecast prices, market capitalization trends, and key model metrics.

---

## 🗂️ Repository Structure
- **data/** → input datasets (CoinGecko, CSV)
- **sql/** → BigQuery SQL scripts for data preparation, ARIMA⁺ model training, forecasting, evaluation, and summary table creation
- **looker/** → Looker Studio dashboard assets: preview screenshots, public dashboard link
- **README.md** → main project documentation
  
---

## 🔗 Dashboard Access
📊 [View Looker Studio Dashboard](https://lookerstudio.google.com/reporting/9e5eed5c-a61e-49cc-979c-28a1769d744a)

---

## 👩‍💻 Author
**Julia Pohrebitska**  
Data Analyst | Machine Learning in BigQuery | Python | Tableau  
📧 Contact: [LinkedIn](https://linkedin.com/in/jpohrebitska)
