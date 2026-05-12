# AML Transaction Monitoring Dashboard

## Project Overview

This project focuses on building an Anti-Money Laundering (AML) Transaction Monitoring Dashboard using banking transaction data. The dashboard identifies suspicious financial activities, transaction anomalies, and high-risk customer behavior through data analytics and visualization techniques.

The project simulates real-world banking AML and fraud detection systems by analyzing transaction patterns, login anomalies, device usage, customer behavior, and transaction channels.

---

## Objective

The main objectives of this project are:

- Detect suspicious and potentially fraudulent transactions
- Monitor high-risk accounts and transaction patterns
- Analyze customer transaction behavior
- Build a dynamic AML risk scoring engine
- Visualize banking transaction risks using interactive dashboards

---

## Dataset Features

The dataset contains:

- Transaction details
- Account information
- Customer demographics
- Device and IP tracking
- Login attempts
- Transaction channels
- Merchant information
- Account balances

### Key Fields

| Field | Description |
|---|---|
| TransactionID | Unique transaction identifier |
| AccountID | Customer account identifier |
| TransactionAmount | Amount of transaction |
| TransactionDate | Date and time of transaction |
| TransactionType | Credit or Debit |
| Location | Transaction location |
| DeviceID | Device used for transaction |
| IP Address | IP address of user |
| Channel | ATM / Online / Branch |
| LoginAttempts | Number of login attempts |
| AccountBalance | Current account balance |

---

## Tools & Technologies Used

- Power BI
- SQL
- Python
- Pandas
- Excel
- JSON Dataset

---

## Dashboard Features

### KPI Cards
- Total Transactions
- Total Transaction Volume
- Suspicious Transactions
- High-Risk Accounts
- Large Transaction Alerts
- Failed Login Attempt Alerts
- Online Transaction Risk %
- Low Balance Risk Transactions

---

## AML Risk Indicators

The dashboard identifies suspicious activities based on:

- High transaction amounts
- Multiple login attempts
- Unusual transaction duration
- Low account balance transactions
- High-risk online transactions
- Device sharing across accounts
- Repeated IP address usage

---

## Visualizations Included

- Transaction Trend Analysis
- Suspicious Transaction Monitoring
- Geographic Risk Distribution
- Channel-wise Fraud Analysis
- Occupation Risk Segmentation
- Login Attempt Heatmaps
- Device & IP Risk Tracking
- High-Risk Transaction Tables

---

## Risk Scoring Engine

A custom AML risk scoring model was implemented using transaction behavior patterns.

### Sample Risk Conditions

| Condition | Risk Score |
|---|---|
| Transaction Amount > 1000 | +40 |
| Login Attempts > 3 | +30 |
| Online Channel | +10 |
| Low Account Balance | +30 |
| Short Transaction Duration | +20 |

### Risk Categories

| Score | Category |
|---|---|
| 0–30 | Low Risk |
| 31–60 | Medium Risk |
| 61–100 | High Risk |

---

## Business Insights

- Online transactions showed higher suspicious activity frequency.
- Accounts with multiple login attempts demonstrated elevated fraud risk.
- Several high-value debit transactions were associated with low account balances.
- Certain locations displayed higher concentrations of risky transactions.
- Shared device and IP usage indicated possible account linkage or mule activity.

---

## Project Structure

```text
AML-Transaction-Monitoring/
│
├── data/
│   ├── raw/
│   ├── cleaned/
│
├── dashboard/
│   ├── screenshots/
│   ├── aml_dashboard.pbix
│
├── notebooks/
│   ├── data_cleaning.ipynb
│   ├── exploratory_analysis.ipynb
│
├── sql/
│   ├── aml_queries.sql
│
├── reports/
│   ├── project_report.pdf
│
├── README.md
