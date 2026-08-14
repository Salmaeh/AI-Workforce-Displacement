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






-- Dashboard 2 — AI Workforce Impact



-- Dashboard 3 — Adaptation & Reskilling

