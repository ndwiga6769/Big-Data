
DROP TABLE IF EXISTS OLYMPICS_HISTORY;
CREATE TABLE IF NOT EXISTS OLYMPICS_HISTORY
(
    id          INT,
    name        VARCHAR,
    sex         VARCHAR,
    age         VARCHAR,
    height      VARCHAR,
    weight      VARCHAR,
    team        VARCHAR,
    noc         VARCHAR,
    games       VARCHAR,
    year        INT,
    season      VARCHAR,
    city        VARCHAR,
    sport       VARCHAR,
    event       VARCHAR,
    medal       VARCHAR
);

DROP TABLE IF EXISTS OLYMPICS_HISTORY_NOC_REGIONS;
CREATE TABLE IF NOT EXISTS OLYMPICS_HISTORY_NOC_REGIONS
(
    noc         VARCHAR,
    region      VARCHAR,
    notes       VARCHAR
);

select * from OLYMPICS_HISTORY;
select * from OLYMPICS_HISTORY_NOC_REGIONS;


select 
	count(distinct games)
	from OLYMPICS_HISTORY;
2
select distinct oh.year,oh.season,oh.city
    from olympics_history oh
    order by year;

3-- Mention the total no of nations who participated in
--each olympics game
select 
	distinct(games),count( distinct team)
	from OLYMPICS_HISTORY
	group by 1;

 with all_countries as
        (select games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region)
    select games, count(1) as total_countries
    from all_countries
    group by games
    order by games;
4 --Which year saw the highest and lowest no of countries
-- participating in olympics

with countries as
		(
		select OH.games, OHR.region
		from OLYMPICS_HISTORY OH
		JOIN OLYMPICS_HISTORY_NOC_REGIONS OHR
		ON OH.noc = OHR.noc
		group by 1,2
		),
counter as 
	(
		select games,count(1) as total_countries
		from countries
		group by games
	)
select distinct
concat(first_value(games) over(order by total_countries), '-',first_value(games) over(order by total_countries)) as lowest_countries,
concat(first_value(games) over(order by total_countries desc), '-',first_value(total_countries) over(order by total_countries desc)) as highest_countries
from counter
order by 1;

-- Query 5 Which nation has participated in all of the olympic games
with tot_games as 
	(
	select count(distinct games) as total_games
	from olympics_history
	),
countries as 
	(
	select oh.games,ohr.region as country
	from OLYMPICS_HISTORY oh
	JOIN OLYMPICS_HISTORY_NOC_REGIONS ohr
	ON ohr.noc = oh.noc 
	group by 1,2
	),
countries_participated as
	(
	select country, count(1) as total_participated_games
	from countries
	group by country
	)
select cp.*
from countries_participated cp
join tot_games tg on tg.total_games = cp.total_participated_games
order by 1;

Q6 --identify the sport that was played in all summer olympics
--find the total number of summer olympic games
--find for each sport how many games were they played in
compare  1 and 2

select * from OLYMPICS_HISTORY
select * from OLYMPICS_HISTORY_NOC_REGIONS
	
with t1 as (
	select count(distinct games) as total_summer_games
	from OLYMPICS_HISTORY
	where season = 'Summer'
	),
	t2 as
	(
	select distinct sport, games
	from OLYMPICS_HISTORY
	where season = 'Summer'
	order by games
	),
	t3 as 
	(
	select sport,count(games) as no_of_games
	from t2
	group by sport
	)
select *
from t3
join t1 on t1.total_summer_games = t3.no_of_games

Q11-- fetch the top 5 athletes that have won the most gold medals
with t1 as (
		select name, count(1) as medal_count
		from OLYMPICS_HISTORY
		where medal = 'Gold'
		group by name
		order by count(1) desc
			)
	select name,medal_count,
		rank() over(order by medal_count desc)
		from t1

-- select country and the count of different medals they won
select ohr.region as country,medal,count(1) as total_medals
from OLYMPICS_HISTORY oh
join OLYMPICS_HISTORY_NOC_REGIONS ohr on oh.noc = ohr.noc
where medal <> 'NA'
group by 1,2
order by 1,2;

--create extension tablefunc;
select position(' - ' in '1896 Summer - Australia')
select substring('1896 Summer - Australia',1,11)



Q16	-- write an sql query to display for each olympic games, 
-- which country won the highest gold, silver and bronze medals
	with temp as (
select substring(games_country, 1,position (' - 'in games_country)- 1) as games,
	substring(games_country, position (' - ' in games_country)+ 3) as country
	,
	coalesce(gold, 0) as gold,
	coalesce(silver, 0) as silver,
	coalesce(bronze, 0) as bronze
	from crosstab(
			'select concat(games, '' - '', ohr.region) as games_country,medal,count(1) as total_medals
			from OLYMPICS_HISTORY oh
			join OLYMPICS_HISTORY_NOC_REGIONS ohr on oh.noc = ohr.noc
			where medal <> ''NA''
			group by 1,2
			order by 1,2','values(''Bronze''),(''Gold''),(''Silver'')'
 			)
as result(games_country varchar, bronze bigint, gold bigint, silver bigint)
order by games_country
)

	select distinct games,
	concat(first_value(country) over(partition by games order by gold desc), ' - ', first_value(gold) over(partition by games order by gold desc)) as gold,
	concat(first_value(country) over(partition by games order by silver desc), ' - ', first_value(silver) over(partition by games order by silver desc)) as silver,
	concat(first_value(country) over(partition by games order by bronze desc), ' - ', first_value(bronze) over(partition by games order by bronze desc)) as bronze
	from temp
	order by games;
