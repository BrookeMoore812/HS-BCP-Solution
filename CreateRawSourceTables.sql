USE HealthStrategy;
GO
-- Create schema to separate raw data from cleaned up and transformed data
CREATE SCHEMA RawSource;
GO
-- Create table to hold raw data
CREATE TABLE RawSource.DummyData_Brooke_File1_BCP (
	LineFromFile VARCHAR(max)
	, LineNumber INT IDENTITY(1,1) NOT NULL
)
;
GO
CREATE TABLE RawSource.DummyData_Brooke_File2_BCP (
	LineFromFile VARCHAR(max)
	, LineNumber INT IDENTITY(1,1) NOT NULL
)
;
GO