-- SELECT 
--     TABLE_NAME,
--     COLUMN_NAME
-- FROM 
--     INFORMATION_SCHEMA.COLUMNS
-- ORDER BY 
--     TABLE_NAME;

-- SELECT primaryName, birthYear
-- FROM tArtist
-- WHERE primaryName = 'Jude Law';

-- SELECT COUNT(*) AS Artist_Count FROM tArtist;

-- SELECT primaryName
-- FROM tArtist
-- WHERE birthYear = 1960;

-- SELECT COUNT(*) AS Artists_1960
-- FROM tArtist
-- WHERE birthYear = 1960;

-- SELECT TOP 1 birthYear, COUNT(primaryName) as nb_artists
-- FROM tArtist
-- GROUP BY birthYear
-- HAVING NOT birthYear = 0
-- ORDER BY nb_artists DESC;


-- SELECT tArtist.idArtist, primaryName, nbMovies
-- FROM tArtist JOIN
-- (SELECT idArtist, COUNT(*) as nbMovies
-- FROM tJob
-- WHERE category = 'acted in'
-- GROUP BY idArtist
-- HAVING COUNT(*) > 1) AS movies
-- ON (tArtist.idArtist = movies.idArtist);

-- SELECT tArtist.idArtist, primaryName, nbRoles
-- FROM tArtist JOIN
-- (SELECT idArtist, COUNT(DISTINCT category) as nbRoles
-- FROM tJob
-- GROUP BY idArtist
-- HAVING COUNT(DISTINCT category) > 1) as roles
-- ON (tArtist.idArtist = roles.idArtist);

-- SELECT idFilm, COUNT(DISTINCT idArtist) as nbArtists
-- FROM tJob
-- WHERE category = 'acted in'
-- GROUP BY idFilm
-- ORDER BY nbArtists DESC;

-- SELECT idFilm, COUNT(DISTINCT idArtist) as nbArtists
-- FROM tJob
-- WHERE category = 'acted in'
-- GROUP BY idFilm
-- HAVING COUNT(DISTINCT idArtist) = (
--     SELECT MAX(nbArtists)
--     FROM (
--         SELECT COUNT(DISTINCT idArtist) AS nbArtists
--         FROM tJob
--         WHERE category = 'acted in'
--         GROUP BY idFilm
--     ) AS Subquery
-- );

SELECT 
    tArtist.primaryName AS ArtistName,
    tFilm.idFilm,
    COUNT(DISTINCT tJob.category) AS RoleCount
FROM 
    tJob
JOIN 
    tArtist ON tJob.idArtist = tArtist.idArtist
JOIN 
    tFilm ON tJob.idFilm = tFilm.idFilm
GROUP BY 
    tArtist.primaryName, tFilm.idFilm
HAVING 
    COUNT(DISTINCT tJob.category) > 1;