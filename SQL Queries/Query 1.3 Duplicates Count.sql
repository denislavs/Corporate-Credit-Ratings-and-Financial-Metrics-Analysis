-- 1.3 Duplicates Count
-- Query to show the total records count and the destinct records count. 
-- It eliminates duplicated corporation records using the latest date of rating.
SELECT 
    COUNT(Corporation) AS "Total Records", 
	(SELECT
		COUNT(DISTINCT Corporation)
	FROM Corp_rate as cr
	WHERE RatingDate = (
		SELECT MAX(RatingDate)
		FROM Corp_rate AS sub_cr
		WHERE sub_cr.Corporation = cr.Corporation
		  AND sub_cr.RatingAgency = cr.RatingAgency)) AS "Distinct Record Count",
	(COUNT(Corporation) - (SELECT
		COUNT(DISTINCT Corporation)
	FROM Corp_rate as cr
	WHERE RatingDate = (
		SELECT MAX(RatingDate)
		FROM Corp_rate AS sub_cr
		WHERE sub_cr.Corporation = cr.Corporation
		  AND sub_cr.RatingAgency = cr.RatingAgency))) AS Duplicates
FROM Corp_rate;