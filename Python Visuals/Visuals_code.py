import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px

# 1. LOAD DATA
df = pd.read_csv("D:/downloads/ai_workforce_displacement_clean.csv")

# 2. COLOR PALETTE 
NAVY = "#264653"
TEAL = "#2A9D8F"
GOLD = "#E9C46A"

# Set Seaborn theme
sns.set_theme(
    style="white", #background
    context="notebook"
)

# Global Matplotlib settings
plt.rcParams.update({
    "figure.figsize": (11, 7),   #chart size
    "axes.titlesize": 17,          
    "axes.titleweight": "bold",
    "axes.labelsize": 12,
    "axes.spines.top": False,
    "axes.spines.right": False,
    "axes.facecolor": "white",  #background
    "figure.facecolor": "white"     #background around the figure
})

# 3. CREATE OUTPUT FOLDER
import os
OUTPUT_DIR = "D:/downloads/visuals"
os.makedirs(OUTPUT_DIR, exist_ok=True)

# CHART 1 scatter plot
# AI ADOPTION VS AUTOMATION RISK

plt.figure(figsize=(11, 7))

sns.regplot(
    data=df,
    x="ai_adoption_index",
    y="sector_automation_risk_score",
    scatter_kws={
        "alpha": 0.25,  #transparency
        "s": 35,    #size
        "color": TEAL
    },
    line_kws={"color": NAVY,"linewidth": 3}
)

plt.title(
    "AI Adoption vs. Sector Automation Risk",
    pad=20  #padding/spacing
)

plt.xlabel("AI Adoption Index")
plt.ylabel("Automation Risk Score")

plt.tight_layout()  #so labels don't get cut off

plt.savefig(
    f"{OUTPUT_DIR}/01_ai_adoption_vs_automation_risk.png",
    dpi=300,
    bbox_inches="tight"
)
plt.show()


# CHART 2 horizontal bar chart
# WORKFORCE IMPACT BY INDUSTRY

industry = (
    df.groupby("industry_sector")[
        [
            "pct_sector_workforce_displaced",
            "pct_sector_workforce_new_roles_created"
        ]
    ]
    .mean()
    .sort_values("pct_sector_workforce_displaced",ascending=True)
)

# Convert to percentages
industry_pct = industry * 100

ax = industry_pct.plot(
    kind="barh",    #bar horizontal
    figsize=(12, 8),
    color=[NAVY, GOLD],
    width=0.75
)

plt.title("Workforce Impact by Industry",pad=20)

plt.xlabel("Average Share of Sector Workforce (%)")
plt.ylabel("")

plt.legend(
    ["Workforce displaced","New roles created"],
    frameon=False,  #remove background border box
    loc="lower right"
)

plt.grid(axis="x",alpha=0.15)

plt.tight_layout()

plt.savefig(
    f"{OUTPUT_DIR}/02_workforce_impact_by_industry.png",
    dpi=300,
    bbox_inches="tight"
)

plt.show()


# CHART 3 line chart
# AI ADOPTION OVER TIME

yearly = (
    df.groupby("year")["ai_adoption_index"]
    .mean()
    .reset_index()
)

plt.figure(figsize=(11, 7))

plt.plot(
    yearly["year"],
    yearly["ai_adoption_index"],
    marker="o",
    linewidth=3,
    markersize=7,
    color=NAVY,
    label="AI adoption index"
)

plt.title("AI Adoption Trends, 2020–2026",pad=20)

plt.xlabel("Year")
plt.ylabel("Average Adoption Level")

plt.xticks(yearly["year"])

plt.legend(frameon=False)

plt.grid(alpha=0.15)

plt.tight_layout()

plt.savefig(
    f"{OUTPUT_DIR}/03_ai_adoption_over_time.png",
    dpi=300,
    bbox_inches="tight"
)

plt.show()


# CHART 4  Interactive chart
# Is there a relationship between GDP per capita and AI adoption?

plotly_data = (
    df.groupby(["country","region","income_group"],
        as_index=False)
    .agg(gdp_per_capita_usd=("gdp_per_capita_usd","mean"),
        ai_adoption_index=("ai_adoption_index","mean"),
        automation_risk=("sector_automation_risk_score","mean")
    )
)
fig = px.scatter(
    plotly_data,
    x="gdp_per_capita_usd",
    y="ai_adoption_index",
    size="automation_risk",     #size reflects the automation risk
    color="income_group",
    hover_name="country",
    hover_data={
        "region": True,
        "gdp_per_capita_usd": ":,.0f",
        "ai_adoption_index": ":.2f",
        "automation_risk": ":.2f"
    },

    color_discrete_sequence=[NAVY,TEAL,GOLD],

   title="GDP per Capita vs. AI Adoption",

    labels={
        "gdp_per_capita_usd": "GDP per Capita (USD)",
        "ai_adoption_index": "AI Adoption Index",
        "automation_risk": "Automation Risk",
        "income_group": "Income Group"
    }
)

fig.update_layout(
    template="simple_white",
      title={
        "x": 0.5,
        "xanchor": "center"
    },
    font=dict(
        size=13
    ),
    legend_title_text="Income Group"
)

fig.update_traces(  #make points a bit transparent
    marker=dict(opacity=0.75)
)

fig.show()

fig.write_html(
    f"{OUTPUT_DIR}/04_gdp_vs_ai_adoption_interactive.html"
)
