-- 2.2 Counts by Rating Agency
-- Query summarize the number of distinct corporations and sectors per rating agency.
-- Provides insight into the coverage and diversity of the dataset.
SELECT 
	RatingAgency AS "Rating Agency", 
	COUNT(DISTINCT Corporation) AS "Corporation Count",
	COUNT(DISTINCT Sector) AS "Sector Count"
FROM Corp_rate AS cr
WHERE RatingDate = (
    SELECT MAX(RatingDate)
    FROM Corp_rate AS sub_cr
    WHERE sub_cr.Corporation = cr.Corporation
      AND sub_cr.RatingAgency = cr.RatingAgency
)
GROUP BY RatingAgency
ORDER BY RatingAgency;