-- 2.1 Counts by Sector
-- Query to display how many companies exist in each sector and how they are spread across key rating agencies.
SELECT DISTINCT Sector,
	COUNT(DISTINCT Corporation) AS "Corporation Count", 	
	COUNT(DISTINCT RatingAgency) AS "Rating Agencies Count"
FROM corp_rate AS cr
WHERE RatingAgency in ("Standard & Poor's Ratings Services", "Moody's Investors Service", "Fitch Ratings") AND
	RatingDate = (
    SELECT MAX(RatingDate)
    FROM Corp_rate AS sub_cr
    WHERE sub_cr.Corporation = cr.Corporation
      AND sub_cr.RatingAgency = cr.RatingAgency)
GROUP BY Sector 
ORDER BY COUNT(DISTINCT Corporation) DESC, Sector;