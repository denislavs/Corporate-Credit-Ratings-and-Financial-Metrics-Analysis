-- 4.3 Top Corps Prime Grade - Ratings
-- Query to display top Prime Grade corporations ratings over time, based on selected ratios criteria (above average) 
SELECT Corporation, Ticker, Sector, Rating, RatingDate, RatingAgency, 
	CurrentRatio, LongTermDebt_Capital, Debt_EquityRatio, GrossMargin, OperatingMargin, EBITMargin, EBITDAMargin,
	PreTaxProfitMargin, NetProfitMargin, AssetTurnover, ROE_ReturnOnEquity, ReturnOnTangibleEquity, ROA_ReturnOnAssets,
	ROI_ReturnOnInvestment, OperatingCashFlowPerShare, FreeCashFlowPerShare
FROM Corp_rate AS cr
WHERE RatingAgency IN ("Standard & Poor's Ratings Services", "Moody's Investors Service", "Fitch Ratings")
  AND Corporation IN ("Johnson & Johnson", "Intel Corp.", "Microsoft Corp.") 
GROUP BY Corporation, Rating, RatingDate, Rating
ORDER BY Corporation, RatingDate;