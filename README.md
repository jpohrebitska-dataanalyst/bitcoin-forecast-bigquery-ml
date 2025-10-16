# 🧠 Bitcoin Price Forecast – BigQuery ML + Looker Studio  

## 📊 Overview
This project demonstrates a **time series forecasting pipeline** built entirely within **BigQuery ML** using the **ARIMA⁺ model**.  
It predicts **Bitcoin (BTC/USD)** prices for the next 30 days and visualizes the results in **Looker Studio**.

---

## ⚙️ Model Details
| Parameter | Value | Description |
|------------|--------|-------------|
| **Model type** | `ARIMA(2, 1, 0)` | Uses the previous 2 price lags (p=2), first-order differencing (d=1), and no moving average term (q=0). |
| **Drift** | `false` | The model does not assume a constant upward/downward trend — ideal for volatile assets like BTC. |
| **Seasonality** | `WEEKLY + YEARLY` | Captures short-term trading cycles and long-term market behavior. |
| **AIC** | ≈ 69,410 | Lowest among 12 tested configurations (best model fit). |
| **Log Likelihood** | ≈ –34,702 | Indicates strong alignment with historical data. |
| **Variance** | ≈ 2.43 × 10⁵ | Stable forecast variance across time. |

---

## 🔍 Model Interpretation
The **ARIMA(2,1,0)** model identifies short-term autocorrelation and captures both weekly and yearly seasonality in Bitcoin’s behavior.  
By removing drift, the model avoids introducing a constant growth trend, making it robust for high-volatility assets.  
The forecast suggests a **potential 6–7% price increase over the next 30 days (Oct 17–Nov 15, 2025)**.  

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
![Looker Studio Dashboard Screenshot](dashboard_preview.png)

> The dashboard presents actual vs forecast prices, market capitalization trends, and key model metrics.

---

## 🗂️ Repository Structure
- **data/** → input datasets (CoinGecko, CSV)
- **sql/** → BigQuery SQL scripts for data preparation, ARIMA⁺ model training, forecasting, evaluation, and summary table creation
- **looker/** → Looker Studio dashboard assets: preview screenshots, public dashboard link
- **CONCLUSIONS.md** → key analytical insights
- **README.md** → main project documentation
  
---

## 🔗 Dashboard Access
📊 [View Looker Studio Dashboard](https://lookerstudio.google.com/reporting/f8b6c728-c363-4f2e-9b8a-6b44f72e5eca)

---

## 👩‍💻 Author
**Julia Pohrebitska**  
Data Analyst | Machine Learning in BigQuery | Python | Tableau  
📧 Contact: [LinkedIn](https://linkedin.com/in/jpohrebitska)
