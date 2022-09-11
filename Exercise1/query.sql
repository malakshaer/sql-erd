-- Find the Best-Picture winner with the best/smallest earnings rank. The
-- result should have the form (name, earnings_rank). Assume no two movies
-- have the same earnings rank.

SELECT M.name,MIN(earnings_rank)
FROM movies AS M,oscars AS O
WHERE O.type = "Best Picture"