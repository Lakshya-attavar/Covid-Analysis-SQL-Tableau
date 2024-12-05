USE project_2;

SELECT * FROM coviddeaths
ORDER BY 3, 4;

SELECT * FROM covidvaccinations
ORDER BY 3, 4;

-- Overview of the no. of cases annd deaths
SELECT location,  date, population, total_cases, new_cases, total_deaths
FROM coviddeaths
ORDER BY 1,2;

-- percentage of deaths for total cases : Shows the likelihood of dying if you contract covid in the UK
SELECT location, date, population, total_cases, total_deaths, round((total_deaths/total_cases)*100, 2) as percentage_deaths
FROM coviddeaths
WHERE location LIKE 'United Kingdom'
ORDER BY 1,2;
 
-- Probability of being infected in the UK 
SELECT location, date, population, total_cases, round((total_cases/population)*100, 2) as percentage_infected
FROM coviddeaths
WHERE location LIKE 'United Kingdom'
ORDER BY 1,2;

-- Countries with highest infection rate compared to its population
SELECT location, population, max(total_cases) Total_infection_count, (max(round((total_cases/population)*100, 2))) as max_percentage_infected
FROM coviddeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY max_percentage_infected DESC;

-- Countries with the highest death rate per population
SELECT location, population, max(total_deaths) as total_death_count, (max(round((total_deaths/population)*100, 2))) as max_percentage_death
FROM coviddeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY max_percentage_death DESC;

-- Continents with the highest death counts
SELECT location, Max(total_deaths) as max_death_count
FROM coviddeaths
WHERE continent is null
GROUP BY location
ORDER BY max_death_count DESC;

-- Global numbers
SELECT date, SUM(new_cases) num_cases, SUM(new_deaths) num_deaths, ROUND((SUM(new_deaths)/SUM(new_cases))*100, 2) AS percentage_death
FROM coviddeaths
WHERE continent is not null
GROUP BY date
ORDER BY date;

-- Looking at total population vs vaccinations
SELECT * 
FROM coviddeaths cd
JOIN covidvaccinations cv
ON cd.location = cv.location AND cd.date = cv.date
WHERE cd.continent is not null
ORDER BY cd.location, cd.date;

-- Vaccinations
-- count of people vaccinated on a given day
SELECT cd.continent, cd.location,  cd.date, cd.population, cv.new_vaccinations as vaccinated_count
FROM coviddeaths cd
JOIN covidvaccinations cv
ON cd.location = cv.location AND cd.date = cv.date
WHERE cd.continent is not null
ORDER BY cd.continent, cd.location, cd.date;

-- percentage of population vaccinated
With vac_count (continent, location, date, population, vaccinated_count, running_total_vaccinations) 
as(
SELECT cd.continent, cd.location,  cd.date, cd.population, cv.new_vaccinations as vaccinated_count, SUM(new_vaccinations) OVER (PARTITION BY cd.location ORDER BY cd.date) AS running_total_vaccinations
FROM coviddeaths cd
JOIN covidvaccinations cv
ON cd.location = cv.location AND cd.date = cv.date
WHERE cd.continent is not null
ORDER BY cd.continent, cd.location, cd.date)

SELECT *, (running_total_vaccinations/population)*100 as percentage_vaccinated
FROM vac_count;


-- Global vaccination count on a given day
SELECT cd.date, SUM(new_vaccinations) as vaccinated_count
FROM coviddeaths cd
JOIN covidvaccinations cv
ON cd.location = cv.location AND cd.date = cv.date
WHERE cd.continent is not null
GROUP BY cd.date
ORDER BY cd.date;


-- creating TEMP table to get overview of important numbers
DROP TABLE IF EXISTS full_details;
CREATE TEMPORARY TABLE full_details
(continent varchar(255), 
location varchar(255),
date datetime,
population float,
total_cases float,
total_deaths float,
vaccinated_count float,
running_total_vaccinations float);

INSERT INTO full_details (continent, 
location ,
date,
population,
total_cases,
total_deaths,
vaccinated_count,
running_total_vaccinations)
SELECT cd.continent, cd.location, cd.date, cd.population, cd.total_cases, cd.total_deaths, cv.new_vaccinations, SUM(new_vaccinations) OVER (PARTITION BY cd.location ORDER BY cd.date) AS running_total_vaccinations
FROM coviddeaths cd
JOIN covidvaccinations cv
ON cd.location = cv.location AND cd.date = cv.date
WHERE cd.continent is not null
ORDER BY cd.continent, cd.location, cd.date;

SELECT * ,round((total_cases/population)*100, 2) as percentage_infected, ROUND((total_deaths/total_cases)*100,2) AS percentage_death, (running_total_vaccinations/population)*100 as percentage_vaccinated
from full_details;

-- creating views to store data for later visualisation
CREATE VIEW population_vaccinated_percentage as
SELECT cd.continent, cd.location,  cd.date, cd.population, cv.new_vaccinations as vaccinated_count, SUM(new_vaccinations) OVER (PARTITION BY cd.location ORDER BY cd.date) AS running_total_vaccinations
FROM coviddeaths cd
JOIN covidvaccinations cv
ON cd.location = cv.location AND cd.date = cv.date
WHERE cd.continent is not null
ORDER BY cd.continent, cd.location, cd.date;

SELECT *
FROM population_vaccinated_percentage;


