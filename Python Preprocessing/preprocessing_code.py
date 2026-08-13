import pandas as pd  #for data manipulation and analysis.
import numpy as np  #for numerical operations
from sklearn.preprocessing import StandardScaler #standardize numerical features.

df = pd.read_csv("D:/downloads/ai_workforce_displacement_dirty - ai_workforce_displacement_dirty.csv.csv")
df.head()  #Display the first 5 rows
print("Dataset Shape:", df.shape)  #number of rows and columns
print("\nColumn Names:")
print(df.columns.tolist())   # Display column names
print("\nData Types:")
print(df.dtypes)         # Display data types of all columns
print("\nDataset Information:")
df.info()   # Get general information about the dataset


# Fixing missing values and duplicates
missing_values = df.isnull().sum()
print("Missing Values:")
print(missing_values)   # Check the number of missing values in each column

duplicate_rows = df.duplicated().sum() # Check for completely duplicated rows
print("Number of duplicated rows:", duplicate_rows)
df = df.drop_duplicates() #remove dup rows
print("Shape after removing duplicate rows:", df.shape)


# Check whether record_id contains duplicated values
duplicate_ids = df["record_id"].duplicated().sum()
print("Duplicated Record IDs:", duplicate_ids)
# Check the number of unique record IDs
print("Unique Record IDs:", df["record_id"].nunique())
df = df.drop_duplicates(subset="record_id", keep="first")  # Keep only the first occurrence of each Record ID


# Remove leading and trailing spaces from categorical columns
categorical_columns = df.select_dtypes(include="object").columns
print("Categorical Columns:")
print(categorical_columns)
for col in categorical_columns:
    df[col] = df[col].astype(str).str.strip()  # Remove leading and trailing spaces from categorical columns
for col in categorical_columns:
    has_spaces = df[col].astype(str).str.match(r'^\s|\s$').sum()
    print(f"{col}: {has_spaces} values with extra spaces")   # Validate that no extra leading or trailing spaces remain


#Fixing typos and standardizing country names
typo_fix = {    #counry name cleanup
    "Untied States": "United States",
    "Chna": "China",
    "Gemany": "Germany",
    "Brasil": "Brazil",
}
df["country"] = df["country"].replace(typo_fix)
df["country"] = df["country"].str.title()  #capitalize the first letter of each word in the country names
title_fix = {"United States Of America": "United States"}  # example guard, extend as needed
df["country"] = df["country"].replace(title_fix)


# Normalizing the quarter and quarter_label columns
print(df["quarter"].unique())
print(df["quarter"].dtype)
print(df["quarter_label"].unique())
df["quarter"] = (
    df["quarter"]
    .astype(str)
    .str.upper()
    .str.replace("Q", "", regex=False)   #Drop the Q and keep the number only
    .astype(int)
)
df["quarter_label"] = (
    df["year"].astype(int).astype(str) + "-Q" + df["quarter"].astype(str)
)  #I standardized the quarter_label format to YYYY-QN using the year and quarter columns
print(df["quarter"].unique())
print(df["quarter"].dtype)
print(df["quarter_label"].unique())


#Normalizing the region_map column
region_map = {
    "N. America": "North America",
    "n. america": "North America",
    "north america": "North America",
    "North America ": "North America",
    "EU": "Europe",
    "europe": "Europe",
}
df["region"] = df["region"].replace(region_map).str.strip()


# Normalising Values in the gdp and pct columns
# for the gdp_per_capita_usd column some values begin with "$" and some not. normalize by removing "$" and converting to float
df["gdp_per_capita_usd"] = (
    df["gdp_per_capita_usd"]
    .astype(str)
    .str.replace("$", "", regex=False)
    .str.replace(",", "", regex=False)
    .astype(float)
)

#for the pct_sector_workforce_displaced column some values are in percentage format while others are in decimal format. Normalize by converting all values to decimal format.
df["pct_sector_workforce_displaced"] = (
    df["pct_sector_workforce_displaced"]
    .astype(str)
    .str.replace("%", "", regex=False)
    .astype(float) / 100
)


# Check for invalid values outside the allowed range [0, 1]
bad_risk = ~df["sector_automation_risk_score"].between(0, 1)
print("Invalid values found:", bad_risk.sum())

# Replace invalid values with NaN
df.loc[bad_risk, "sector_automation_risk_score"] = np.nan
print(df["sector_automation_risk_score"].describe())
print("Missing values:", df["sector_automation_risk_score"].isna().sum())

# Checking if there's any negative value for the layoff announcments
bad_layoffs = df["ai_cited_layoff_announcements"] < 0
print(f"Invalid negative ai_cited_layoff_announcements found: {bad_layoffs.sum()}")
df.loc[bad_layoffs, "ai_cited_layoff_announcements"] = np.nan   #I identified negative layoff announcement counts as invalid and replaced them with NaN
missing = df.isna().sum()


# data_source_notes column is a repeated string but some values are missing, so fill them up
# fill Nan with "Research-calibrated synthetic data. Grounded in: WEF Future of Jobs 2025;
#  Goldman Sachs GenAI Labour Report 2025; McKinsey State of AI 2025; OECD Employment Outlook 2025;
#  BLS O*NET Automation Scores; Layoffs.fyi 2025; 
# PwC AI Jobs Barometer 2025; IMF WEO 2025."
if missing["data_source_notes"] > 0:
    canonical_note = (
        "Research-calibrated synthetic data. Grounded in: WEF Future of Jobs 2025; "
        "Goldman Sachs GenAI Labour Report 2025; McKinsey State of AI 2025; "
        "OECD Employment Outlook 2025; BLS O*NET Automation Scores; Layoffs.fyi 2025; "
        "PwC AI Jobs Barometer 2025; IMF WEO 2025."
    )
    df["data_source_notes"].fillna(canonical_note, inplace=True)


#Check for remaining missing values and handling them
#Handling missing counts using the general median will cause the data to be skewed when ranked by country, industry and year.
#The most optimal solution is to use the median or mean of the parameter that affects the numbers the most.
df = df.sort_values(['country', 'year', 'quarter']).reset_index(drop=True)
# --- Group 1: slow-moving, time-based columns -> interpolate within each country ---
time_based_cols = ['gdp_per_capita_usd', 'ai_adoption_index', 'reskilling_programs_count']
for col in time_based_cols:
    df[col] = df.groupby('country')[col].transform(
        lambda s: s.interpolate(method='linear', limit_direction='both')
    )
    # Fallback: if a country had NO data at all for a column, interpolation
    # can't help — fall back to that column's global median so nothing is left NaN
    if df[col].isna().any():
        df[col] = df[col].fillna(df[col].median())
# --- Group 2: sector-driven traits -> fill with the sector's median ---
sector_based_cols = ['sector_automation_risk_score', 'pct_workforce_female']
for col in sector_based_cols:
    df[col] = df[col].fillna(df.groupby('industry_sector')[col].transform('median'))
    if df[col].isna().any():
        df[col] = df[col].fillna(df[col].median())
# --- Group 3: sparse counts -> median within sector + year ---
df['ai_cited_layoff_announcements'] = df['ai_cited_layoff_announcements'].fillna(
    df.groupby(['industry_sector', 'year'])['ai_cited_layoff_announcements'].transform('median')
)
if df['ai_cited_layoff_announcements'].isna().any():
    df['ai_cited_layoff_announcements'] = df['ai_cited_layoff_announcements'].fillna(
        df['ai_cited_layoff_announcements'].median())
missing = df.isna().sum()
print("\nRemaining missing values by column:")
print(missing[missing > 0])  


#Save clean dataset
df.to_csv("D:/downloads/ai_workforce_displacement_clean.csv", index=False)
print("\nCleaned data shape:", df.shape)

