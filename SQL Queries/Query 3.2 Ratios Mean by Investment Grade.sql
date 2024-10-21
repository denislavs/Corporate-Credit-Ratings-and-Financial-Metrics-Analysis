-- 3.2 Ratios Mean by Investment Grade
-- Query to calculate ratios mean by Investment Grade (Binary Rating = 1)
SELECT 
    CASE
        WHEN Rating = 'AAA' THEN 'Prime'
        WHEN Rating IN ('AA+', 'AA', 'AA-') THEN 'High'
        WHEN Rating IN ('A+', 'A', 'A-') THEN 'Upper Medium'
        WHEN Rating IN ('BBB+', 'BBB', 'BBB-') THEN 'Lower Medium'
        ELSE 'Other'
    END AS "Investment Grade",
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
  AND BinaryRating = 1
GROUP BY "Investment Grade"
ORDER BY 
    CASE
        WHEN "Investment Grade" = 'Prime' THEN 1
        WHEN "Investment Grade" = 'High' THEN 2
        WHEN "Investment Grade" = 'Upper Medium' THEN 3
        WHEN "Investment Grade" = 'Lower Medium' THEN 4
        ELSE 5
    END;