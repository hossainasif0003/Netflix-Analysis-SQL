-- Find rows where director, cast, or release_year is missing (NULL)
SELECT * 
FROM netflix_titles 
WHERE director IS NULL 
   OR "cast" IS NULL 
   OR release_year IS NULL;

-- Select rows where director or cast is missing
SELECT * 
FROM netflix_titles 
WHERE director IS NULL 
   OR "cast" IS NULL;

-- Fill missing values in director, cast, country, and rating columns with "UNKNOWN" or "Unknown"
UPDATE netflix_titles
SET 
    director = "UNKNOWN",
    "cast" = "UNKNOWN",
    country = "Unknown",
    rating = "Unknown"
WHERE 
    director IS NULL
    OR "cast" IS NULL
    OR country IS NULL
    OR rating IS NULL;

-- Delete rows where release_year or duration is missing
DELETE FROM netflix_titles
WHERE release_year IS NULL OR duration IS NULL;

-- Verify the data after deleting rows
SELECT * FROM netflix_titles;

-- Add a column for minutes if not already present
ALTER TABLE netflix_titles
ADD COLUMN minutes INT;

-- Add a column for season if not already present
ALTER TABLE netflix_titles
ADD COLUMN season INT;

-- Update the minutes column based on the 'duration' column (if it contains 'min')
UPDATE netflix_titles
SET minutes = 
    CASE
        WHEN duration LIKE '%min%' THEN
            CAST(SUBSTRING(duration, 1, INSTR(duration, ' min') - 1) AS INT)
        ELSE NULL
    END;

-- Update the season column based on the 'duration' column (if it contains 'Season')
UPDATE netflix_titles
SET season = 
    CASE
        WHEN duration LIKE '%Season%' THEN
            CAST(SUBSTRING(duration, 1, INSTR(duration, ' Season') - 1) AS INT)
        ELSE NULL
    END;

-- Verify the result of the updates to duration, minutes, and season
SELECT duration, minutes, season
FROM netflix_titles;

-- Check the structure of the table to verify column names
PRAGMA table_info(netflix_titles);

-- Count the total number of movies in the dataset
SELECT COUNT(*) AS total_movies
FROM netflix_titles
WHERE type = "Movie";

-- Count the total number of TV Shows in the dataset
SELECT COUNT(*) AS total_TVShws
FROM netflix_titles
WHERE type = "TV Show";

-- Find the oldest and newest release years in the dataset
SELECT 
       MIN(release_year),
       MAX(release_year) 
FROM netflix_titles;

-- Find the top 10 countries with the highest title count
SELECT 
   country, 
   COUNT(title) AS total_title
FROM netflix_titles
GROUP BY country
ORDER BY total_title DESC
LIMIT 10;

-- Find the number of titles released each year
SELECT
    release_year,
    COUNT(title) AS title_count
FROM netflix_titles
GROUP BY release_year
ORDER BY title_count DESC;

-- Find the most common rating in the dataset
SELECT
    rating,
    COUNT(rating) AS frequency 
FROM netflix_titles
GROUP BY rating
ORDER BY frequency DESC
LIMIT 10;

-- Find the longest movie in terms of minutes
SELECT 
    title,
    minutes
FROM netflix_titles
WHERE type = "Movie"
ORDER BY minutes DESC
LIMIT 1;

-- Find the TV show with the most seasons
SELECT 
    title,
    season
FROM netflix_titles
WHERE type = "TV Show"
ORDER BY season DESC
LIMIT 1;

-- Find the top 10 most frequent actors in the dataset
SELECT 
    "cast" AS actor,
    COUNT("cast") AS Frequent
FROM netflix_titles 
GROUP BY actor
ORDER BY Frequent DESC
LIMIT 10;

-- Find the top 5 directors with the most titles in the dataset
SELECT 
    director,
    COUNT(title) AS title_count
FROM netflix_titles
GROUP BY director
ORDER BY title_count DESC
LIMIT 5;

-- Find the country that produces the most TV shows
SELECT 
    country,
    COUNT(type) AS total_TVShows
FROM netflix_titles
WHERE type = "TV Show"
GROUP BY country
ORDER BY total_TVShows DESC
LIMIT 5;

-- Find all movies released in the last 5 years (Updated for SQLite)
SELECT title, release_year 
FROM netflix_titles
WHERE type = 'movie' 
AND release_year >= strftime('%Y', 'now') - 5;

-- Find the movie with the highest rating (if you want the highest rated movie)
SELECT *
FROM netflix_titles
ORDER BY rating DESC
LIMIT 1;

-- Find the average duration for movies in the dataset
SELECT AVG(duration)
FROM netflix_titles
WHERE type = "Movie";

-- Find ratings and genres in the 'listed_in' column
SELECT 
    rating,
    listed_in
FROM netflix_titles
GROUP BY rating;

-- Find the genres of movies and TV shows with the most occurrences
SELECT 
    listed_in,
    rating,
    COUNT(listed_in) AS total_number
FROM netflix_titles
GROUP BY listed_in, rating
ORDER BY total_number DESC;
