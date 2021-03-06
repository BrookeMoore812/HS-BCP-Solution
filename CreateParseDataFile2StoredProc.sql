
USE HealthStrategy
GO
CREATE PROC dbo.ParseDataFile2
AS
BEGIN
	DECLARE @Filename VARCHAR(50) = 'DummyData_Brooke_File2.txt';
	DECLARE @NumberOfLines INT;
	DECLARE @sqlQuery NVARCHAR(4000);
	DECLARE @ParmDefinition NVARCHAR(500);

	SELECT @NumberOfLines = MAX(RS.LineNumber) 
	FROM RawSource.DummyData_Brooke_File2_BCP RS
	;

	-- Put header into table
	INSERT INTO dbo.Dummy_Data_BCP_Header(
		FILENAME,
		RECORDIDENTIFIER,
		RUNDATE,
		SENDINGCOMPANYNAME,
		CYCLESTARTDATE,
		CYCLEENDDATE,
		FILLER
	)
	SELECT
	@Filename as Filename
	, LEFT(RS.LineFromFile, 1) as RecordIdentifier
	, RIGHT(LEFT(RS.LineFromFile, 9), 8) as RunDate
	, RIGHT(LEFT(RS.LineFromFile, 29), 20) as SendingCompanyName
	, RIGHT(LEFT(RS.LineFromFile, 37), 8) as CycleStartDate
	, RIGHT(LEFT(RS.LineFromFile, 45), 8) as CycleEndDate
	, RIGHT(RS.LineFromFile, 905) as Filler
	FROM RawSource.DummyData_Brooke_File2_BCP RS
	WHERE RS.LineNumber = 1
	;
	
	--Put trailer into table
	INSERT INTO dbo.Dummy_Data_BCP_Trailer(
		FILENAME,
		RECORDIDENTIFIER,
		TOTALNUMBEROFCLAIMS,
		TOTALAMOUNTPAYABLE,
		TOTALADMINFEEAMOUNT,
		FILLER
	)
	SELECT
	@Filename as Filename
	, LEFT(RS.LineFromFile, 1) as RecordIdentifier
	, RIGHT(LEFT(RS.LineFromFile, 10), 9) as TotalNumberOfClaims
	, RIGHT(LEFT(RS.LineFromFile, 24), 14) as TotalAmountPayable
	, RIGHT(LEFT(RS.LineFromFile, 33), 9) as TotalAdminFeeAmount
	, RIGHT(RS.LineFromFile, 917) as Filler
	FROM RawSource.DummyData_Brooke_File2_BCP RS
	WHERE RS.LineNumber = @NumberOfLines
	;

	-- PARSE DATA LINES INTO DESTINATION TABLE
	INSERT INTO dbo.Dummy_Data_BCP_01_Native
	SELECT
		LEFT(RS.LineFromFile, 1) as RecordIdentifier
		, RIGHT(LEFT(RS.LineFromFile,21),20) as CARRIERID
		, RIGHT(LEFT(RS.LineFromFile,36),15) as ACCOUNTIDGROUPEXTENSIONCODE
		, RIGHT(LEFT(RS.LineFromFile,51),15) as GROUPID
		, RIGHT(LEFT(RS.LineFromFile,71),20) as CARDHOLDERMEMBERID
		, RIGHT(LEFT(RS.LineFromFile,91),20) as ALTERNATEID
		, RIGHT(LEFT(RS.LineFromFile,101),10) as CAREFACILITYID
		, RIGHT(LEFT(RS.LineFromFile,104),3) as PERSONCODE
		, RIGHT(LEFT(RS.LineFromFile,129),25) as CARDHOLDERLASTNAME
		, RIGHT(LEFT(RS.LineFromFile,154),25) as CARDHOLDERFIRSTNAME
		, RIGHT(LEFT(RS.LineFromFile,155),1) as CARDHOLDERMIDDLEINITIAL
		, RIGHT(LEFT(RS.LineFromFile,180),25) as PATIENTLASTNAME
		, RIGHT(LEFT(RS.LineFromFile,195),15) as PATIENTFIRSTNAME
		, RIGHT(LEFT(RS.LineFromFile,203),8) as PATIENTBIRTHDATE
		, RIGHT(LEFT(RS.LineFromFile,204),1) as PATIENTSEX
		, RIGHT(LEFT(RS.LineFromFile,205),1) as RELATIONSHIPCODE
		, RIGHT(LEFT(RS.LineFromFile,215),10) as FILLER
		, RIGHT(LEFT(RS.LineFromFile,230),15) as PROVIDERID
		, RIGHT(LEFT(RS.LineFromFile,232),2) as PROVIDERIDQUALIFIER
		, RIGHT(LEFT(RS.LineFromFile,252),20) as PROVIDERNAME
		, RIGHT(LEFT(RS.LineFromFile,258),6) as NETWORKID
		, RIGHT(LEFT(RS.LineFromFile,267),9) as RXNUMBER
		, RIGHT(LEFT(RS.LineFromFile,268),1) as RXNUMBERQUALIFIER
		, RIGHT(LEFT(RS.LineFromFile,276),8) as DATEFILLED
		, RIGHT(LEFT(RS.LineFromFile,284),8) as DATEPRESCRIPTIONWRITTEN
		, RIGHT(LEFT(RS.LineFromFile,292),8) as RXCLAIMDATEPROCESSED
		, RIGHT(LEFT(RS.LineFromFile,310),18) as TRANSACTIONID
		, RIGHT(LEFT(RS.LineFromFile,311),1) as CLAIMSTATUSFLAG
		, RIGHT(LEFT(RS.LineFromFile,312),1) as CLAIMORIGINATIONFLAG
		, RIGHT(LEFT(RS.LineFromFile,313),1) as REIMBURSEMENTTYPE
		, RIGHT(LEFT(RS.LineFromFile,315),2) as NEWREFILLNUMBER
		, RIGHT(LEFT(RS.LineFromFile,317),2) as NUMBEROFREFILLSAUTHORIZED
		, RIGHT(LEFT(RS.LineFromFile,327),10) as PRICESOURCEINDICATOR
		, RIGHT(LEFT(RS.LineFromFile,347),20) as PRODUCTID
		, RIGHT(LEFT(RS.LineFromFile,349),2) as PRODUCTIDQUALIFIER
		, RIGHT(LEFT(RS.LineFromFile,379),30) as DRUGNAME
		, RIGHT(LEFT(RS.LineFromFile,381),2) as DRUGADMINISTRATIONROUTECODE
		, RIGHT(LEFT(RS.LineFromFile,395),14) as GPICODE
		, RIGHT(LEFT(RS.LineFromFile,396),1) as MEDBMEDDINDICATOR
		, RIGHT(LEFT(RS.LineFromFile,400),4) as FILLER2
		, RIGHT(LEFT(RS.LineFromFile,405),5) as GENERICCLASS
		, RIGHT(LEFT(RS.LineFromFile,465),60) as GENERICNAME
		, RIGHT(LEFT(RS.LineFromFile,466),1) as GENERICBRANDINDICATOR
		, RIGHT(LEFT(RS.LineFromFile,472),6) as THERAPEUTICCLASSAHFSCODE
		, RIGHT(LEFT(RS.LineFromFile,473),1) as MULTISINGLESOURCEINDICATOR
		, RIGHT(LEFT(RS.LineFromFile,477),4) as DRUGDOSAGEFORM
		, RIGHT(LEFT(RS.LineFromFile,487),10) as DRUGSTRENGTH
		, RIGHT(LEFT(RS.LineFromFile,489),2) as DEACLASS
		, RIGHT(LEFT(RS.LineFromFile,490),1) as COMPOUNDINDICATOR
		, RIGHT(LEFT(RS.LineFromFile,491),1) as PRODUCTSELECTIONCODEDAW
		, RIGHT(LEFT(RS.LineFromFile,492),1) as OTHERCOVERAGE
		, RIGHT(LEFT(RS.LineFromFile,503),11) as PAYABLEQUANTITY
		, RIGHT(LEFT(RS.LineFromFile,512),9) as PHARMACYAMOUNTSUBMITTEDUC
		, RIGHT(LEFT(RS.LineFromFile,515),3) as DAYSSUPPLY
		, RIGHT(LEFT(RS.LineFromFile,524),9) as SUBMITTEDINGREDIENTCOST
		, RIGHT(LEFT(RS.LineFromFile,533),9) as INGREDIENTCOSTPAYABLE
		, RIGHT(LEFT(RS.LineFromFile,542),9) as SUBMITTEDDISPENSINGFEE
		, RIGHT(LEFT(RS.LineFromFile,551),9) as DISPENSINGFEEPAYABLE
		, RIGHT(LEFT(RS.LineFromFile,560),9) as SUBMITTEDSALESTAX
		, RIGHT(LEFT(RS.LineFromFile,569),9) as SALESTAXPAYABLE
		, RIGHT(LEFT(RS.LineFromFile,578),9) as SUBMITTEDGROSSAMOUNTDUE
		, RIGHT(LEFT(RS.LineFromFile,587),9) as AMOUNTBILLED
		, RIGHT(LEFT(RS.LineFromFile,596),9) as SUBMITTEDPATIENTPAYAMOUNT
		, RIGHT(LEFT(RS.LineFromFile,605),9) as PATIENTPAYAMOUNT
		, RIGHT(LEFT(RS.LineFromFile,614),9) as FLATCOPAYAMOUNTPAID
		, RIGHT(LEFT(RS.LineFromFile,623),9) as PERCENTCOPAYAMOUNTPAID
		, RIGHT(LEFT(RS.LineFromFile,628),5) as ADMINFEE
		, RIGHT(LEFT(RS.LineFromFile,629),1) as MAINTENANCEDRUGINDICATOR
		, RIGHT(LEFT(RS.LineFromFile,639),10) as FINALPLANCODE
		, RIGHT(LEFT(RS.LineFromFile,647),8) as PLANCODEEXTENSION
		, RIGHT(LEFT(RS.LineFromFile,648),1) as FILLER3
		, RIGHT(LEFT(RS.LineFromFile,657),9) as CARDHOLDERCOPAYDIFFERENTIAL
		, RIGHT(LEFT(RS.LineFromFile,666),9) as FRONTENDDEDUCTIBLEAMOUNT
		, RIGHT(LEFT(RS.LineFromFile,675),9) as AFTERMAXAMOUNT
		, RIGHT(LEFT(RS.LineFromFile,684),9) as TOTALCOPAYAMOUNT
		, RIGHT(LEFT(RS.LineFromFile,693),9) as PATIENTACCUMULATEDDEDUCTIBLEAMOUNT
		, RIGHT(LEFT(RS.LineFromFile,696),3) as DISPENSERTYPE
		, RIGHT(LEFT(RS.LineFromFile,706),10) as AWP
		, RIGHT(LEFT(RS.LineFromFile,707),1) as AWPTYPEINDICATOR
		, RIGHT(LEFT(RS.LineFromFile,710),3) as BILLINGREPORTINGCODE
		, RIGHT(LEFT(RS.LineFromFile,711),1) as FORMULARYINDICATORFORMULARYSTATUS
		, RIGHT(LEFT(RS.LineFromFile,714),3) as REJECTCODE1
		, RIGHT(LEFT(RS.LineFromFile,725),11) as PRIORAUTHORIZATIONNUMBER
		, RIGHT(LEFT(RS.LineFromFile,727),2) as PRIORAUTHORIZATIONREASONCODES
		, RIGHT(LEFT(RS.LineFromFile,739),12) as PAMCSCCODEANDNUMBER
		, RIGHT(LEFT(RS.LineFromFile,741),2) as BASISOFCOSTDETERMINATION
		, RIGHT(LEFT(RS.LineFromFile,756),15) as PRESCRIBERNUMBER
		, RIGHT(LEFT(RS.LineFromFile,758),2) as PRESCRIBERIDQUALIFER
		, RIGHT(LEFT(RS.LineFromFile,763),5) as PERFORMANCERXPHARMACYFEEPAID
		, RIGHT(LEFT(RS.LineFromFile,768),5) as PERFORMANCERXFEEPAID
		, RIGHT(LEFT(RS.LineFromFile,783),15) as D0RXNUMBER
		, RIGHT(LEFT(RS.LineFromFile,784),1) as RXNUMBERQUALIFIER2
		, RIGHT(LEFT(RS.LineFromFile,787),3) as ADJUSTMENTREASONCODE
		, RIGHT(LEFT(RS.LineFromFile,797),10) as ADJUSTMENTISSUEID
		, RIGHT(LEFT(RS.LineFromFile,806),9) as RebillIncentive
		, RIGHT(LEFT(RS.LineFromFile,807),1) as VaccineClaimIndicator
		, RIGHT(LEFT(RS.LineFromFile,817),10) as CareNetwork
		, RIGHT(LEFT(RS.LineFromFile,827),10) as CareQualifier
		, RIGHT(LEFT(RS.LineFromFile,835),8) as COBPrimaryPayerAmountPaid
		, RIGHT(LEFT(RS.LineFromFile,846),11) as AppliedHRAAmount
		, RIGHT(LEFT(RS.LineFromFile,854),8) as BILLINGCYCLEENDDATE
		, RIGHT(LEFT(RS.LineFromFile,855),1) as MAINTENANCECHOICEINDICATOR
		, RIGHT(LEFT(RS.LineFromFile,863),8) as OPARAmount
		, RIGHT(LEFT(RS.LineFromFile,865),2) as CB5Qualifier
		, RIGHT(LEFT(RS.LineFromFile,874),9) as CB5OTHAmount1
		, RIGHT(LEFT(RS.LineFromFile,876),2) as CB5Qualifier2
		, RIGHT(LEFT(RS.LineFromFile,885),9) as CB5OTHAmount2
		, RIGHT(LEFT(RS.LineFromFile,887),2) as CB5Qualifier3
		, RIGHT(LEFT(RS.LineFromFile,896),9) as CB5OTHAmount3
		, RIGHT(LEFT(RS.LineFromFile,905),9) as PD6ClientTotalOtherAmount
		, RIGHT(LEFT(RS.LineFromFile,914),9) as PD6BuyTotalOtherAmount
		, RIGHT(LEFT(RS.LineFromFile,916),2) as DiagnosisCodeQualifier
		, RIGHT(LEFT(RS.LineFromFile,931),15) as DiagnosisCode
		, RIGHT(RS.LineFromFile,19) as FILLER4
	FROM RawSource.DummyData_Brooke_File2_BCP RS
	WHERE RS.LineNumber > 1
	AND RS.LineNumber < @NumberOfLines

END
