create database portofolio;

use portofolio;

select * from coviddeaths ;

select Distinct location from covidvaccinations where date = "1/1/2021" ;

select * from coviddeaths order by 3,4  ;

/*select data that we are gonna using */

select location, date, total_cases,new_cases,total_deaths,population from coviddeaths order by 1,2;

/* looking at total death vs total cases in every country*/

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage from coviddeaths
order by str_to_date(date,'%m-%d-%y') ;

/* looking at total cases vs population in every country*/
select location, date, total_cases, population, (total_cases/population)*100 as populationinfectedinpercent from coviddeaths
where location = "indonesia" order by 1,str_to_date(date,'%m-%d-%y') ;

select location, date, total_cases, population, (total_cases/population)*100 as populationinfectedinpercent from coviddeaths
order by 1,str_to_date(date,'%m-%d-%y') ;

/* looking at countries with highest infection rate compared to population  */

select location, date,population, max(total_cases ) as highestinfectioncount,  max((total_cases/population))*100 as populationinfectedinpercent from coviddeaths
group by location, population
order by populationinfectedinpercent desc ;

/* showing countries with highest death count per population*/

select location, population, max(cast(total_deaths as int)) as totaldeathcount from coviddeaths
where continent !=""
group by location
order by totaldeathcount desc;

select distinct location from coviddeaths where continent =''  ;
select * from coviddeaths;

-- total cases around the world
-- cases that happen everyday in the world
select date, sum(total_deaths),sum(total_cases) from coviddeaths
where continent != ""
group by date
order by str_to_date(date,'%m,%d,%y');

-- total cases and total death around the world

select sum(total_cases)as total_cases, sum(cast(total_deaths as int)) as total_death, sum(cast(total_deaths as int))/sum(total_cases)*100 as deathpercentage
from coviddeaths
where continent !="";

-- looking at total population vs vaccinations

select *
from covidvaccinations order by 3,4;

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) over ( partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3;