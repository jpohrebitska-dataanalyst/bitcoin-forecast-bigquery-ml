# 🧠 Bitcoin Price Forecast – Automated BigQuery ML Pipeline + Looker Studio  

## 🚀 Overview  
This project demonstrates a **fully automated time series forecasting pipeline** for **Bitcoin (BTC/USD)** using **BigQuery ML, Yahoo Finance API, and Looker Studio**.  
The pipeline automatically extracts, transforms, models, and visualizes BTC/USD data — delivering a live 30-day forecast that updates **daily at 10:00 AM**.

---

## ⚙️ Project Stages  

| Stage | Tool | Description |
|--------|------|-------------|
| **1. Data Extraction** | 🐍 **Python (Yahoo Finance API)** | Daily BTC/USD prices are fetched and saved to BQ table. |
| **2. Data Transformation** | 🧠 **BigQuery SQL** | SQL scripts clean, aggregate, and prepare the dataset (handling missing values, duplicates, outliers). |
| **3. Modeling & Forecasting** | 📈 **BigQuery ML (ARIMA⁺)** | Automatic ARIMA⁺ model selection with seasonality detection and 30-day forecasting. |
| **4. Automation** | 🔄 **BigQuery Pipelines** | End-to-end workflow runs daily at **10:00 AM** (retraining + forecast + output tables). |
| **5. Visualization** | 🎨 **Looker Studio** | Interactive dashboard showing Actual vs Forecast, KPIs, and Market Cap — fully auto-refreshed. |

---

## 📊 Model Details
| Parameter | Value | Description |
|------------|--------|-------------|
| **Model type** | `ARIMA(1, 2, 1)` | One previous lag (p=1), second-order differencing (d=2), and one moving average term (q=1). |
| **Drift** | `false` | Keeps the model unbiased — no built-in trend. |
| **Seasonality** | `WEEKLY + YEARLY` | Captures weekly and annual BTC trading cycles. |
| **AIC** | ≈ 69,568 | Slightly higher due to increased volatility on Oct 17. |
| **Log Likelihood** | ≈ –34,781 | Indicates stable model fit. |
| **Variance** | ≈ 2.52 × 10⁵ | Wider confidence interval caused by short-term fluctuations. |

---

## 🔍 Model Interpretation  
The **ARIMA(1,2,1)** model adapts dynamically to daily BTC/USD updates.  
Two levels of differencing stabilize the series during sudden trend changes, while the moving-average term smooths out noise.  
No drift preserves neutrality, making the model reliable for volatile assets.  

---

## 🧩 Pipeline Architecture  

1. **Yahoo Finance API extraction**  
   - BTC/USD dataset collected daily  
   - Saved to BQ table 

2. **BigQuery SQL transformation**  
   - Cleaning and preparing data  
   - Creating ARIMA⁺ model with `CREATE MODEL`  
   - Forecasting via `ML.FORECAST`  
   - Evaluation with `ML.EVALUATE`  

3. **BigQuery Pipeline (DAG)**  
   - Chain: extraction → transformation → modeling → forecasting  
   - Auto-run daily at 10:00 AM  

4. **Looker Studio Dashboard**  
   - Shows prices (actual vs forecast), Trade Volumes  
   - Updated automatically from BigQuery tables  

---

## 📈 Results Preview  
![Looker Studio Dashboard PDF](/looker/btc_dashboard_preview.pdf)

> The dashboard presents actual vs forecast prices, market capitalization trends, and model metrics — fully automated.

---

## 🗂️ Repository Structure

- **data/** → BTC/USD input datasets (from Yahoo Finance)  
- **notebooks/** → Python notebooks for extraction, testing, and ad-hoc analysis  
- **sql/** → BigQuery SQL scripts (cleaning, modeling, forecasting, evaluation)  
- **pipeline/** → BigQuery Pipeline configuration (JSON / workflow steps)  
- **looker/** → Looker dashboard PDF preview + public link  
- **README.md** → main project documentation

---

## 🛠 Tech Stack

**Languages & Tools:**  
- Python (Yahoo Finance API, data extraction)  
- SQL (BigQuery Standard SQL)  
- BigQuery ML (ARIMA⁺ model, ML.FORECAST, ML.EVALUATE)  
- BigQuery Pipelines (workflow automation)  
- Google Cloud Storage (data staging)  
- Looker Studio (visualization)

**Key ML Features:**  
- Automatic hyperparameter tuning (12 ARIMA configurations tested)  
- Seasonality detection (weekly & yearly)  
- Anomaly detection (spikes & dips, step changes)  
- Rolling 30-day forecasting window  

---

## 🚀 Future Improvements

- Introduce **Prophet** or **XGBoost** model for ensemble forecasting  
- Store historical model performance for **MLOps-style monitoring**  
- Add alerting (email) when forecast deviates significantly  

---

## 🔗 Dashboard Access  
📊 [Open Interactive Looker Studio Dashboard](https://lookerstudio.google.com/reporting/9e5eed5c-a61e-49cc-979c-28a1769d744a)  
*(Auto-updated daily at 10:00 AM)*  

---

## 👩‍💻 Author  
**Julia Pohrebitska**  
Data Analyst • BigQuery ML • Automation • Looker Studio  
📧 [LinkedIn](https://linkedin.com/in/jpohrebitska)
