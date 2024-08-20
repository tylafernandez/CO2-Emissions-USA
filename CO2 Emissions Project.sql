-- SQL Project

-- CO2 Emissions (USA)
-- via: kaggle.com

-- View the raw emissions data

SELECT *
FROM emissions;

-- Create a new table `emissions_usa` with the same structure as `emissions`

CREATE TABLE emissions_usa
LIKE emissions; 

SELECT *
FROM emissions_usa;

-- Create a new table `emissions_usa` with the same structure as `emissions`

INSERT emissions_usa
SELECT *
FROM emissions; 

SELECT *
FROM emissions_usa;

-- Query data for 'New York' in `emissions_usa`

SELECT *
FROM emissions_usa
WHERE `state-name` = 'New York';

-- Query data for 'Nstural Gas' in `emissions_usa`

SELECT *
FROM emissions_usa
WHERE `fuel-name` = 'Natural Gas'
GROUP BY `sector-name`;

-- Aggregate CO2 emissions by sector for 'Natural Gas'

SELECT `sector-name`, SUM(`value`) AS total_value
FROM emissions_usa
WHERE `fuel-name` = 'Natural Gas'
GROUP BY `sector-name`;

SELECT `sector-name`, SUM(`value`) AS total_value
FROM emissions_usa
WHERE `fuel-name` = 'Natural Gas'
GROUP BY `sector-name`
ORDER BY total_value DESC; 

SELECT *
FROM emissions_usa; 

SELECT `fuel-name`, `sector-name`, SUM(`value`) AS total_value
FROM emissions_usa
GROUP BY `fuel-name`, `sector-name`
ORDER BY `fuel-name`, total_value DESC;

-- Group by state and sector

SELECT `state-name`, `sector-name`, SUM(`value`) AS total_value
FROM emissions_usa
GROUP BY `state-name`, `sector-name`
ORDER BY `state-name`, `sector-name`; 

SELECT year, `sector-name`, SUM(`value`) AS total_value
FROM emissions_usa
GROUP BY year, `sector-name`
ORDER BY year, `sector-name`; 

-- Group by year and fuel

SELECT year, `fuel-name`, SUM(`value`) AS total_value
FROM emissions_usa
GROUP BY year, `fuel-name`
ORDER BY year, `fuel-name`; 

-- Group by year and sector

SELECT year, `state-name`, `sector-name`, SUM(`value`) AS total_value
FROM emissions_usa
GROUP BY year, `state-name`, `sector-name`
ORDER BY year, total_value DESC;

-- Group by year, state, and fuel

SELECT year, `state-name`, `fuel-name`, SUM(`value`) AS total_value
FROM emissions_usa
GROUP BY year, `state-name`, `fuel-name`
ORDER BY year, total_value DESC;

-- Filter by 'All Fuels', group by year, state, and fuel

SELECT year, `state-name`, `fuel-name`, SUM(`value`) AS total_value
FROM emissions_usa
WHERE `fuel-name` = "All Fuels"
GROUP BY year, `state-name`, `fuel-name`
ORDER BY year, total_value DESC;

-- Filter by 'Petroleum', group by year, state, and fuel

SELECT year, `state-name`, `fuel-name`, SUM(`value`) AS total_value
FROM emissions_usa
WHERE `fuel-name` = "Petroleum"
GROUP BY year, `state-name`, `fuel-name`
ORDER BY year, total_value DESC;

-- Filter by 'Natural Gas', group by year, state, an

SELECT year, `state-name`, `fuel-name`, SUM(`value`) AS total_value
FROM emissions_usa
WHERE `fuel-name` = "Natural Gas"
GROUP BY year, `state-name`, `fuel-name`
ORDER BY year, total_value DESC;

-- Filter by 'Coal', group by year, state, and fuel

SELECT year, `state-name`, `fuel-name`, SUM(`value`) AS total_value
FROM emissions_usa
WHERE `fuel-name` = "Coal"
GROUP BY year, `state-name`, `fuel-name`
ORDER BY year, total_value DESC;

-- Join subqueries to aggregate total values for Petroleum, Natural Gas, and Coal by year and state

SELECT 
    p.year, 
    p.`state-name`,
    p.total_value AS petroleum_total,
    ng.total_value AS natural_gas_total,
    c.total_value AS coal_total
FROM 
    (SELECT year, `state-name`, SUM(`value`) AS total_value
     FROM emissions_usa
     WHERE `fuel-name` = "Petroleum"
     GROUP BY year, `state-name`) p
LEFT JOIN 
    (SELECT year, `state-name`, SUM(`value`) AS total_value
     FROM emissions_usa
     WHERE `fuel-name` = "Natural Gas"
     GROUP BY year, `state-name`) ng
ON p.year = ng.year AND p.`state-name` = ng.`state-name`
LEFT JOIN 
    (SELECT year, `state-name`, SUM(`value`) AS total_value
     FROM emissions_usa
     WHERE `fuel-name` = "Coal"
     GROUP BY year, `state-name`) c
ON p.year = c.year AND p.`state-name` = c.`state-name`
ORDER BY p.year, p.total_value DESC;

-- Create a summary table with total values for Petroleum, Natural Gas, and Coal

CREATE TABLE emissions_summary AS
SELECT 
    p.year, 
    p.`state-name`,
    p.total_value AS petroleum_total,
    ng.total_value AS natural_gas_total,
    c.total_value AS coal_total
FROM 
    (SELECT year, `state-name`, SUM(`value`) AS total_value
     FROM emissions_usa
     WHERE `fuel-name` = "Petroleum"
     GROUP BY year, `state-name`) p
LEFT JOIN 
    (SELECT year, `state-name`, SUM(`value`) AS total_value
     FROM emissions_usa
     WHERE `fuel-name` = "Natural Gas"
     GROUP BY year, `state-name`) ng
ON p.year = ng.year AND p.`state-name` = ng.`state-name`
LEFT JOIN 
    (SELECT year, `state-name`, SUM(`value`) AS total_value
     FROM emissions_usa
     WHERE `fuel-name` = "Coal"
     GROUP BY year, `state-name`) c
ON p.year = c.year AND p.`state-name` = c.`state-name`
ORDER BY p.year, p.total_value DESC;

SELECT *
FROM emissions_summary;

-- Aggregate total values for each fuel by year

SELECT 
    p.year, 
    p.total_value AS petroleum_total,
    ng.total_value AS natural_gas_total,
    c.total_value AS coal_total
FROM 
    (SELECT year, SUM(`value`) AS total_value
     FROM emissions_usa
     WHERE `fuel-name` = "Petroleum"
     GROUP BY year) p
LEFT JOIN 
    (SELECT year, SUM(`value`) AS total_value
     FROM emissions_usa
     WHERE `fuel-name` = "Natural Gas"
     GROUP BY year) ng
ON p.year = ng.year
LEFT JOIN 
    (SELECT year, SUM(`value`) AS total_value
     FROM emissions_usa
     WHERE `fuel-name` = "Coal"
     GROUP BY year) c
ON p.year = c.year
ORDER BY p.year;

SELECT *
FROM emissions_usa; 

SELECT DISTINCT `sector-name`
FROM emissions_usa; 

-- Total Sum per Sector

ALTER TABLE emissions_usa
ADD COLUMN detailed_sector_name VARCHAR(255);

SELECT *
FROM emissions_usa; 

UPDATE emissions_usa
SET detailed_sector_name = CASE 
    WHEN `sector-name` = 'Industrial' THEN 'Industrial carbon dioxide emissions'
    WHEN `sector-name` = 'Total' THEN 'Total carbon dioxide emissions from all sectors'
    WHEN `sector-name` = 'Residential' THEN 'Residential carbon dioxide emissions'
    WHEN `sector-name` = 'Commercial' THEN 'Commercial carbon dioxide emissions'
    WHEN `sector-name` = 'Transportation' THEN 'Transportation carbon dioxide emissions'
    WHEN `sector-name` = 'Electric Power' THEN 'Electric Power carbon dioxide emissions'
    ELSE 'Unknown sector'
END;


SELECT DISTINCT `sector-name`
FROM emissions_usa;

-- Simplify sector names and aggregate emissions

SELECT e.year,
       CASE 
           WHEN TRIM(e.`sector-name`) = 'Industrial carbon dioxide emissions' THEN 'Industrial'
           WHEN TRIM(e.`sector-name`) = 'Total carbon dioxide emissions from all sectors' THEN 'Total'
           WHEN TRIM(e.`sector-name`) = 'Residential carbon dioxide emissions' THEN 'Residential'
           WHEN TRIM(e.`sector-name`) = 'Commercial carbon dioxide emissions' THEN 'Commercial'
           WHEN TRIM(e.`sector-name`) = 'Transportation carbon dioxide emissions' THEN 'Transportation'
           WHEN TRIM(e.`sector-name`) = 'Electric Power carbon dioxide emissions' THEN 'Electric Power'
           ELSE 'Unknown sector'
       END AS simplified_sector_name,
       SUM(e.`value`) AS total_value
FROM emissions_usa e
GROUP BY e.year, e.`sector-name`
ORDER BY e.year, simplified_sector_name;

SELECT *
FROM emissions_usa;

-- Create a pivoted summary table for simplified sector names

CREATE TABLE sector_summary AS
SELECT e.year,
       CASE 
           WHEN TRIM(e.`sector-name`) = 'Industrial carbon dioxide emissions' THEN 'Industrial'
           WHEN TRIM(e.`sector-name`) = 'Total carbon dioxide emissions from all sectors' THEN 'Total'
           WHEN TRIM(e.`sector-name`) = 'Residential carbon dioxide emissions' THEN 'Residential'
           WHEN TRIM(e.`sector-name`) = 'Commercial carbon dioxide emissions' THEN 'Commercial'
           WHEN TRIM(e.`sector-name`) = 'Transportation carbon dioxide emissions' THEN 'Transportation'
           WHEN TRIM(e.`sector-name`) = 'Electric Power carbon dioxide emissions' THEN 'Electric Power'
           ELSE 'Unknown sector'
       END AS simplified_sector_name,
       SUM(e.`value`) AS total_value
FROM emissions_usa e
GROUP BY e.year, e.`sector-name`
ORDER BY e.year, simplified_sector_name;

SELECT *
FROM sector_summary; 

-- Query data for specific sectors and order by total value in descending order

SELECT *
FROM sector_summary
WHERE simplified_sector_name = 'Total'; 

SELECT *
FROM sector_summary
WHERE simplified_sector_name = 'Total'
ORDER BY total_value DESC; 

SELECT *
FROM sector_summary
WHERE simplified_sector_name = 'Industrial'
ORDER BY total_value DESC; 

SELECT *
FROM sector_summary
WHERE simplified_sector_name = 'Commercial'
ORDER BY total_value DESC; 

SELECT *
FROM sector_summary
WHERE simplified_sector_name = 'Transportation'
ORDER BY total_value DESC; 

SELECT *
FROM sector_summary
WHERE simplified_sector_name = 'Electric Power'
ORDER BY total_value DESC; 

SELECT *
FROM sector_summary
WHERE simplified_sector_name = 'Residential'
ORDER BY total_value DESC; 

-- Query data for specific sectors and order by total value in descending order

SELECT year,
       MAX(CASE WHEN simplified_sector_name = 'Commercial' THEN total_value END) AS Commercial,
       MAX(CASE WHEN simplified_sector_name = 'Electric Power' THEN total_value END) AS Electric_Power,
       MAX(CASE WHEN simplified_sector_name = 'Industrial' THEN total_value END) AS Industrial,
       MAX(CASE WHEN simplified_sector_name = 'Residential' THEN total_value END) AS Residential,
       MAX(CASE WHEN simplified_sector_name = 'Transportation' THEN total_value END) AS Transportation,
       MAX(CASE WHEN simplified_sector_name = 'Total' THEN total_value END) AS Total
FROM sector_summary
GROUP BY year
ORDER BY year;

-- Create a table with pivoted sector summaries

CREATE TABLE pivoted_sector_summary AS
SELECT year,
       MAX(CASE WHEN simplified_sector_name = 'Commercial' THEN total_value END) AS Commercial,
       MAX(CASE WHEN simplified_sector_name = 'Electric Power' THEN total_value END) AS Electric_Power,
       MAX(CASE WHEN simplified_sector_name = 'Industrial' THEN total_value END) AS Industrial,
       MAX(CASE WHEN simplified_sector_name = 'Residential' THEN total_value END) AS Residential,
       MAX(CASE WHEN simplified_sector_name = 'Total' THEN total_value END) AS Total,
       MAX(CASE WHEN simplified_sector_name = 'Transportation' THEN total_value END) AS Transportation
FROM sector_summary
GROUP BY year
ORDER BY year;

SELECT *
FROM pivoted_sector_summary; 

SELECT *
FROM sector_summary; 

SELECT *
FROM emissions_usa;

SELECT *
FROM emissions_summary;

-- Query top 10 years for various sectors

SELECT year, Commercial
FROM pivoted_sector_summary
ORDER BY Commercial DESC
LIMIT 10;

SELECT year, Electric_Power
FROM pivoted_sector_summary
ORDER BY Electric_Power DESC
LIMIT 10;

SELECT year, Residential 
FROM pivoted_sector_summary
ORDER BY Residential DESC
LIMIT 10;

SELECT year, Transportation
FROM pivoted_sector_summary
ORDER BY Transportation DESC
LIMIT 10;

SELECT year, Industrial
FROM pivoted_sector_summary
ORDER BY Industrial DESC
LIMIT 10;

SELECT year, Total
FROM pivoted_sector_summary
ORDER BY Total DESC
LIMIT 10;

-- Query bottom 10 years for various sectors

SELECT year, Commercial
FROM pivoted_sector_summary
ORDER BY Commercial ASC
LIMIT 10;

SELECT year, Electric_Power
FROM pivoted_sector_summary
ORDER BY Electric_Power ASC
LIMIT 10;

SELECT year, Residential 
FROM pivoted_sector_summary
ORDER BY Residential ASC
LIMIT 10;

SELECT year, Transportation
FROM pivoted_sector_summary
ORDER BY Transportation ASC
LIMIT 10;

SELECT year, Industrial
FROM pivoted_sector_summary
ORDER BY Industrial ASC
LIMIT 10;

SELECT year, Total
FROM pivoted_sector_summary
ORDER BY Total ASC
LIMIT 10;

SELECT *
FROM emissions_summary;

-- Query top 10 states for petroleum emissions excluding 'United States'

SELECT year, `state-name`, petroleum_total
FROM emissions_summary
WHERE `state-name` != 'United States'
ORDER BY petroleum_total DESC
LIMIT 10;

-- Query top 10 states for natural gas emissions excluding 'United States'

SELECT year, `state-name`, natural_gas_total
FROM emissions_summary
WHERE `state-name` != 'United States'
ORDER BY natural_gas_total DESC
LIMIT 10;

-- Query top 10 states for coal emissions excluding 'United States'

SELECT year, `state-name`, coal_total
FROM emissions_summary
WHERE `state-name` != 'United States'
ORDER BY coal_total DESC
LIMIT 10;