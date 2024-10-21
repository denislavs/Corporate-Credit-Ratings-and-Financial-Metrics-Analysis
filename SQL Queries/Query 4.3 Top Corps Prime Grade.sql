-- 4.3 Top Corps Prime Grade
-- Query to display top Investment Grade corporations based on selected ratios criteria (above average) 
SELECT Corporation, Ticker, Sector, RatingAgency, 
	CurrentRatio, LongTermDebt_Capital, Debt_EquityRatio, GrossMargin, OperatingMargin, EBITMargin, EBITDAMargin,
	PreTaxProfitMargin, NetProfitMargin, AssetTurnover, ROE_ReturnOnEquity, ReturnOnTangibleEquity, ROA_ReturnOnAssets,
	ROI_ReturnOnInvestment, OperatingCashFlowPerShare, FreeCashFlowPerShare
FROM Corp_rate AS cr
WHERE Rating = "AAA" 
	AND RatingAgency in ("Standard & Poor's Ratings Services", "Moody's Investors Service", "Fitch Ratings")
	AND RatingDate = (
    SELECT MAX(RatingDate)
    FROM Corp_rate AS sub_cr
    WHERE sub_cr.Corporation = cr.Corporation
      AND sub_cr.RatingAgency = "Standard & Poor's Ratings Services"
  )
  AND BinaryRating = 1
  AND (OperatingMargin > 13.33 AND EBITMargin > 13.44 AND EBITDAMargin > 21.17)
  AND (NetProfitMargin > 8.07 AND PreTaxProfitMargin > 11.12)
  AND ROA_ReturnOnAssets > 5.87 AND ROI_ReturnOnInvestment > 9.60
  AND LongTermDebt_Capital BETWEEN 0 AND 0.41
  AND FreeCashFlowPerShare > 0;