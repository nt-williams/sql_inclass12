USE sakila;

# Question 1 - There are 200 actors in the database

SELECT COUNT(actor_id) AS number_actors
FROM actor; 

# Question 2 - The cutomers represent 376 distince districts

SELECT COUNT(DISTINCT(a.district)) AS number_districts
FROM customer AS c
	LEFT JOIN address AS a
    ON c.address_id = a.address_id;

# Question 3 - The customers represent 108 different countries

SELECT COUNT(DISTINCT(city.country_id)) AS number_country
FROM city AS city
	INNER JOIN address AS a
    ON city.city_id = a.city_id
		INNER JOIN customer as c
		ON a.address_id = c.address_id;

# Question 4 - Susan Davis appeared in the most films with 54 filmsreplacement_cost

SELECT first_name, last_name, MAX(number_films) AS number_films
FROM 
	(SELECT a.first_name, a.last_name, COUNT(f.film_id) AS number_films
	FROM actor AS a
		INNER JOIN film_actor AS f
		ON a.actor_id = f.actor_id
	GROUP BY a.first_name, a.last_name
    ORDER BY number_films DESC) AS d;
    
# Question 5 - Natalie Hopkins appeared in the most action films with 6 appearances

SELECT first_name, last_name, MAX(number_action) AS action_films
FROM 
	(SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS number_action
    FROM actor AS A
    INNER JOIN film_actor as fa
    ON a.actor_id = fa.actor_id 
		INNER JOIN film_category AS fc
        ON fa.film_id = fc.film_id
	WHERE fc.category_id = 1
    GROUP BY a.first_name, a.last_name
    ORDER BY number_action DESC) AS d;
    
# Question 6 - The music category of films has the smallest number of records recorded in the database with 51 records

SELECT name, MIN(number_records) AS number_records
FROM (
	SELECT c.name, COUNT(c.name) AS number_records 
    FROM category AS c 
	LEFT JOIN film_category AS f
		ON c.category_id = f.category_id
	GROUP BY c.name
	ORDER BY number_records
) AS d;

/* Question 7 - The movies with the longest runtime in the database are Chicago North, Control Anthem, Darn Forrester, Gangs Pride,
				Home Pity, Muscle Bright, Pond Seattle, Soldiers Evolution, Sweet Brotherhood, and Worst Banger; they all have a length
				of 185*/
                
SELECT title, length 
FROM film 
WHERE length = (
	SELECT MAX(length) AS length
    FROM film
);

# Question 8 - The average runtime of the categories can found running the qeury below... its too much to fully write them all out


SELECT d.name, AVG(f.length) AS avg_length
FROM film AS f
LEFT JOIN (
		SELECT fc.film_id, c.name
		FROM category AS c
		LEFT JOIN film_category AS fc
			ON c.category_id = fc.category_id
	) AS d 
    ON f.film_id = d.film_id
GROUP BY d.name;






































