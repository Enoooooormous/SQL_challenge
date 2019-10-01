CREATE TABLE public."people"(Person_id integer, name character varying(30), Recruited_by integer);

INSERT INTO people (Person_id, Name, Recruited_by)
VALUES
   (1, 'Jean Grayson', Null),
   (2, 'Paul Smith', 7),
   (3, 'John Do',	Null),
   (4,	'Alex Lee',	7),
   (5,	'Lisa Kim',	7),
   (6,	'Bob Thompson',	3),
   (7,	'Mike Keen',	Null),
   (8,	'Raymond Red',	3),
   (9,	'Alisson Jones',	1),
   (10,	'Kate James',	3);

-- Question 7

SELECT 
	a.Name as Recruitee,
	b.Name as Recruiter
FROM people as a 
LEFT JOIN people as b 
ON a.Recruited_by=b.Person_id;



-- Question 8

UPDATE people 
	SET Recruited_by = 1
	WHERE Person_id = 1;

-- first part of the question

WITH staging as (
	SELECT 
		a.Name as Recruitee,
		b.Name as Recruiter
	FROM people as a 
	LEFT JOIN people as b 
	ON a.Recruited_by=b.Person_id
	)

SELECT 
	Recruiter
FROM staging
GROUP BY Recruiter
HAVING COUNT(Recruiter) > 3;

-- second part of the question

SELECT 
	COUNT(*) as nbr_not_hired_by_recruiter 
FROM people 
WHERE coalesce(recruited_by,9)=9;



-- Question 9
DROP TABLE IF EXISTS people;

CREATE TABLE public."people"(Person_id integer, Name character varying(30), Company_id integer);

INSERT INTO people (Person_id, Name, Company_id)
VALUES
   	(1,	'Jean Grayson',	2),
	(2,	'Paul Smith',	7),
	(3,	'John Do',	1),
	(4,	'Alex Lee',	7),
	(5,	'Lisa Kim',	7),
	(6,	'Bob Thompson',	3),
	(7,	'Mike Keen',	1),
	(8,	'Raymond Red',	3),
	(9,	'Alisson Jones',	1),
	(10,	'Kate James',	3),
	(11,	'Lisa Kim',	7),
	(12,	'Bob Thompson',	3),
	(13,	'Alex Lee',	7),
	(14,	'Lisa Kim',	7),
	(15,	'Bob Thompson',	3),
	(16,	'Mike Keen',	1),
	(17,	'Raymond Red',	3),
	(18,	'Mike Keen',	1),
	(19,	'Raymond Red',	3)
;

WITH duplicates as (
	SELECT 
		Name, 
		Company_id, 
		COUNT(*) as duplicate_count
	FROM people2
	GROUP BY Name, Company_id
	HAVING COUNT(*) > 1
	)

SELECT 
	company_id
FROM duplicates
GROUP BY company_id
ORDER BY SUM(duplicate_count) DESC
LIMIT 2;