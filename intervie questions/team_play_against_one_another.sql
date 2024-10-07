--- Q6 : IPL Matches --- 

drop table teams;
create table teams
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');

with cte as (
select
	row_number() over(order by team_name) as rnk,t.*
	from teams t )
select t1.team_code,t2.team_name
from cte t1
join cte t2
on t1.rnk < t2.rnk
order by t1;


with cte as (
select
	row_number() over(order by team_name) as rnk,t.*
	from teams t )
select t1.team_code,t2.team_name
from cte t1
join cte t2
on t1.rnk <> t2.rnk
order by t1;