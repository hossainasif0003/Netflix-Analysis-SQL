
# Netflix Data Analysis

## What is this?

This project helps clean up and analyze Netflix data. It fixes missing information, like the director or cast, and helps you see some useful stats, like how many movies or TV shows there are.

## What does it do?

- **Fixes missing data:** Fills in empty spots with "UNKNOWN" or `0`.
- **Cleans up data:** Removes rows that are incomplete.
- **Shows useful info:** Counts the number of movies and TV shows, finds the longest movie, and more.

## How to use it

1. **Set up your database:** 
   - Put the `netflix_titles` dataset in your SQLite database.

2. **Run the SQL queries:** 
   - Open `netflix_simple_data_analysis.sql` and run the queries.

3. **Check the results:** 
   - After running the queries, you can see the cleaned data or view the results of the analysis.

## Example Queries

### 1. Fix missing data:

This will fill in missing information for `director`, `cast`, and other columns:

```sql
UPDATE netflix_titles
SET director = "UNKNOWN", "cast" = "UNKNOWN", country = "Unknown", rating = "Unknown"
WHERE director IS NULL OR "cast" IS NULL OR country IS NULL OR rating IS NULL;
```

### 2. Count movies:

This will count how many movies are in the dataset:

```sql
SELECT COUNT(*) AS total_movies
FROM netflix_titles
WHERE type = "Movie";
```

### 3. Find the longest movie:

This will give you the movie with the longest duration:

```sql
SELECT title, minutes
FROM netflix_titles
WHERE type = "Movie"
ORDER BY minutes DESC
LIMIT 1;
```

## License

Feel free to use and modify this project!
