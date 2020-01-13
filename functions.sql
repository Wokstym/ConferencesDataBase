GO
CREATE FUNCTION GetNumberOfFreePlacesForWorkshop
(
	@WorkshopId int
)
RETURNS int
AS
BEGIN
	IF not exists (SELECT WorkshopID
					FROM Workshops
					WHERE WorkshopID = @WorkshopId)
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		-- Get whole amount of free places
		DECLARE @FreePlaces int = (SELECT ParticipantLimit
									FROM Workshops
									WHERE WorkshopID = @WorkshopId)
		DECLARE curs CURSOR LOCAL FOR
			SELECT PlacesReservedAmount
				FROM WorkshopBooking
				WHERE WorkshopID = @WorkshopId
		DECLARE @PlacesReserved int

		-- Substract booked places
		SET @PlacesReserved = (SELECT sum(PlacesReservedAmount)
								FROM WorkshopBooking
								WHERE (WorkshopID = @WorkshopId) AND (IsCancelled = 0)
								GROUP BY WorkshopID )

		IF (@PlacesReserved is not null)
			SET @FreePlaces -= @PlacesReserved

		END

	-- Return the result of the function
	RETURN @FreePlaces
END

GO
CREATE FUNCTION GetPriceStageForDate
(
	@Date date,
	@ConferenceDayId int
)
RETURNS money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Price money = (SELECT TOP 1 Price FROM PriceInfo
									WHERE (ConferenceDayID = @ConferenceDayId) AND (DATEDIFF(day,InitialDate,@date) >= 0)
									ORDER BY InitialDate DESC )

	-- Return the result of the function
	RETURN @Price

END

GO
CREATE FUNCTION GetNumberOfFreePlacesForConference
(
	@ConferenceDayId int
)
RETURNS int
AS
BEGIN
	IF not exists (SELECT ConferenceDays.ConferenceDayId
					FROM ConferenceDays
					WHERE ConferenceDays.ConferenceDayId = @ConferenceDayId)
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		DECLARE @FreePlacesAmount int
		DECLARE curs CURSOR LOCAL FOR
			SELECT PlacesReservedAmount
			FROM ConferenceDayBooking
			WHERE ConferenceDayId = @ConferenceDayId
		DECLARE @PlacesReserved int

		-- All slots for that day
		SET @FreePlacesAmount = (SELECT ParticipantLimit
								FROM ConferenceDays
								WHERE ConferenceDays.ConferenceDayId = @ConferenceDayId)
		

		-- Reserved for that day
		SET @PlacesReserved = (SELECT sum(PlacesReservedAmount)
								FROM ConferenceDayBooking
								WHERE ConferenceDayId = @ConferenceDayId AND IsCancelled = 0 
								GROUP BY ConferenceDayId)

		--Free = All - reserved
		IF (@PlacesReserved is not null)
			SET @FreePlacesAmount -=@PlacesReserved


	END
	RETURN @FreePlacesAmount
END




GO
CREATE FUNCTION GetPriceInfoForDate
(
	@Date date, 
	@ConferenceDayId int
)
RETURNS money
AS
BEGIN
	DECLARE @PriceInfoID int
	SET @PriceInfoID = (SELECT TOP 1 PriceInfoID 
						FROM PriceInfo
						WHERE ConferenceDayId = @ConferenceDayId AND (DATEDIFF(day,InitialDate,@date) >=0) 
						ORDER BY InitialDate DESC)
	RETURN @PriceInfoID
END

GO
CREATE FUNCTION IsCompany
(
	@CustomerID int
)
RETURNS bit
AS
BEGIN
	DECLARE @IsCompany bit
	SET @IsCompany = (
		SELECT Count(CompanyID)
		FROM Companies
		WHERE CustomerID = @CustomerID
	)
	RETURN @IsCompany
END
