/* Write an SQL query to display the correct message (meaningful message) from the input
comments_and_translation table. */

create table comments_and_translations
(
	id				int,
	comment			varchar(100),
	translation		varchar(100)
);
Using the Source and Target table, write a query to arrive at the Output table as shown in below image. Provide the solution without using subqueries.
insert into comments_and_translations values
(1, 'very good', null),
(2, 'good', null),
(3, 'bad', null),
(4, 'ordinary', null),
(5, 'cdcdcdcd', 'very bad'),
(6, 'excellent', null),
(7, 'ababab', 'not satisfied'),
(8, 'satisfied', null),
(9, 'aabbaabb', 'extraordinary'),
(10, 'ccddccbb', 'medium');
commit;


select coalesce(translation, comment ) as output
from comments_and_translations;

select case when translation is null 
	then comment 
	else translation
	END AS output
from comments_and_translations;

