-- 4.1 Top Sectors
-- Query to display top sectors based on selected ratios criteria (above average)
SELECT DISTINCT 
	Sector, 
	SUM(COUNT(Corporation)) OVER (PARTITION BY Sector) AS "Corporation Count",
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
FROM corp_rate as cr
WHERE BinaryRating = 1 AND RatingAgency in ("Standard & Poor's Ratings Services", "Moody's Investors Service", "Fitch Ratings")
  AND RatingDate = (
    SELECT MAX(RatingDate)
    FROM Corp_rate AS sub_cr
    WHERE sub_cr.Corporation = cr.Corporation
      AND sub_cr.RatingAgency = "Standard & Poor's Ratings Services"
  )
 AND BinaryRating = 1
  AND (OperatingMargin > 13.33 AND EBITMargin > 13.44 AND EBITDAMargin > 21.17)
  AND (NetProfitMargin > 8.07 AND PreTaxProfitMargin > 11.12)
  AND (ROA_ReturnOnAssets > 5.87 AND ROI_ReturnOnInvestment > 9.60)
  AND LongTermDebt_Capital BETWEEN 0 AND 0.41
  AND FreeCashFlowPerShare > 0.37
GROUP BY Sector
ORDER BY "Corporation Count" DESC;