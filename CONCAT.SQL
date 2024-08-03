-- Each company in the accounts table wants to create an email 
-- address for each primary_poc. The email address should be the 
-- first name of the primary_poc . last name primary_poc @ company name .com.

SELECT 
    LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) AS First_name,
    RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS Second_Name,
    name,
    LOWER (CONCAT(LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1), '.', 
           RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')), 
           '@', name, '.com')) AS email
                 
FROM 
    accounts;
