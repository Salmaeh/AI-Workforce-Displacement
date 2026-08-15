--Dashboard 1 — AI Workforce Impact

--KPI 1 — Average Automation Risk Score
SELECT 
   round( AVG(sector_automation_risk_score)*100,2) AS Avg_Automation_Risk
FROM ai_workforce_displacement;

--KPI 2 — Average Workforce Displaced (%)
SELECT 
   round( AVG(pct_sector_workforce_displaced) * 100,2) AS Avg_Workforce_Displaced
FROM ai_workforce_displacement;

--KPI 3 — Average New Roles Created (%)
SELECT 
   round( AVG(pct_sector_workforce_new_roles_created) * 100,2) AS Avg_New_Roles_Created
FROM ai_workforce_displacement;

--KPI 4 — Average Net Workforce Change (%)
SELECT 
    round(AVG(net_workforce_change_pct) * 100,2) AS Avg_Net_Workforce_Change
FROM ai_workforce_displacement;
--KPI 5 — Total AI-Cited Layoff Announcements
SELECT 
    SUM(ai_cited_layoff_announcements) AS Total_AI_Cited_Layoffs
FROM ai_workforce_displacement;















-- Q1. Which industries have the highest workforce displacement?
SELECT 
    industry_sector,
    Round(AVG(pct_sector_workforce_displaced) * 100,2) AS Avg_Workforce_Displaced
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_Workforce_Displaced DESC;













--Q2. Is higher automation risk associated with higher workforce displacement?
SELECT
    industry_sector,
    ROUND(AVG(sector_automation_risk_score), 2) AS Avg_Automation_Risk,
    Round(AVG(pct_sector_workforce_displaced) * 100,2) AS Avg_Workforce_Displaced
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_Automation_Risk DESC;







--Q3. Which industries have positive or negative net workforce change?
SELECT
    industry_sector,
    ROUND(AVG(net_workforce_change_pct), 2) AS Avg_Net_Workforce_Change
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_Net_Workforce_Change DESC;



--Q4. Which industries have the highest AI-cited layoffs?
SELECT TOP 5
    industry_sector,
    SUM(ai_cited_layoff_announcements) AS Total_AI_Cited_Layoffs
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Total_AI_Cited_Layoffs DESC;

--Q5. Which industries are most exposed to automation risk?
SELECT
    industry_sector,
    ROUND(AVG(sector_automation_risk_score), 2) AS Avg_Automation_Risk
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_Automation_Risk DESC;

-- Q6. Which industries experience the greatest workforce pressure from AI?
SELECT
    industry_sector,
    ROUND(AVG(sector_automation_risk_score), 2) AS Avg_Automation_Risk,
    ROUND(AVG(pct_sector_workforce_displaced) * 100, 2) AS Avg_Workforce_Displaced,
    SUM(ai_cited_layoff_announcements) AS Total_AI_Cited_Layoffs
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_Workforce_Displaced DESC;




-- Dashboard 2 — AI Adoption & Workforce Transformation

--KPI 1 — Average AI Adoption Index
SELECT 
   round( AVG(ai_adoption_index)*100,2) AS Avg_AI_Adoption
FROM ai_workforce_displacement;

--KPI 2 — Average AI Tool Adoption (%)
SELECT 
   round( AVG(ai_tool_adoption_pct) * 100,2) AS Avg_AI_Tool_Adoption
FROM ai_workforce_displacement;

--KPI 3 — Average Workforce Displaced (%)
SELECT 
   round( AVG(pct_sector_workforce_displaced) * 100,2) AS Avg_Workforce_Displaced
FROM ai_workforce_displacement;

--KPI 4 — Average Net Workforce Change (%)
SELECT 
   round( AVG(net_workforce_change_pct) * 100,2) AS Avg_Net_Workforce_Change
FROM ai_workforce_displacement;
--KPI 5 — Average AI Skill Wage Premium (%)
SELECT 
  round(  AVG(ai_skill_wage_premium_pct) * 100,2) AS Avg_AI_Skill_Wage_Premium
FROM ai_workforce_displacement;


--Q1. How has AI adoption changed over time?
SELECT
    year,
    ROUND(AVG(ai_adoption_index), 2) AS Avg_AI_Adoption
FROM ai_workforce_displacement
GROUP BY year
ORDER BY year ASC;



--Q2. Which regions have the highest AI adoption?
SELECT
    region,
    ROUND(AVG(ai_adoption_index), 2) AS Avg_AI_Adoption
FROM ai_workforce_displacement
GROUP BY region
ORDER BY Avg_AI_Adoption DESC;

--Q3. Is higher AI adoption associated with higher workforce displacement?
SELECT
    industry_sector,
    ROUND(AVG(ai_adoption_index), 2) AS Avg_AI_Adoption,
    AVG(pct_sector_workforce_displaced) AS Avg_Workforce_Displaced,
    SUM(ai_cited_layoff_announcements) AS Total_AI_Cited_Layoffs
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_AI_Adoption DESC;


--Q4. Is higher AI tool adoption associated with better net workforce outcomes?
SELECT
    industry_sector,
    ROUND(AVG(ai_tool_adoption_pct), 2) AS Avg_AI_Tool_Adoption,
    ROUND(AVG(net_workforce_change_pct), 2) AS Avg_Net_Workforce_Change
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_AI_Tool_Adoption DESC;


-- Q5. Which industries have high AI adoption but relatively low workforce displacement?
SELECT
    industry_sector,
    ROUND(AVG(ai_adoption_index), 2) AS Avg_AI_Adoption,
    ROUND(AVG(pct_sector_workforce_displaced) * 100, 2) AS Avg_Workforce_Displaced
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_AI_Adoption DESC;


-- Dashboard 3 — Workforce Adaptation & Reskilling

--KPI 1 — Average Reskilling Programs
SELECT 
   round( AVG(reskilling_programs_count)*100,2) AS Avg_Reskilling_Programs
FROM ai_workforce_displacement;
--KPI 2 — Average AI Skill Wage Premium (%)
SELECT 
   round( AVG(ai_skill_wage_premium_pct) * 100,2) AS Avg_AI_Skill_Wage_Premium
FROM ai_workforce_displacement;
--KPI 3 — Average Workforce Displaced (%)
SELECT 
   round( AVG(pct_sector_workforce_displaced) * 100,2) AS Avg_Workforce_Displaced
FROM ai_workforce_displacement;
--KPI 4 — Average Net Workforce Change (%)
SELECT
   round( AVG(net_workforce_change_pct) * 100,2) AS Avg_Net_Workforce_Change
FROM ai_workforce_displacement;
--KPI 5 — Average AI Tool Adoption (%)
SELECT 
   round( AVG(ai_tool_adoption_pct) * 100,2) AS Avg_AI_Tool_Adoption
FROM ai_workforce_displacement;

--Q1. Is greater investment in reskilling associated with better workforce outcomes?
SELECT
    industry_sector,
    ROUND(AVG(reskilling_programs_count), 2) AS Avg_Reskilling_Programs,
    ROUND(AVG(net_workforce_change_pct), 2) AS Avg_Net_Workforce_Change
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_Reskilling_Programs DESC;



--Q2. Which regions invest the most in reskilling?
SELECT
    region,
    ROUND(AVG(reskilling_programs_count), 2) AS Avg_Reskilling_Programs
FROM ai_workforce_displacement
GROUP BY region
ORDER BY Avg_Reskilling_Programs DESC;


--Q3. Is higher AI adoption associated with a higher AI-skill wage premium?
SELECT
    industry_sector,
    ROUND(AVG(ai_adoption_index), 2) AS Avg_AI_Adoption,
    ROUND(AVG(ai_skill_wage_premium_pct), 2) AS Avg_AI_Skill_Wage_Premium
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_AI_Adoption DESC;

--Q4. Which industries combine high AI adoption with high AI-skill wage premiums?
SELECT
    industry_sector,
    ROUND(AVG(ai_adoption_index), 2) AS Avg_AI_Adoption,
    ROUND(AVG(ai_skill_wage_premium_pct), 2) AS Avg_AI_Skill_Wage_Premium
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_AI_Skill_Wage_Premium DESC;

--Q5. Does reskilling vary significantly across industries?
SELECT
    industry_sector,
    ROUND(AVG(reskilling_programs_count), 2) AS Avg_Reskilling_Programs
FROM ai_workforce_displacement
GROUP BY industry_sector
ORDER BY Avg_Reskilling_Programs DESC;


-- Dashboard 4 — Government & Workforce Resilience

--KPI 1 — Average Government AI Policy Score
SELECT 
   round( AVG(govt_ai_policy_score_1_to_10)*100,2) AS Avg_Government_AI_Policy_Score
FROM ai_workforce_displacement;
--KPI 2 — Average Workforce Displaced (%)
SELECT 
  round(  AVG(pct_sector_workforce_displaced) * 100,2) AS Avg_Workforce_Displaced
FROM ai_workforce_displacement;
--KPI 3 — Average Net Workforce Change (%)
SELECT 
   round( AVG(net_workforce_change_pct) * 100,2) AS Avg_Net_Workforce_Change
FROM ai_workforce_displacement;
--KPI 4 — Average Reskilling Programs
SELECT 
  round(  AVG(reskilling_programs_count)*100,2) AS Avg_Reskilling_Programs
FROM ai_workforce_displacement;

--KPI 5 — Average AI Adoption Index
SELECT 
   round( AVG(ai_adoption_index)*100,2) AS Avg_AI_Adoption
FROM ai_workforce_displacement;


--Q1. Are stronger government AI policies associated with lower workforce displacement?
SELECT
    region,
    ROUND(AVG(govt_ai_policy_score_1_to_10), 2) AS Avg_Government_AI_Policy_Score,
   AVG(pct_sector_workforce_displaced) AS Avg_Workforce_Displaced
FROM ai_workforce_displacement
GROUP BY region
ORDER BY Avg_Government_AI_Policy_Score DESC;

--Q2. Are stronger government AI policies associated with better net workforce outcomes?
SELECT
    region,
    ROUND(AVG(govt_ai_policy_score_1_to_10), 2) AS Avg_Government_AI_Policy_Score,
    ROUND(AVG(net_workforce_change_pct), 2) AS Avg_Net_Workforce_Change
FROM ai_workforce_displacement
GROUP BY region
ORDER BY Avg_Government_AI_Policy_Score DESC;

--Q3. Which regions have the strongest government AI policy frameworks?
SELECT
    region,
    ROUND(AVG(govt_ai_policy_score_1_to_10), 2) AS Avg_Government_AI_Policy_Score
FROM ai_workforce_displacement
GROUP BY region
ORDER BY Avg_Government_AI_Policy_Score DESC;

--Q4. Are stronger government policies associated with greater investment in reskilling?
SELECT
    region,
    ROUND(AVG(govt_ai_policy_score_1_to_10), 2) AS Avg_Government_AI_Policy_Score,
    ROUND(AVG(reskilling_programs_count), 2) AS Avg_Reskilling_Programs
FROM ai_workforce_displacement
GROUP BY region
ORDER BY Avg_Government_AI_Policy_Score DESC;

--Q5. Which income groups have the strongest AI policy frameworks?
SELECT
    income_group,
    ROUND(AVG(govt_ai_policy_score_1_to_10), 2) AS Avg_Government_AI_Policy_Score
FROM ai_workforce_displacement
GROUP BY income_group
ORDER BY Avg_Government_AI_Policy_Score DESC;

--Q6. Is higher AI adoption associated with stronger government AI policies?
SELECT top 10
    country,
    region,
    ROUND(AVG(ai_adoption_index), 2) AS Avg_AI_Adoption,
    ROUND(AVG(govt_ai_policy_score_1_to_10), 2) AS Avg_Government_AI_Policy_Score
FROM ai_workforce_displacement
GROUP BY country, region
ORDER BY Avg_AI_Adoption DESC;







--Q7. Which countries combine high AI adoption with strong policies and positive workforce outcomes?
SELECT top 10
    country,
    region,
    ROUND(AVG(ai_adoption_index), 2) AS Avg_AI_Adoption,
    ROUND(AVG(govt_ai_policy_score_1_to_10), 2) AS Avg_Government_AI_Policy_Score,
    ROUND(AVG(net_workforce_change_pct), 2) AS Avg_Net_Workforce_Change,
    ROUND(AVG(reskilling_programs_count), 2) AS Avg_Reskilling_Programs
FROM ai_workforce_displacement
GROUP BY country, region
ORDER BY Avg_Net_Workforce_Change DESC;
