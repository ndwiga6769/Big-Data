
CREATE TABLE source
    (
        id      int,
        name    varchar(1)
    );

CREATE TABLE target
    (
        id      int,
        name    varchar(1)
    );
INSERT INTO source VALUES (1, 'A');
INSERT INTO source VALUES (2, 'B');
INSERT INTO source VALUES (3, 'C');
INSERT INTO source VALUES (4, 'D');

INSERT INTO target VALUES (1, 'A');
INSERT INTO target VALUES (2, 'B');
INSERT INTO target VALUES (4, 'X');
INSERT INTO target VALUES (5, 'F');


select s.id, 'Mismatch' as Comment	
from source s
join target t 
ON t.id = s.id and s.name <> t.name
union 
select s.id, 'New in source' as Comment
from source s
left join target t on t.id = s.id
where t.id is null
union
select t.id, 'New in target' as Comment
from source s
right join target t on t.id = s.id
where s.id is null;