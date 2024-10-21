-- 1.3 Duplicated Records
-- Query to check for duplicated records and ensure that the dataset is clean and free from redundancy.
-- It displays the total of corporations included in the dataset ordered by their record count.
SELECT 
    Corporation, 
	Ticker,
	Sector,
	RatingDate,
	RatingAgency,
    SUM(COUNT(Corporation)) OVER (PARTITION BY Corporation) AS "Count of Total Records"
FROM Corp_rate as cr
GROUP BY Corporation
ORDER BY 
	"Count of Total Records" DESC, RatingDate DESC 
LIMIT 10;