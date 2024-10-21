-- 3.3 Ratios Mean by Speculative Grade
-- Query to calculate ratios mean by Speculative Grade (Binary Rating = 0)
SELECT 
    CASE
        WHEN Rating IN ('BB+', 'BB', 'BB-') THEN 'Speculative'
        WHEN Rating IN ('B+', 'B', 'B-') THEN 'Highly Speculative'
        WHEN Rating IN ('CCC+', 'CCC', 'CCC-', 'CC', 'C') THEN 'Substantial Risk'
		WHEN Rating IN ('D') THEN 'In default'
        ELSE 'Other'
    END AS "Speculative Grade",
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
WHERE RatingAgency IN ("Standard & Poor's Ratings Services", "Moody's Investors Service", "Fitch Ratings")
  AND RatingDate = (
      SELECT MAX(RatingDate)
      FROM Corp_rate AS sub_cr
      WHERE sub_cr.Corporation = cr.Corporation
        AND sub_cr.RatingAgency = cr.RatingAgency
  )
  AND BinaryRating = 0
GROUP BY "Speculative Grade"
ORDER BY 
    CASE
        WHEN "Speculative Grade" = 'Speculative' THEN 1
        WHEN "Speculative Grade" = 'Highly Speculative' THEN 2
        WHEN "Speculative Grade" = 'Substantial Risk' THEN 3
        WHEN "Speculative Grade" = 'In default' THEN 4
        ELSE 5
    END;