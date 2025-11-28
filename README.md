# 📦 Ecommerce SQL Analysis Project
*A complete end-to-end SQL project analyzing ecommerce sales, customer behavior, and product performance.*

---

## 📌 Project Overview

This project focuses on analyzing a real-world–style ecommerce dataset containing **10,000+ transactions** from 2018–2019.  
The objective is to clean raw data, build a structured database, and perform analytical SQL queries to derive insights that help business decision-making.

This project demonstrates:

- Data cleaning  
- Database creation  
- Star-schema style modeling  
- Exploratory SQL analysis  
- Customer & product insights  
- Revenue analytics  
- Business recommendation building  

---


---

## 🧹 1. Data Cleaning & Preparation

### Steps performed:

- Removed incomplete rows  
- Fixed inconsistent date formats (DD/MM/YYYY vs MM/DD/YYYY)  
- Converted:
  - Price → DECIMAL  
  - Quantity → INT  
- Handled negative quantities (returns / cancellations)  
- Standardized product names  
- Split dataset into:
  - **Transactions**  
  - **Products**  
  - **TransactionDetails** (fact table)

This ensures data is clean, reliable, and optimized for analysis.

---

## 🗄️ 2. Database Schema

### Tables Created:

- **staging_raw** → Raw data loading  
- **clean_transactions** → Cleaned dataset  
- **Transactions** → Invoice-level table  
- **Products** → Product master  
- **TransactionDetails** → Line-item fact table  

### Schema Highlights:

- Primary & foreign keys added  
- Normalized design to avoid redundancy  
- Structured for analytical queries  

---

## 📊 3. SQL Analysis Performed

### 🔹 Revenue Analysis
- Total Revenue  
- Revenue by country  
- Monthly sales trends  
- Revenue by product  

### 🔹 Customer Insights
- Top customers by revenue  
- Repeat customer rate  
- Order frequency  

### 🔹 Product Performance
- Best-selling products  
- Units sold & revenue  
- Items with high returns  

### 🔹 Operational Metrics
- Average Order Value (AOV)  
- Return volume & value lost  
- Peak sales day of the week  

---

## 📈 4. Key Findings (Insights)

### 💰 **Total Revenue: 40,062,749.97**

### 🌍 **Top Revenue-Generating Countries**
- **United Kingdom** — 33.4M  
- **Netherlands** — 1.41M  
- **Ireland (EIRE)** — 1.07M  

UK dominates sales, indicating a highly localized customer base.

---

### 📦 **Top Product Performers**

| Product Name | Units Sold | Revenue |
|--------------|------------|----------|
| World War 2 Gliders | 53,847 | 568,085.85 |
| Popcorn Holder | 56,450 | 620,385.50 |
| Jumbo Bag Red Retrospot | 47,363 | 293,176.97 |
| Assorted Colour Bird Ornament | 36,445 | 263,861.80 |

Products are low-cost but high-volume — ideal for bulk sales.

---

### 🔁 **Repeat Customer Rate: 70%**

This indicates strong loyalty and frequent repurchase behavior.

---

### 📉 **Returns / Canceled Orders**

- **8,585 returned transactions**
- **Revenue lost: –2,793,854.06**

High return rate signals issues in product quality, shipping, or mismatch in expectations.

---

### 📅 **Monthly Trends**

- Sales peak from **September → November**
- December drops due to end-of-year stock depletion  
- Seasonal behavior—holiday-driven spikes

---

### 🗓 Peak Sales Day of the Week

- **Sunday** → highest revenue  
- Weekend shopping trend is strong  

---

## 🚀 5. Business Recommendations

### 🛒 **1. Expand UK and EU Market Strategy**
Since the UK provides 80%+ revenue, business should:
- Increase warehouse capacity in UK  
- Run UK-targeted promotions  
- Reduce shipping delays & boost customer satisfaction  

---

### ✔️ **2. Reduce Return Rates**
High returns → major revenue leakage  
Fix by:
- Improving product descriptions  
- Adding real images  
- Strengthening quality checks  
- Offering size / dimension guides  

---

### 📦 **3. Inventory Optimization**
Peak months (Sep–Nov) show high demand.  
Business should:
- Increase stock before Q4  
- Use forecasting models for demand  
- Track historical sales to avoid stock-outs  

---

### 💳 **4. Promote Best-Selling Products**
Top products generate **large sales volume**.  
Business can:
- Bundle popular items  
- Offer discounts to increase cart size  
- Feature them on homepage/ads  

---

### 💡 **5. Loyalty Program for Repeat Customers**
Given 70% repeat rate:
- Launch reward systems  
- Offer points for every purchase  
- Increase customer lifetime value (CLV)

---

### 🧭 6. Future Enhancements

This project can be extended by adding:

- Power BI dashboard  
- Customer segmentation (RFM Analysis)  
- Forecasting revenue (time series)  
- Cohort retention analysis  
- Product clustering  

---

## 🛠️ Technologies Used

- **MySQL**
- **Excel**
- **Power BI (optional visualization)**
- **GitHub**
- **SQL Workbench / SSMS**

---

## 🤝 Contributions

This project is part of my data analytics learning journey.  
Feel free to fork, star ⭐, or suggest improvements!

---





