# AI & Workforce Impact Analysis

## 📌 Project Overview

This project analyzes the impact of Artificial Intelligence (AI) adoption on the workforce across different countries, regions, and industry sectors.

The project investigates the relationship between AI adoption and workforce displacement, job creation, net workforce change, AI-related layoffs, reskilling programs, and AI policy strength.

The main goal is to transform raw workforce data into meaningful insights that can help understand how AI is changing employment and which industries may be more affected.

---

## 🎯 Project Objectives

The main objectives of this project are:

- Analyze AI adoption across different industries and countries.
- Identify industries with the highest workforce displacement.
- Analyze the relationship between AI adoption and workforce displacement.
- Measure the impact of AI on job creation.
- Analyze net workforce changes.
- Investigate AI-related layoff announcements.
- Examine the role of reskilling programs.
- Explore the relationship between AI policy strength and workforce outcomes.
- Build interactive dashboards to communicate the findings.

---

## 📊 Dataset

The dataset contains information about AI adoption and workforce impact across different:

- Countries
- Regions
- Income groups
- Industry sectors
- Years
- Quarters

### Main Variables

| Column | Description |
|---|---|
| `record_id` | Unique identifier for each record |
| `country` | Country associated with the observation |
| `country_code` | Standard country code |
| `region` | Geographic region |
| `income_group` | Economic/income classification |
| `year` | Year of observation |
| `quarter_num` | Quarter number |
| `quarter_label` | Readable quarter label |
| `industry_sector` | Industry sector |
| `ai_adoption_index` | Overall AI adoption level |
| `ai_tool_adoption_pct` | AI tool adoption percentage |
| `pct_sector_workforce_displaced` | Percentage of workforce displaced/affected |
| `pct_new_roles_created` | Percentage of new roles created |
| `net_workforce_change_pct` | Overall net workforce change |
| `ai_cited_layoff_announcements` | Layoff announcements citing AI |
| `reskilling_programs_count` | Number of reskilling programs |
| `ai_policy_strength_score` | AI policy strength score |

---

## 🛠️ Technologies & Tools

The project uses:

- **Python** – Data Cleaning & Preprocessing
- **Pandas** – Data Manipulation
- **NumPy** – Numerical Operations
- **SQL** – Data Analysis & Aggregation
- **Excel / Power Query** – Data Preparation & Exploration
- **Power BI** – Interactive Dashboards & Visualization
- **GitHub** – Version Control & Project Documentation

---

## 🔄 Project Workflow

The project follows a complete data analysis workflow:

### 1. Data Collection
Obtained the dataset containing AI adoption and workforce-related indicators.

### 2. Data Cleaning & Preprocessing
Performed using Python.

Main steps included:

- Handling missing values
- Checking duplicates
- Converting data types
- Validating numerical values
- Standardizing categorical values
- Checking inconsistent or suspicious records

### 3. Exploratory Data Analysis

Explored:

- AI adoption by industry
- Workforce displacement
- Job creation
- Net workforce change
- AI-related layoffs
- Reskilling programs
- AI policy strength

### 4. SQL Analysis

SQL was used to answer analytical questions through:

- `GROUP BY`
- `AVG`
- `SUM`
- `COUNT`
- `ORDER BY`
- Filtering
- Conditional logic

### 5. Dashboard Development

Power BI was used to create interactive dashboards showing the main KPIs, comparisons, and relationships between AI adoption and workforce outcomes.

---

## 📈 Key Performance Indicators (KPIs)

The main KPIs include:

- **Average AI Adoption Index**
- **Average Workforce Displacement**
- **Average Net Workforce Change**
- **Average AI Tool Adoption**
- **Average New Roles Created**
- **AI-Cited Layoff Announcements**
- **Reskilling Programs**

---

## 📊 Dashboard

The dashboard focuses on three main areas:

### 1. Workforce Impact Overview

Shows:

- AI Adoption
- Workforce Displacement
- New Roles Created
- Net Workforce Change
- AI-related Layoffs

### 2. AI Adoption & Workforce Relationship

Analyzes relationships such as:

**AI Adoption → Workforce Displacement**

and

**AI Tool Adoption → Net Workforce Change**

Scatter plots are used to identify patterns and relationships between numerical variables.

### 3. Workforce Response & Policy

Analyzes:

- Reskilling Programs
- New Roles
- AI Policy Strength
- Workforce Outcomes

---

## 🔎 Key Questions

The project aims to answer questions such as:

1. Which industries have the highest workforce displacement?
2. Which industries have the highest AI adoption?
3. Does higher AI adoption correspond to higher workforce displacement?
4. Which industries create the most new roles?
5. What is the overall net workforce change?
6. Which industries have the highest AI-related layoffs?
7. Are reskilling programs associated with better workforce outcomes?
8. Does stronger AI policy correspond to lower workforce displacement?
9. How does AI's impact on employment vary across countries and regions?

---

## 💡 Key Insights

Some of the main observations from the analysis include:

- AI adoption varies across industries.
- High AI adoption does not necessarily mean the highest workforce displacement.
- AI can simultaneously contribute to workforce displacement and creation of new roles.
- Reskilling is an important factor in helping workers adapt to AI-driven changes.
- Workforce impact differs across industries and geographic regions.

> Note: Relationships observed in the data represent associations and should not automatically be interpreted as causal relationships.

---

## 📁 Project Structure

```text
AI-Workforce-Impact/
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── python/
│   ├── data_cleaning.ipynb
│   └── analysis.ipynb
│
├── sql/
│   └── analysis_queries.sql
│
├── powerbi/
│   └── AI_Workforce_Dashboard.pbix
│
├── excel/
│   └── cleaned_data.xlsx
│
├── screenshots/
│   └── dashboard.png
│
└── README.md
