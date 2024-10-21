-- QUERY 1.1 Data Overview

-- Query to quickly understand the structure of the dataset and its basic contents by inspecting the first 10 rows.
SELECT *
FROM Corp_rate
LIMIT 10


-- QUERY 1.2 Missing Values

-- Query to identify any missing data and determine if certain columns or rows need attention before deeper analysis.
SELECT 
    SUM(CASE WHEN RatingAgency IS NULL THEN 1 ELSE 0 END) AS RatingAgency,
    SUM(CASE WHEN Corporation IS NULL THEN 1 ELSE 0 END) AS Corporation,
    SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS Rating,
    SUM(CASE WHEN RatingDate IS NULL THEN 1 ELSE 0 END) AS RatingDate,
    SUM(CASE WHEN CIK IS NULL THEN 1 ELSE 0 END) AS CIK,
    SUM(CASE WHEN BinaryRating IS NULL THEN 1 ELSE 0 END) AS BinaryRating,
    SUM(CASE WHEN SICCode IS NULL THEN 1 ELSE 0 END) AS SICCode,
    SUM(CASE WHEN Sector IS NULL THEN 1 ELSE 0 END) AS Sector,
    SUM(CASE WHEN Ticker IS NULL THEN 1 ELSE 0 END) AS Ticker,
    SUM(CASE WHEN CurrentRatio IS NULL THEN 1 ELSE 0 END) AS CurrentRatio,
    SUM(CASE WHEN LongTermDebt_Capital IS NULL THEN 1 ELSE 0 END) AS LongTermDebt_Capital,
    SUM(CASE WHEN Debt_EquityRatio IS NULL THEN 1 ELSE 0 END) AS Debt_EquityRatio,
    SUM(CASE WHEN GrossMargin IS NULL THEN 1 ELSE 0 END) AS GrossMargin,
    SUM(CASE WHEN OperatingMargin IS NULL THEN 1 ELSE 0 END) AS OperatingMargin,
    SUM(CASE WHEN EBITMargin IS NULL THEN 1 ELSE 0 END) AS EBITMargin,
    SUM(CASE WHEN EBITDAMargin IS NULL THEN 1 ELSE 0 END) AS EBITDAMargin,
    SUM(CASE WHEN PreTaxProfitMargin IS NULL THEN 1 ELSE 0 END) AS PreTaxProfitMargin,
    SUM(CASE WHEN NetProfitMargin IS NULL THEN 1 ELSE 0 END) AS NetProfitMargin,
    SUM(CASE WHEN AssetTurnover IS NULL THEN 1 ELSE 0 END) AS AssetTurnover,
    SUM(CASE WHEN ROE_ReturnOnEquity IS NULL THEN 1 ELSE 0 END) AS ROE_ReturnOnEquity,
    SUM(CASE WHEN ReturnOnTangibleEquity IS NULL THEN 1 ELSE 0 END) AS ReturnOnTangibleEquity,
    SUM(CASE WHEN ROA_ReturnOnAssets IS NULL THEN 1 ELSE 0 END) AS ROA_ReturnOnAssets,
    SUM(CASE WHEN ROI_ReturnOnInvestment IS NULL THEN 1 ELSE 0 END) AS ROI_ReturnOnInvestment,
    SUM(CASE WHEN OperatingCashFlowPerShare IS NULL THEN 1 ELSE 0 END) AS OperatingCashFlowPerShare,
    SUM(CASE WHEN FreeCashFlowPerShare IS NULL THEN 1 ELSE 0 END) AS FreeCashFlowPerShare
FROM Corp_rate;