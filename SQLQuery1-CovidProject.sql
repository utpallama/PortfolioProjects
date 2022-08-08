
Select *
From PortfolioProject..CovidDeaths
order by 3,4

--Select *
--From PortfolioProject..CovidVaccinations
--order by 3,4

--Selecting data that I will be using

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2

-- Finding Total Cases vs Population.
--Answer for United kingdom = As of 5th August 2022, 34.86% of the people in UK has gotten covid.
Select Location, date, population, total_cases, (total_cases/population)*100 as PopulationInfectedPercentage
From PortfolioProject..CovidDeaths
Where location like '%United Kingdom%'
order by 1,2


--Finding Total Cases vs Total deaths. What was the % death rate per cases?
--Answer for United kingdom = As of 5th August 2022, we have 0.80% chance of dying if you were contracted with Covid.
Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%United Kingdom%'
order by 1,2


-- Looking at countries with the highest Infection Rate when compared to Population.
Select Location, population, MAX(total_cases) as HighestTotalCases,  Max((total_cases/population))*100 as PopulationInfectedPercentage
From PortfolioProject..CovidDeaths
Group by Location, population
order by PopulationInfectedPercentage desc


-- Looking at countries with the highest Death Count per Population. Group by is used here as were using aggregate function eg. MAX
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc
 

-- Looking at continents highest death count per population 
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc


-- GLOBAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
where continent is not null 
--Group By date
order by 1,2


-- Find the Total amount of people(population) that have been vaccinated(Vaccination)
Select death.continent, death.location, death.date, death.population, vaccination.new_vaccinations
From PortfolioProject..CovidDeaths death
Join PortfolioProject..CovidVaccinations vaccination
	On death.location = vaccination.location
	and death.date = vaccination.date
where death.continent is not null 
order by 1,2,3
