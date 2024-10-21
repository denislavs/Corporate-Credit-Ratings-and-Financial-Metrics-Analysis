-- 3.1 Ratios Mean by BinRating
-- Query to calculate ratios mean by binary rating (Investment vs Speculative grade)
SELECT 
	BinaryRating AS "Binary Rating",
	AVG(CurrentRatio) AS "AVG CurrentRatio",
    AVG(LongTermDebt_Capital) AS "AVG LongTermDebt_Capital",
    AVG(Debt_EquityRatio) AS "AVG Debt_EquityRatio",
    AVG(GrossMargin) AS "AVG GrossMargin",
    AVG(OperatingMargin) AS "AVG OperatingMargin",
    AVG(EBITMargin) AS "AVG EBITMargin",
    AVG(EBITDAMargin) AS "AVG EBITDAMargin",
    AVG(PreTaxProfitMargin) AS "AVG PreTaxProfitMargin",
    AVG(NetProfitMargin) AS "AVG NetProfitMargin",
    AVG(AssetTurnover) AS "AVG AssetTurnover",
    AVG(ROE_ReturnOnEquity) AS "AVG ROE_ReturnOnEquity",
    AVG(ReturnOnTangibleEquity) AS "AVG ReturnOnTangibleEquity",
    AVG(ROA_ReturnOnAssets) AS "AVG ROA_ReturnOnAssets",
    AVG(ROI_ReturnOnInvestment) AS "AVG ROI_ReturnOnInvestment",
    AVG(OperatingCashFlowPerShare) AS "AVG OperatingCashFlowPerShare",
    AVG(FreeCashFlowPerShare) AS "AVG FreeCashFlowPerShare"
FROM corp_rate AS cr
WHERE RatingAgency in ("Standard & Poor's Ratings Services", "Moody's Investors Service", "Fitch Ratings") AND
	RatingDate = (
    SELECT MAX(RatingDate)
    FROM Corp_rate AS sub_cr
    WHERE sub_cr.Corporation = cr.Corporation
      AND sub_cr.RatingAgency = cr.RatingAgency)
GROUP BY BinaryRating
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
END;