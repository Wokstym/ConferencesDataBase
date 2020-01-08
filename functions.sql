CREATE FUNCTION [dbo].[GetNumberOfFreePlacesForWorkshop]
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


CREATE FUNCTION [dbo].[GetPriceStageForDate]
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

