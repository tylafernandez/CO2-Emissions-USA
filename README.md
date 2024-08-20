# CO2-Emissions-USA

SQL Project: CO2 Emissions Analysis (USA)
Overview
This project involves analyzing CO2 emissions data in the United States, sourced from Kaggle. The analysis focuses on understanding emissions across various sectors and fuels, aggregating data by year, state, and fuel type, and providing insights into the emissions trends.

Data Source
Data File: CO2 Emissions dataset from Kaggle (https://www.kaggle.com/datasets/abdelrahman16/co2-emissions-usa/data)
Original Table: emissions
Tables Created
emissions_usa: Duplicate of the emissions table for USA-specific analysis.
emissions_summary: Summary table aggregating emissions by fuel type and state.
sector_summary: Summary table with simplified sector names and aggregated emissions.
pivoted_sector_summary: Pivoted table showing emissions by sector per year.
Key SQL Operations
Data Duplication and Modification

Created emissions_usa table by copying data from emissions.
Updated column names for clarity and consistency.
Data Aggregation

Aggregated CO2 emissions by sector and fuel type.
Grouped and summarized data by year, state, and fuel.
Data Filtering and Transformation

Filtered data by specific fuels (e.g., Petroleum, Natural Gas, Coal).
Created a summary table for each fuel type.
Added and updated columns with detailed sector names.
Pivoting and Advanced Analysis

Pivoted data to show emissions by sector per year.
Created pivoted summaries to compare emissions trends across different sectors.
Data Queries

Generated queries to retrieve top and bottom states and years for various emissions.
Excluded specific records (e.g., 'United States') to focus on individual states.
SQL Scripts
The SQL scripts provided in this project perform the following operations:

Data duplication and table creation.
Column renaming and updates.
Aggregation and summarization of emissions data.
Filtering, transforming, and pivoting data for detailed analysis.
Queries for top and bottom emissions data by state and year.
