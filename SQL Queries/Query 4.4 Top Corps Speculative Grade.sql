-- 4.4 Top Corps Speculative Grade
-- Query to display top Speculative Grade corporations based on selected ratios criteria (above average) 
SELECT Corporation, Ticker, Sector, 
	CASE
        WHEN Rating IN ('BB+', 'BB', 'BB-') THEN 'Speculative'
        WHEN Rating IN ('B+', 'B', 'B-') THEN 'Highly Speculative'
        WHEN Rating IN ('CCC+', 'CCC', 'CCC-', 'CC', 'C') THEN 'Substantial Risk'
		WHEN Rating IN ('D') THEN 'In default'
        ELSE 'Other'
    END AS "Speculative Grade", RatingAgency, 
	CurrentRatio, LongTermDebt_Capital, Debt_EquityRatio, GrossMargin, OperatingMargin, EBITMargin, EBITDAMargin,
	PreTaxProfitMargin, NetProfitMargin, AssetTurnover, ROE_ReturnOnEquity, ReturnOnTangibleEquity, ROA_ReturnOnAssets,
	ROI_ReturnOnInvestment, OperatingCashFlowPerShare, FreeCashFlowPerShare
FROM Corp_rate AS cr
WHERE RatingAgency in ("Standard & Poor's Ratings Services", "Moody's Investors Service", "Fitch Ratings")
  AND RatingDate = (
    SELECT MAX(RatingDate)
    FROM Corp_rate AS sub_cr
    WHERE sub_cr.Corporation = cr.Corporation
      AND sub_cr.RatingAgency = "Standard & Poor's Ratings Services"
  )
  AND BinaryRating = 0
  AND (OperatingMargin > 7.87 OR EBITMargin > 7.89 OR EBITDAMargin > 16.99)
  AND (NetProfitMargin > 1.84 OR PreTaxProfitMargin > 3.08)
  AND (ROA_ReturnOnAssets > 3.27 OR ROI_ReturnOnInvestment BETWEEN 5.37 AND 15)
  AND LongTermDebt_Capital BETWEEN 0 and 0.51
  AND OperatingCashFlowPerShare BETWEEN 0.12 and 0.31
ORDER BY 
    CASE
        WHEN "Speculative Grade" = 'Speculative' THEN 1
        WHEN "Speculative Grade" = 'Highly Speculative' THEN 2
        WHEN "Speculative Grade" = 'Substantial Risk' THEN 3
        WHEN "Speculative Grade" = 'In default' THEN 4
        ELSE 5
    END;