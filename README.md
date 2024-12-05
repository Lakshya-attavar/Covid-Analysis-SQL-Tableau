# Covid-Analysis-SQL-Tableau
### Project Background:

This project explores and visualises the covid-19 data from various countries across the world. It is designed to help understand the  extent and impact of the coronavirus infection.

<img width="991" alt="image-9" src="https://github.com/user-attachments/assets/214c0788-59d6-4ed7-b2f3-db3e7780e7a0">

The data exploration SQL script can be found here [[link]](https://github.com/Lakshya-attavar/Covid-Analysis-SQL-Tableau/blob/main/covid_analysis.sql).

A Tableau dashboard used to visualise the spread and Impact of covid can be found here [[link]](https://github.com/Lakshya-attavar/Covid-Analysis-SQL-Tableau/blob/main/Covid_Analysis.twb).

### Data Structure

The database structure as seen below consists of 2 tables: CovidDeaths and CovidVaccinations. A description of each table is as follows:

- **CovidDeaths:** This table contains information on the country, continent is belongs to, its population, the reproduction rate, number of new cases and deaths, total cases and deaths, number of icu and hospitalised patients on a daily basis from 24/02/2020 to 30/04/2021.
- **CovidVaccinations:** This table consists details about the number of tests, positive rates, number of newly vaccinated people, no.of fully vaccinated people for each country on a daily basis from 24/02/2020 to 30/04/2021.

### Insights:

- Andorra has the highest percent of population infected followed by Montenegro and Czechia.
- Hungary has the highest percent of deaths compared to infected cases.
- As of April 2021 the no.of cases are on the rise and are predicted to increase in the coming months.

### Assumptions and Caveats:

- The data set contains covid data from 24/02/2020 to 30/04/2021, therefore does not capture the accurate trends and overall numbers from the pandemic.
