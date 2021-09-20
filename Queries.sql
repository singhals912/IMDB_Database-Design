#What are the average ratings for the  Movie 'Man of Gold'?

SELECT title.tconst, title.primaryTitle, title_ratings.averageRating 
FROM title 
INNER JOIN title_ratings 
ON title.tconst = title_ratings.tconst 
WHERE title.primaryTitle LIKE 'Man of Gold';

#What all genres are there?
SELECT DISTINCT genres From Genres;

# Which genre has the highest movie count and show genre distribution? 
SELECT g.genres, COUNT(DISTINCT t.tconst) as Movie_Count FROM Genres g
INNER JOIN title t 
ON t.tconst = g.tconst 
where t.titleType = 'movie' and g.genres not like  '%\N%'
GROUP BY genres
order by 2 desc;

# How many movies are made in each genre each year?
SELECT  title.startYear, Genres.genres,COUNT(DISTINCT title.tconst) as Count FROM title 
INNER JOIN Genres 
ON title.tconst = Genres.tconst 
Group By Genres.genres, title.startYear
order by 1,2;


#How do the average ages of leading actors and actresses compare in each genre?
select g.genres, P.category, avg(t.startyear-N.birthyear) as avg_age from Genres g 
inner join title t  on t.tconst = g.tconst #and  g.genres not like  '%\N%'
inner join title_principals P on g.tconst = P.tconst
inner join name_basics N on P.nconst = N.nconst 
where P.category in ('actor','actress') 
group by  g.genres, P.category
order  by 3 desc;


# What is a avg runtime for movies in each genre?
SELECT  Genres.genres,AVG(title.runtimeMinutes) as avg_runtime FROM title 
INNER JOIN Genres 
ON title.tconst = Genres.tconst 
GROUP BY Genres.genres
order by 2 desc;


# Find out the actor and actress name in each genre with highest avg rating
select a.genres,a.category,a.primaryname,max(a.avg_rating)
 from
(select g.genres, P.category,N.primaryName, avg(R.averageRating) as avg_rating
from Genres g 
inner join title_principals P on g.tconst = P.tconst
inner join name_basics N on P.nconst = N.nconst 
inner join title_ratings R on R.tconst = g.tconst
where P.category in ('actor','actress') 
group by  g.genres, P.category,N.primaryName) a
group by a.genres,a.category
order  by 1,2,4 desc;


# Find out the avg rating in each genre 
select g.genres, round(avg(t.averageRating),2) as avg_rating
 from Genres g 
inner join title_ratings t on t.tconst = g.tconst
group by  g.genres
order by 2 desc;

-- Find the name of all actors that acted in Blacksmith Scene:
SELECT t.primaryTitle as TitleName, N.primaryName as ActorName
FROM title t 
inner join title_principals P on t.tconst = P.tconst
inner join name_basics N on P.nconst = N.nconst 
WHERE t.primaryTitle LIKE 'Blacksmith Scene';



 -- Find No of remake for most popular movies
select count(*) as NumRemake,R.averagerating from title_ratings R inner join
title_alias A on A.titleID = R.tconst
where A.isOriginalTitle = 0
group by R.tconst order by R.averagerating desc



