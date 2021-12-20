SELECT *
FROM dbo.Dummy_Data_BCP_Trailer
;

SELECT COUNT(*) as File1Total
FROM dbo.Dummy_Data_BCP_00_Native
;

SELECT COUNT(*) as File2Total
FROM dbo.Dummy_Data_BCP_01_Native
;

SELECT
(
SELECT COUNT(*)
FROM dbo.Dummy_Data_BCP_00_Native
)
+
(
SELECT COUNT(*)
FROM dbo.Dummy_Data_BCP_01_Native
) AS TotalAllFiles
;

SELECT COUNT(*)
FROM dbo.Dummy_Data_BCP_05_Staging;