create database Workforce

-- Dashboard 1 — AI Workforce Impact

-- Which industries have the highest automation risk, workforce displacement, and negative net workforce change?

-- KPI 1 — Avg Automation Risk
select AVG(sector_automation_risk_score) as Avg_Automation_Risk
from ai_workforce_displacement

-- KPI 2 — Avg Workforce Displaced %%
select AVG(pct_sector_workforce_displaced) as Avg_Workforce_Displaced
from ai_workforce_displacement

-- KPI 3 - Avg New Roles Created %%
select AVG(pct_sector_workforce_new_roles_created) as Avg_New_Roles_Created
from ai_workforce_displacement

-- KPI 4 - Net Workforce Change %%
select AVG(net_workforce_change_pct) as Net_Workforce_Change
from ai_workforce_displacement

-- KPI 5 — AI-Cited Layoff Announcements
select AVG(ai_cited_layoff_announcements) as AI_Cited_Layoff_Announcements
from ai_workforce_displacement

-- Charts

--1 Which industries have the highest percentage of workforce displaced by AI? ( Workforce Displacement by Industry)
select industry_sector , avg(pct_sector_workforce_displaced) as Avg_Workforce_Displaced
from ai_workforce_displacement
group by industry_sector 
order by Avg_Workforce_Displaced desc

--2 Which industries have the highest automation risk? (Automation Risk by Industry) 
select industry_sector , avg(sector_automation_risk_score) as Avg_automation_risk_score
from ai_workforce_displacement
group by industry_sector 
order by Avg_automation_risk_score desc

-- ممكن يتم استبدال 2  Scatter Plot
-- Is higher automation risk associated with higher workforce displacement? 
-- x ( sector_automation_risk_score) , y (pct_sector_workforce_displaced) , legend ( industry_sector )


--Which industries are experiencing workforce growth or decline after accounting for both displaced and newly created roles?
--3 (Net Workforce Change by Industry)
select industry_sector , avg(net_workforce_change_pct) as Net_Workforce_Change
from ai_workforce_displacement
group by industry_sector 
order by Net_Workforce_Change desc

--4 Which industries are creating the most new job opportunities as a result of AI transformation?(New Roles Created by Industry)
select industry_sector , avg(pct_sector_workforce_new_roles_created) as Avg_New_Roles_Created
from ai_workforce_displacement
group by industry_sector 
order by Avg_New_Roles_Created desc

-- 5 Which industries have the highest number of AI-cited layoff announcements?(Top Industries by AI-related Layoffs)
-- top 5
select industry_sector , sum(ai_cited_layoff_announcements) as AI_Cited_Layoff_Announcements
from ai_workforce_displacement
group by industry_sector 
order by AI_Cited_Layoff_Announcements desc






-- Dashboard 2 — AI Adoption & Workforce Impact

-- How has AI adoption changed from 2020 to 2026? ( AI Adoption Trend Over Time )
-- Visual : Line Chart 
select  year , avg(ai_adoption_index) as avg_ai_adoption_index
from ai_workforce_displacement
group by year
order by avg_ai_adoption_index desc

-- Which industries have the highest levels of AI adoption? ( AI Adoption by Industry )
select  industry_sector , avg(ai_adoption_index) as avg_ai_adoption_index
from ai_workforce_displacement
group by industry_sector
order by avg_ai_adoption_index desc

-- Is higher AI adoption associated with higher workforce displacement? ( AI Adoption vs Workforce Displacement )
-- Visual: Scatter Plot
-- x ( ai_adoption_index) , y ( pct_sector_workforce_displaced ), size ( ai_cited_layoff_announcements) , legend (industry_sector)
select  country ,region, industry_sector ,
AVG(ai_adoption_index) AS avg_ai_adoption,
AVG(pct_sector_workforce_displaced) AS avg_workforce_displaced,
SUM(ai_cited_layoff_announcements)  AS total_ai_layoffs

from ai_workforce_displacement
group by country ,region , industry_sector
order by total_ai_layoffs desc


-- How is AI tool adoption associated with overall workforce change? ( AI Tool Adoption vs Net Workforce Change)
-- Scatter Plot x ( avg_ai_tool_adoption) , y ( avg_net_workforce_change ) , legend industry_sector ,details country
select  country ,region, industry_sector ,
AVG(ai_tool_adoption_pct) AS avg_ai_tool_adoption,
AVG(net_workforce_change_pct) AS avg_net_workforce_change

from ai_workforce_displacement
group by country ,region , industry_sector


-- Which regions have the highest AI adoption levels? ( AI Adoption by Region )
-- map country , region
select  region , avg(ai_adoption_index) as avg_ai_adoption_index
from ai_workforce_displacement
group by region
order by avg_ai_adoption_index desc

-- Which industries have both high AI adoption and positive job creation
-- bar chart x industry_sector , y avg adoption - Tooltip = avg_net_workforce_change


-- Slicers ( year - region - industry_sector - country ) 





-- Dashboard 3 — Workforce Adaptation & Reskilling

-- How are governments and organizations responding to AI-driven workforce disruption?

-- KPI 1 - Average Reskilling Programs
select COUNT(reskilling_programs_count) as reskilling_programs_count
from ai_workforce_displacement

-- KPI 2 -  Average Government AI Policy Score
select avg(govt_ai_policy_score_1_to_10)  
from ai_workforce_displacement

-- KPI 3 -  Average AI Skill Wage Premium
select avg(ai_skill_wage_premium_pct)   as avg_ai_skill
from ai_workforce_displacement


-- KPI 4 -  Average New Roles Created %
select avg(pct_sector_workforce_new_roles_created)   as avg_pct_sector
from ai_workforce_displacement


-- KPI 5 -  Average New Roles Created %
select avg(net_workforce_change_pct)   as avg_net_workforce
from ai_workforce_displacement

-- Charts
-- Is greater investment in reskilling associated with better workforce outcomes?(Reskilling Programs vs Net Workforce Change )
-- x reskilling_programs_count, y net_workforce_change_pct , legend industry_sector 
select  country ,region, industry_sector ,
AVG(reskilling_programs_count) AS avg_reskilling_programs,
AVG(net_workforce_change_pct) AS avg_net_workforce_change

from ai_workforce_displacement
group by country ,region , industry_sector 

-- Are stronger government AI policies associated with lower workforce displacement? ( Government AI Policy Score vs Workforce Displacement)
-- x govt_ai_policy_score_1_to_10 , y pct_sector_workforce_displaced , size reskilling_programs_count

-- Which regions are investing the most in workforce reskilling? ( Reskilling Programs by Region )
select  region , avg(reskilling_programs_count) as avg_reskilling
from ai_workforce_displacement
group by region
order by avg_reskilling desc

-- Which regions have the strongest government AI policy frameworks? ( Government AI Policy Score by Region)
select  region , avg(govt_ai_policy_score_1_to_10) as avg_policy
from ai_workforce_displacement
group by region
order by avg_policy desc

-- Which industries offer the highest wage premium for AI skills? ( AI Skill Wage Premium)
select  region ,industry_sector, avg(ai_skill_wage_premium_pct) as avg_skill
from ai_workforce_displacement
group by region,industry_sector
order by avg_skill desc

-- Is stronger AI policy associated with lower workforce displacement 
-- x avg_policy_score , y avg_workforce_displaced , legend industry_sector , det country , play axis year 

-- Slicers ( year - region -  industry_sector - Income Group _ country )


