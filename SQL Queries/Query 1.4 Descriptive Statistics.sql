-- 1.4 Descriptive Statistics
-- Query to calculate basic descriptive statistics (count, mean, min, quartiles,  median, and max) for each financial ratio.
-- Outliers may be inferred based on extreme values (min/max) in comparison to the mean.
WITH OrderedRatios AS (
    SELECT 
        CurrentRatio,
		LongTermDebt_Capital,
		Debt_EquityRatio,
        GrossMargin,
        OperatingMargin,
		EBITMargin,
		EBITDAMargin,
		PreTaxProfitMargin,
		NetProfitMargin,
		AssetTurnover,
        ROE_ReturnOnEquity,
		ReturnOnTangibleEquity,
		ROA_ReturnOnAssets,
		ROI_ReturnOnInvestment,
		OperatingCashFlowPerShare,
		FreeCashFlowPerShare,
        ROW_NUMBER() OVER (ORDER BY CurrentRatio) AS CurrentRatioRank,
		ROW_NUMBER() OVER (ORDER BY LongTermDebt_Capital) AS LongTermDebt_CapitalRank,
		ROW_NUMBER() OVER (ORDER BY Debt_EquityRatio) AS Debt_EquityRatioRank,
        ROW_NUMBER() OVER (ORDER BY GrossMargin) AS GrossMarginRank,
        ROW_NUMBER() OVER (ORDER BY OperatingMargin) AS OperatingMarginRank,
        ROW_NUMBER() OVER (ORDER BY EBITMargin) AS EBITMarginRank,
        ROW_NUMBER() OVER (ORDER BY EBITDAMargin) AS EBITDAMarginRank,
		ROW_NUMBER() OVER (ORDER BY PreTaxProfitMargin) AS PreTaxProfitMarginRank,
		ROW_NUMBER() OVER (ORDER BY NetProfitMargin) AS NetProfitMarginRank,
		ROW_NUMBER() OVER (ORDER BY AssetTurnover) AS AssetTurnoverRank,
        ROW_NUMBER() OVER (ORDER BY ROE_ReturnOnEquity) AS ROE_ReturnOnEquityRank,
        ROW_NUMBER() OVER (ORDER BY ReturnOnTangibleEquity) AS ReturnOnTangibleEquityRank,
        ROW_NUMBER() OVER (ORDER BY ROA_ReturnOnAssets) AS ROA_ReturnOnAssetsRank,
        ROW_NUMBER() OVER (ORDER BY ROI_ReturnOnInvestment) AS ROI_ReturnOnInvestmentRank,
        ROW_NUMBER() OVER (ORDER BY OperatingCashFlowPerShare) AS OperatingCashFlowPerShareRank,
        ROW_NUMBER() OVER (ORDER BY FreeCashFlowPerShare) AS FreeCashFlowPerShareRank,		
        COUNT(*) OVER () AS TotalRows
    FROM Corp_rate
),
Quartiles AS (
    SELECT 
        TotalRows,
        (TotalRows + 1) / 4 AS Q1Pos,
        (TotalRows + 1) / 2 AS MedianPos,
        3 * (TotalRows + 1) / 4 AS Q3Pos
    FROM OrderedRatios
    LIMIT 1
)
SELECT 
	"Current Ratio" AS Ratio,
    -- Descriptive stats for Current Ratio
    COUNT(CurrentRatio) AS Count,
    AVG(CurrentRatio) AS Mean,
    MIN(CurrentRatio) AS Min,
    (SELECT CurrentRatio FROM OrderedRatios WHERE CurrentRatioRank = Q1Pos) AS Q1,
    (SELECT CurrentRatio FROM OrderedRatios WHERE CurrentRatioRank = MedianPos) AS Median,
    (SELECT CurrentRatio FROM OrderedRatios WHERE CurrentRatioRank = Q3Pos) AS Q3,
	MAX(CurrentRatio) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT 
	"Long-term Debt to Capital" AS Ratio,
    -- Descriptive stats for Long-term Debt to Capital
    COUNT(LongTermDebt_Capital) AS Count,
    AVG(LongTermDebt_Capital) AS Mean,
    MIN(LongTermDebt_Capital) AS Min,
    (SELECT LongTermDebt_Capital FROM OrderedRatios WHERE LongTermDebt_CapitalRank = Q1Pos) AS Q1,
    (SELECT LongTermDebt_Capital FROM OrderedRatios WHERE LongTermDebt_CapitalRank = MedianPos) AS Median,
    (SELECT LongTermDebt_Capital FROM OrderedRatios WHERE LongTermDebt_CapitalRank = Q3Pos) AS Q3,
	MAX(LongTermDebt_Capital) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT 
	"Debt to Equity" AS Ratio,
    -- Descriptive stats for Debt to Equity
    COUNT(Debt_EquityRatio) AS Count,
    AVG(Debt_EquityRatio) AS Mean,
    MIN(Debt_EquityRatio) AS Min,
    (SELECT Debt_EquityRatio FROM OrderedRatios WHERE Debt_EquityRatioRank = Q1Pos) AS Q1,
    (SELECT Debt_EquityRatio FROM OrderedRatios WHERE Debt_EquityRatioRank = MedianPos) AS Median,
    (SELECT Debt_EquityRatio FROM OrderedRatios WHERE Debt_EquityRatioRank = Q3Pos) AS Q3,
	MAX(Debt_EquityRatio) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Gross Margin" AS Ratio,
    -- Descriptive stats for Gross Margin
    COUNT(GrossMargin) AS Count,
    AVG(GrossMargin) AS Mean,
    MIN(GrossMargin) AS Minn,
    (SELECT GrossMargin FROM OrderedRatios WHERE GrossMarginRank = Q1Pos) AS Q1,
    (SELECT GrossMargin FROM OrderedRatios WHERE GrossMarginRank = MedianPos) AS Median,
    (SELECT GrossMargin FROM OrderedRatios WHERE GrossMarginRank = Q3Pos) AS Q3,
	MAX(GrossMargin) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Operating Margin" AS Ratio,
    -- Descriptive stats for Operating Margin
    COUNT(OperatingMargin) AS Count,
    AVG(OperatingMargin) AS Mean,
    MIN(OperatingMargin) AS Min,
    (SELECT OperatingMargin FROM OrderedRatios WHERE OperatingMarginRank = Q1Pos) AS Q1,
    (SELECT OperatingMargin FROM OrderedRatios WHERE OperatingMarginRank = MedianPos) AS Median,
    (SELECT OperatingMargin FROM OrderedRatios WHERE OperatingMarginRank = Q3Pos) AS Q3,
	MAX(OperatingMargin) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"EBIT Margin" AS Ratio,
    -- Descriptive stats for EBIT Margin
    COUNT(EBITMargin) AS Count,
    AVG(EBITMargin) AS Mean,
    MIN(EBITMargin) AS Min,
    (SELECT EBITMargin FROM OrderedRatios WHERE EBITMarginRank = Q1Pos) AS Q1,
    (SELECT EBITMargin FROM OrderedRatios WHERE EBITMarginRank = MedianPos) AS Median,
    (SELECT EBITMargin FROM OrderedRatios WHERE EBITMarginRank = Q3Pos) AS Q3,
	MAX(EBITMargin) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"EBITDA Margin" AS Ratio,
    -- Descriptive stats for EBITDA Margin
    COUNT(EBITDAMargin) AS Count,
    AVG(EBITDAMargin) AS Mean,
    MIN(EBITDAMargin) AS Min,
    (SELECT EBITDAMargin FROM OrderedRatios WHERE EBITDAMarginRank = Q1Pos) AS Q1,
    (SELECT EBITDAMargin FROM OrderedRatios WHERE EBITDAMarginRank = MedianPos) AS Median,
    (SELECT EBITDAMargin FROM OrderedRatios WHERE EBITDAMarginRank = Q3Pos) AS Q3,
	MAX(EBITDAMargin) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Pre-tax Profit Margin" AS Ratio,
    -- Descriptive stats for Pre-tax Profit Margin
    COUNT(PreTaxProfitMargin) AS Count_Debt,
    AVG(PreTaxProfitMargin) AS Mean_Debt,
    MIN(PreTaxProfitMargin) AS Min_Debt,
    (SELECT PreTaxProfitMargin FROM OrderedRatios WHERE PreTaxProfitMarginRank = Q1Pos) AS Q1,
    (SELECT PreTaxProfitMargin FROM OrderedRatios WHERE PreTaxProfitMarginRank = MedianPos) AS Median,
    (SELECT PreTaxProfitMargin FROM OrderedRatios WHERE PreTaxProfitMarginRank = Q3Pos) AS Q3_Debt,
	MAX(PreTaxProfitMargin) AS Max_Debt
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Net Profit Margin" AS Ratio,
    -- Descriptive stats for Net Profit Margin
    COUNT(NetProfitMargin) AS Count_Debt,
    AVG(NetProfitMargin) AS Mean_Debt,
    MIN(NetProfitMargin) AS Min_Debt,
    (SELECT NetProfitMargin FROM OrderedRatios WHERE NetProfitMarginRank = Q1Pos) AS Q1,
    (SELECT NetProfitMargin FROM OrderedRatios WHERE NetProfitMarginRank = MedianPos) AS Median,
    (SELECT NetProfitMargin FROM OrderedRatios WHERE NetProfitMarginRank = Q3Pos) AS Q3_Debt,
	MAX(NetProfitMargin) AS Max_Debt
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Asset Turnover" AS Ratio,
    -- Descriptive stats for Asset Turnover
    COUNT(AssetTurnover) AS Count_Debt,
    AVG(AssetTurnover) AS Mean_Debt,
    MIN(AssetTurnover) AS Min_Debt,
    (SELECT AssetTurnover FROM OrderedRatios WHERE AssetTurnoverRank = Q1Pos) AS Q1,
    (SELECT AssetTurnover FROM OrderedRatios WHERE AssetTurnoverRank = MedianPos) AS Median,
    (SELECT AssetTurnover FROM OrderedRatios WHERE AssetTurnoverRank = Q3Pos) AS Q3_Debt,
	MAX(AssetTurnover) AS Max_Debt
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Return on Equity" AS Ratio,
    -- Descriptive stats for Return on Equity
    COUNT(ROE_ReturnOnEquity) AS Count,
    AVG(ROE_ReturnOnEquity) AS Mean,
    MIN(ROE_ReturnOnEquity) AS Min,
    (SELECT ROE_ReturnOnEquity FROM OrderedRatios WHERE ROE_ReturnOnEquityRank = Q1Pos) AS Q1,
    (SELECT ROE_ReturnOnEquity FROM OrderedRatios WHERE ROE_ReturnOnEquityRank = MedianPos) AS Median,
    (SELECT ROE_ReturnOnEquity FROM OrderedRatios WHERE ROE_ReturnOnEquityRank = Q3Pos) AS Q3,
	MAX(ROE_ReturnOnEquity) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Return on Tangible Equity" AS Ratio,
    -- Descriptive stats for Return on Tangible Equity
    COUNT(ReturnOnTangibleEquity) AS Count,
    AVG(ReturnOnTangibleEquity) AS Mean,
    MIN(ReturnOnTangibleEquity) AS Min,
    (SELECT ReturnOnTangibleEquity FROM OrderedRatios WHERE ReturnOnTangibleEquityRank = Q1Pos) AS Q1,
    (SELECT ReturnOnTangibleEquity FROM OrderedRatios WHERE ReturnOnTangibleEquityRank = MedianPos) AS Median,
    (SELECT ReturnOnTangibleEquity FROM OrderedRatios WHERE ReturnOnTangibleEquityRank = Q3Pos) AS Q3,
	MAX(ReturnOnTangibleEquity) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Return on Assets" AS Ratio,
    -- Descriptive stats for Return on Assets
    COUNT(ROA_ReturnOnAssets) AS Count,
    AVG(ROA_ReturnOnAssets) AS Mean,
    MIN(ROA_ReturnOnAssets) AS Min,
    (SELECT ROA_ReturnOnAssets FROM OrderedRatios WHERE ROA_ReturnOnAssetsRank = Q1Pos) AS Q1,
    (SELECT ROA_ReturnOnAssets FROM OrderedRatios WHERE ROA_ReturnOnAssetsRank = MedianPos) AS Median,
    (SELECT ROA_ReturnOnAssets FROM OrderedRatios WHERE ROA_ReturnOnAssetsRank = Q3Pos) AS Q3,
	MAX(ROA_ReturnOnAssets) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Return on Investment" AS Ratio,
    -- Descriptive stats for Return on Investment
    COUNT(ROI_ReturnOnInvestment) AS Count,
    AVG(ROI_ReturnOnInvestment) AS Mean,
    MIN(ROI_ReturnOnInvestment) AS Min,
    (SELECT ROI_ReturnOnInvestment FROM OrderedRatios WHERE ROI_ReturnOnInvestmentRank = Q1Pos) AS Q1,
    (SELECT ROI_ReturnOnInvestment FROM OrderedRatios WHERE ROI_ReturnOnInvestmentRank = MedianPos) AS Median,
    (SELECT ROI_ReturnOnInvestment FROM OrderedRatios WHERE ROI_ReturnOnInvestmentRank = Q3Pos) AS Q3,
	MAX(ROI_ReturnOnInvestment) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Operating Cash Flow per Share" AS Ratio,
    -- Descriptive stats for Operating Cash Flow per Share
    COUNT(OperatingCashFlowPerShare) AS Count,
    AVG(OperatingCashFlowPerShare) AS Mean,
    MIN(OperatingCashFlowPerShare) AS Min,
    (SELECT OperatingCashFlowPerShare FROM OrderedRatios WHERE OperatingCashFlowPerShareRank = Q1Pos) AS Q1,
    (SELECT OperatingCashFlowPerShare FROM OrderedRatios WHERE OperatingCashFlowPerShareRank = MedianPos) AS Median,
    (SELECT OperatingCashFlowPerShare FROM OrderedRatios WHERE OperatingCashFlowPerShareRank = Q3Pos) AS Q3,
	MAX(OperatingCashFlowPerShare) AS Max
FROM OrderedRatios, Quartiles
UNION ALL
SELECT
	"Free Cash Flow per Share" AS Ratio,
    -- Descriptive stats for Free Cash Flow per Share
    COUNT(FreeCashFlowPerShare) AS Count,
    AVG(FreeCashFlowPerShare) AS Mean,
    MIN(FreeCashFlowPerShare) AS Min,
    (SELECT FreeCashFlowPerShare FROM OrderedRatios WHERE FreeCashFlowPerShareRank = Q1Pos) AS Q1,
    (SELECT FreeCashFlowPerShare FROM OrderedRatios WHERE FreeCashFlowPerShareRank = MedianPos) AS Median,
    (SELECT FreeCashFlowPerShare FROM OrderedRatios WHERE FreeCashFlowPerShareRank = Q3Pos) AS Q3,
	MAX(FreeCashFlowPerShare) AS Max
FROM OrderedRatios, Quartiles;