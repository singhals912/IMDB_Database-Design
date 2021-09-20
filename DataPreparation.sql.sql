-- Creating a table KnownTitles for normalization of knownForTitles table
CREATE TABLE singha22.KnownTitles (
    nconst text,
    knownForTitles text
);

insert into singha22.KnownTitles
SELECT
  singha22.name_basics.nconst,
  SUBSTRING_INDEX(SUBSTRING_INDEX(singha22.name_basics.knownfortitles, ',', numbers.n), ',', -1) name    
FROM
  (SELECT 1 n UNION ALL SELECT 2
   UNION ALL SELECT 3 UNION ALL SELECT 4) numbers INNER JOIN singha22.name_basics
  ON CHAR_LENGTH(singha22.name_basics.knownfortitles)
     -CHAR_LENGTH(REPLACE(singha22.name_basics.knownfortitles, ',', ''))>=numbers.n-1;

-- dropping  the multivalued column from name table 
alter table singha22.name_basics
drop column knownForTitles;

-- dropping  the NULL values in knownForTitles column
DELETE FROM singha22.KnownTitles
WHERE
    KnownTitles.knownForTitles like '%\N%';
    
    
/*creating primaryprofession table*/
CREATE TABLE singha22.primaryprofession (
    nconst text,
    PrimaryProfession text
);    
    
/*Normalization for primaryprofession */
insert into singha22.primaryprofession
SELECT
  singha22.name_basics.nconst,
  SUBSTRING_INDEX(SUBSTRING_INDEX(singha22.name_basics.primaryprofession, ',', numbers.n), ',', -1) name  
FROM
  (SELECT 1 n UNION ALL SELECT 2
   UNION ALL SELECT 3 UNION ALL SELECT 4) numbers INNER JOIN singha22.name_basics
  ON CHAR_LENGTH(singha22.name_basics.primaryprofession)
     -CHAR_LENGTH(REPLACE(singha22.name_basics.primaryprofession, ',', ''))>=numbers.n-1;

-- dropping  primaryprofession column from name_basics
alter table singha22.name_basics
drop column primaryprofession;


/*creating Genres table*/
CREATE TABLE singha22.Genres (
    tconst text,
    genres text
);

/*Normalization for Genres */

insert into singha22.Genres
SELECT
  singha22.title.tconst,
  SUBSTRING_INDEX(SUBSTRING_INDEX(singha22.title.genres, ',', numbers.n), ',', -1) name  
FROM
  (SELECT 1 n UNION ALL SELECT 2
   UNION ALL SELECT 3 UNION ALL SELECT 4) numbers INNER JOIN singha22.title
  ON CHAR_LENGTH(singha22.title.genres)
     -CHAR_LENGTH(REPLACE(singha22.title.genres, ',', ''))>=numbers.n-1;
     
     
-- dropping  genres column from title
alter table singha22.title
drop column genres;



select * from title_ratings
select * from title_alias




 
 
 

