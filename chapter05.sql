--Chapter 5 Ex 1
COPY popular_movies(id, movie, actor)
FROM 'popular_movies.txt'
WITH (FORMAT CSV, HEADER, DELIMITER ':');

--Chapter 5 ex 2
COPY
(
    SELECT county_name,
       state_name,
       births_2019
    FROM us_counties_pop_est_2019
    ORDER BY births_2019 DESC
    LIMIT 20
) TO '/data/us_counties_top_20_births_2019.csv'
WITH (FORMAT CSV, HEADER);

--Chapter 5 ex 3
--This would fail. According to the documentation, the first value is the total number of digits. The second digit is the number of decimal places.
--There are more digits on the right than on the left. It should be written the other way, numeric(8,3).
