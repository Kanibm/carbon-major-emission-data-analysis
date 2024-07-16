use carbon_emission;

----low granularity table-----

select *from emissions_low_granularity;


------ distinct types of parent entity from emissions_low_granularity----

select distinct parent_entity from emissions_low_granularity;

------ distinct types of parent types from emissions_low_granularity----

select distinct parent_type from emissions_low_granularity;

------ total co2 emission value by year from emissions_low_granularity----

select year,total_emissions_MtCO2e from emissions_low_granularity
order by year asc;

-----group by parent types----
select parent_type,sum(total_emissions_MtCO2e) as emission_value from emissions_low_granularity
group by parent_type;

------entity count group by parent type-----
select parent_type,count(parent_entity) as entity_count from emissions_low_granularity
group by parent_type;


------medium granularity table view--------
select*from emissions_medium_granularity;

---distinct commodity from medium granularity table----
select distinct commodity from emissions_medium_granularity;

-------group by commodity production value and total emission co2 medium granularity----
select commodity,round(sum(production_value))as production_value,round(sum(total_emissions_MtCO2e)) as emission_CO2_value 
from emissions_medium_granularity
group by commodity;

------10 high CO2 emission value by parent entity group-----
select parent_entity,round(sum(total_emissions_MtCO2e)) as emission_CO2_value
from emissions_medium_granularity
group by parent_entity
Order by emission_CO2_value desc limit 10;

------inner join used for low&medim total GRANULARITY tables ----
select l.parent_type,M.commodity,M.total_emissions_MtCO2e
from emissions_low_granularity as l inner join emissions_medium_granularity as M
on l.total_emissions_MtCO2e=M.total_emissions_MtCO2e;

select M.commodity,M.total_emissions_MtCO2e,l.parent_entity
from emissions_medium_granularity as M LEFT join emissions_low_granularity as l
on M.total_emissions_MtCO2e=l.total_emissions_MtCO2e;

select year,parent_entity,parent_type,total_emissions_MtCO2e from emissions_medium_granularity
where total_emissions_MtCO2e>5000;






