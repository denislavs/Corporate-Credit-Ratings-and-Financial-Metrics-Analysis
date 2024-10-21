-- 2.3 Counts by Rating
-- Query to display the count of corporations, sectors, and rating agencies by rating
SELECT 
	BinaryRating AS "Binary Rating", 
	Rating, 
	COUNT(DISTINCT Corporation) AS "Corporation Count", 	
	COUNT(DISTINCT RatingAgency) AS "Rating Agencies Count", 
	COUNT(DISTINCT Sector) AS "Sector Count"
FROM Corp_rate AS cr
WHERE RatingAgency in ("Standard & Poor's Ratings Services", "Moody's Investors Service", "Fitch Ratings") AND
	RatingDate = (
    SELECT MAX(RatingDate)
    FROM Corp_rate AS sub_cr
    WHERE sub_cr.Corporation = cr.Corporation
      AND sub_cr.RatingAgency = cr.RatingAgency
	  AND RatingAgency in ("Standard & Poor's Ratings Services", "Moody's Investors Service", "Fitch Ratings")
)
GROUP BY Rating
ORDER BY CASE 
    WHEN Rating = 'AAA' THEN 1
    WHEN Rating = 'AA+' THEN 2
    WHEN Rating = 'AA' THEN 3
    WHEN Rating = 'AA-' THEN 4
    WHEN Rating = 'A+' THEN 5
	WHEN Rating = 'A' THEN 6
	WHEN Rating = 'A-' THEN 7
	WHEN Rating = 'BBB+' THEN 8
	WHEN Rating = 'BBB' THEN 9
	WHEN Rating = 'BBB-' THEN 10
	WHEN Rating = 'BB+' THEN 11
	WHEN Rating = 'BB' THEN 12
	WHEN Rating = 'BB-' THEN 13
	WHEN Rating = 'B+' THEN 14
	WHEN Rating = 'B' THEN 15
	WHEN Rating = 'B-' THEN 16
	WHEN Rating = 'CCC+' THEN 17
	WHEN Rating = 'CCC' THEN 18
	WHEN Rating = 'CCC-' THEN 19
	WHEN Rating = 'CC' THEN 20
	WHEN Rating = 'C' THEN 21
	ELSE 22
END, RatingAgency;