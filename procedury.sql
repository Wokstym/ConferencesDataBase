GO
CREATE PROCEDURE AddCustomer
	@FirstName varchar(50),
	@LastName varchar(50),
	@Phone varchar(50),
	@Email varchar(50),
	@Address varchar(50),
	@PostalCode varchar(50),
	@City varchar(50),
	@Country varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Customers(FirstName,LastName,Email,Address, PostalCode, City, Country)
			VALUES (@FirstName, @LastName, @Email, @Address, @PostalCode, @City, @Country)
END

GO
CREATE PROCEDURE AddCompanyData
	@CustomerID int,

	@CompanyName varchar(50),
	@NIP varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Companies(CustomerID, CompanyName, NIP)
			VALUES(@CustomerID, @CompanyName, @NIP)
END

GO
CREATE PROCEDURE AddConference
	@ConferenceName varchar(50),
	@StartDate date,
	@DaysAmount int,
	@ConferenceType varchar(50),
	@BuildingID int,
	@OrganizerID int,
	@CustomerID int
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Conferences(ConferenceName, StartDate, DaysAmount, ConferenceType, BuildingID, OrganizerID, CustomerID)
			VALUES(@ConferenceName, @StartDate, @DaysAmount, @ConferenceType, @BuildingID, @OrganizerID, @CustomerID)
END

GO
CREATE PROCEDURE AddConferenceDay
	@DayNumber int,
	@ParticipantLimit int,
	@Date date,
	@ConferenceID int
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO ConferenceDays(DayNumber, ParticipantLimit, Date, ConferenceID)
			VALUES(@DayNumber, @ParticipantLimit, @Date, @ConferenceID)
END

GO
CREATE PROCEDURE AddWorkshop
	@WorkshopName varchar(50),
	@Price money,
	@StartTime time,
	@EndTime time,
	@ParticipantLimit int,
	@RoomID int,
	@ConferenceDayID int
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Workshops(WorkshopName, Price, StartTime, EndTime, ParticipantLimit, RoomID, ConferenceDayID)
			VALUES(@WorkshopName, @Price, @StartTime, @EndTime, @ParticipantLimit, @RoomID, @ConferenceDayID)
END

GO
CREATE PROCEDURE AddEmployee
	@FirstName varchar(50),
	@LastName varchar(50),
	@Address varchar(50),
	@City varchar(50),
	@Phone varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Employees(FirstName, LastName, Address, City, Phone)
			VALUES(@FirstName, @LastName, @Address, @City, @Phone)
END

GO
CREATE PROCEDURE AddPriceInfo
	@ConferenceDayID int,
	@InitialDate date,
	@Price money,
	@StudentDiscount real
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO PriceInfo(ConferenceDayID, InitialDate, Price, StudentDiscount)
			VALUES(@ConferenceDayID, @InitialDate, @Price, @StudentDiscount)
END

GO
CREATE PROCEDURE AddParticipant
	@FirstName varchar(50),
	@LastName varchar(50),
	@BirthDate date,
	@Email varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Participants(FirstName, LastName, BirthDate, Email)
			VALUES(@FirstName, @LastName, @BirthDate, @Email)
END

GO
CREATE PROCEDURE AddStudentData
	@ParticipantID int,
	@CardID int,
	@ExpirationDate date

AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Students(ParticipantID, CardID, ExpirationDate)
			VALUES(@ParticipantID, @CardID, @ExpirationDate)
END

GO
CREATE PROCEDURE AddOrganizer
	@CompanyName varchar(50),
	@Phone varchar(50),
	@Address varchar(50),
	@Country varchar(50),
	@City varchar(50),
	@PostalCode varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Organizers(CompanyName, Phone, Address, Country, City, PostalCode)
			VALUES(@CompanyName, @Phone, @Address, @Country, @City, @PostalCode)
END

GO
CREATE PROCEDURE AddBuildingOwner
	@CompanyName varchar(50),
	@Phone varchar(50),
	@Address varchar(50),
	@Country varchar(50),
	@City varchar(50),
	@PostalCode varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO BuildingOwners(CompanyName, Phone, Address, Country, City, PostalCode)
			VALUES(@CompanyName, @Phone, @Address, @Country, @City, @PostalCode)
END

GO
CREATE PROCEDURE AddBuilding
	@Address varchar(50),
	@ContactPhone varchar(50),
	@BuildingOwnerID int
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Buildings(Address, ContactPhone, BuildingOwnerID)
			VALUES(@Address, @ContactPhone, @BuildingOwnerID)
END

GO
CREATE PROCEDURE AddRoom
	@RoomName varchar(50),
	@RoomCapacity int,
	@BuildingID int
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Rooms(RoomName, RoomCapacity, BuildingID)
			VALUES(@RoomName, @RoomCapacity, @BuildingID)
END

GO
CREATE PROCEDURE AddPartner
	@CompanyName varchar(50),
	@PartnerCategory varchar(50),
	@Phone varchar(50),
	@Address varchar(50),
	@PostalCode varchar(50),
	@City varchar(50),
	@Country varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Partners(CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country)
			VALUES(@CompanyName, @PartnerCategory, @Phone, @Address, @PostalCode, @City, @Country)
END

GO
CREATE PROCEDURE AddPayment 
	@Amount money,
	@ConferenceDayBookingID int
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Payments(Amount, PaymentDate, ConferenceDayBookingID)
			VALUES(@Amount, GETDATE(), @ConferenceDayBookingID)
END

GO
-- Reserves conferenece day for a participant
CREATE PROCEDURE AssignParticipantToConferenceDayBooking
	@ConferenceDayBookingID int,
	@ParticipantID int
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO ConferenceDayReservations(ReservationDate,ConferenceDayBookingID, ParticipantID)
			VALUES(GETDATE(), @ConferenceDayBookingID, @ParticipantID)
END


GO
CREATE PROCEDURE AssignEmployeeToConferenceDay
	@EmployeeID int,
	@ConferenceDayID int
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ConfrenceDayDate date = (SELECT ConferenceDays.Date
								FROM ConferenceDays
								WHERE ConferenceDayID = @ConferenceDayID)
	DECLARE @ConferencesAssignedForNumber int = (SELECT COUNT (EFCD.ConferenceDayID)
											FROM EmployeesForConferenceDays as EFCD
											INNER JOIN ConferenceDays CD ON EFCD.ConferenceDayID = CD.ConferenceDayID
											WHERE (EmployeeID = @EmployeeID) AND (CD.Date = @ConfrenceDayDate))

	IF (@ConferencesAssignedForNumber > 0)
	BEGIN
		; THROW 52000,'Employee already assigned for other conference during that day'
	END
	ELSE
	BEGIN
		INSERT INTO EmployeesForConferenceDays(EmployeeID,ConferenceDayID)
			VALUES(@EmployeeID, @ConferenceDayID)
	END
END

GO
CREATE PROCEDURE AssignPartnerToConference -- Do sprawdzenia 
	@PartnerID int,
	@ConferenceID int
AS
BEGIN
	SET NOCOUNT ON;


	INSERT INTO PartnersForConferences(PartnerID,ConferenceID)
		VALUES(@PartnerID, @ConferenceID)
END

GO
CREATE PROCEDURE AssignParticipantToWorkshopBooking
	@WorkshopBookingID int,
	@ParticipantID int
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ConfDayBookingID int = (SELECT ConferenceDayBookingID
														FROM WorkshopBooking
														WHERE WorkshopBookingID = @WorkshopBookingID)

	DECLARE @ParticipantsConferenceDayReservationID int = (SELECT ConferenceDayReservationID
														FROM ConferenceDayReservations
														WHERE (ParticipantID = @ParticipantID) AND (ConferenceDayBookingID = @ConfDayBookingID))

	IF (@ParticipantsConferenceDayReservationID is null)
	BEGIN
		; THROW 52000, 'Participant not assigned for appropriate conferenece day booking.', 1
	END

	INSERT INTO WorkshopReservations(ReservationDate,WorkshopBookingID, ConferenceDayReservationID)
		VALUES(GETDATE(),@WorkshopBookingID, @ParticipantsConferenceDayReservationID)
END

GO
CREATE PROCEDURE BookPlacesForConferenceDay
	@CustomerID int,
	@ConferenceDayID int,
	@PlacesReservedAmount int
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO ConferenceDayBooking(PlacesReservedAmount, BookingDate, CustomerID, ConferenceDayID)
		VALUES(@PlacesReservedAmount, GETDATE(), @CustomerID, @ConferenceDayID)
END

GO
CREATE PROCEDURE BookPlacesForWorkshop
	@WorkshopID int,
	@PlacesReservedAmount int, 
	@ConferenceDayBookingID int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO WorkshopBooking(PlacesReservedAmount, BookingDate, WorkshopID, ConferenceDayBookingID)
		VALUES(@PlacesReservedAmount, GETDATE(), @WorkshopID, @ConferenceDayBookingID)
END

GO
CREATE PROCEDURE CancelConferenceDayBooking
	@ConferenceDayBookingID int
AS
BEGIN
	SET NOCOUNT ON;

	IF NOT EXISTS(SELECT * FROM ConferenceDayBooking
					WHERE ConferenceDayBookingID = @ConferenceDayBookingID)
	BEGIN
		; THROW 51000, 'Cannot find such booking for conference day',1
	END
	ELSE IF ((SELECT IsCancelled
				FROM ConferenceDayBooking
				WHERE ConferenceDayBookingID = @ConferenceDayBookingID) = 1)
	BEGIN
		; THROW 52000, 'Booking for conference day has already been cancelled',1
	END
	ELSE
	BEGIN
		DECLARE @WorkshopBookingID int
		DECLARE curs CURSOR LOCAL FOR 	SELECT WorkshopBooking.WorkshopBookingID
										FROM WorkshopBooking
										WHERE WorkshopBooking.ConferenceDayBookingID =
										@ConferenceDayBookingID
		OPEN curs
		BEGIN TRY
			BEGIN TRAN -- Deleting all workshop booking
				FETCH NEXT FROM curs INTO @WorkshopBookingID

				WHILE @@FETCH_STATUS = 0
				BEGIN
					BEGIN TRY
						exec CancelWorkshopBooking @WorkshopBookingID
					END TRY

					BEGIN CATCH
						print @WorkshopBookingID + 'has already been removed from database'
					END CATCH

					FETCH NEXT FROM curs INTO @WorkshopBookingID
				END
				DELETE FROM ConferenceDayReservations
					WHERE ConferenceDayBookingID = @ConferenceDayBookingID

				UPDATE ConferenceDayBooking
					SET IsCancelled = 1
					WHERE ConferenceDayBookingID = @ConferenceDayBookingID
				CLOSE curs
				DEALLOCATE curs
			COMMIT TRAN
			
		END TRY

		BEGIN CATCH
			CLOSE curs
			DEALLOCATE curs
			print error_message()
			ROLLBACK TRANSACTION
		END CATCH
		
	END
END


GO
CREATE PROCEDURE CancelAllUnpaidConferenceDayBookings
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE curs CURSOR LOCAL FOR (SELECT CDPI.ConferenceDayBookingID, CDPI.BookingDate
									FROM ConferenceDayPayingInfo as CDPI 
									LEFT JOIN PaymentsDiffInfo as PDI 
										ON (CDPI.ConferenceDayBookingID=PDI.ConferenceDayBookingID) 
										AND 
										(PDI.PaidMoney < (CDPI.ConferenceDayActualPrice + CDPI.WorkshopActualPrice))
									INNER JOIN ConferenceDayBooking as CDB
										ON (CDPI.ConferenceDayBookingID = CDB.ConferenceDayBookingID)
										AND
										((CDB.IsCancelled = 0))
									)
	DECLARE @BookingID int, @BookingDate date
	OPEN curs
		FETCH NEXT FROM curs INTO @BookingID, @BookingDate
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF(DATEDIFF(day,@BookingDate,GETDATE()) >7) -- is unpaid
			BEGIN
				exec CancelConferenceDayBooking @BookingID
			END
			FETCH NEXT FROM curs INTO @BookingID, @BookingDate
		END
	CLOSE curs
	DEALLOCATE curs
END



GO
CREATE PROCEDURE CancelWorkshopBooking
	@WorkshopBookingID int
AS
BEGIN
	SET NOCOUNT ON;
	IF ((SELECT IsCancelled FROM WorkshopBooking WHERE WorkshopBookingID = @WorkshopBookingID)=1)
	BEGIN
		; THROW 52000, 'Booking already cancelled',1
	END
	ELSE
	BEGIN TRY
		BEGIN TRAN
			DELETE FROM WorkshopReservations
				WHERE WorkshopReservations.WorkshopBookingID = @WorkshopBookingID
			UPDATE WorkshopBooking
				SET WorkshopBooking.IsCancelled = 1
				WHERE WorkshopBooking.WorkshopBookingID = @WorkshopBookingID
			COMMIT TRAN
	END TRY
	-- Exception handling
	BEGIN CATCH
		print error_message()
		ROLLBACK TRANSACTION 
	END CATCH
END

GO
CREATE PROCEDURE ChangePlacesReservedAmountForWorkshopBooking
	@WorkshopBookingID int,
	@NewPlacesReservedAmount int
AS
BEGIN
	SET NOCOUNT ON;
		UPDATE WorkshopBooking
			SET PlacesReservedAmount = @NewPlacesReservedAmount
			WHERE WorkshopBookingID = @WorkshopBookingID
END

GO
CREATE PROCEDURE DecreasePlacesReservedAmountForConferenceDay
	@ConferenceDayBookingID int,
	@NewPlacesReservedAmount int
AS
BEGIN
	SET NOCOUNT ON;

	IF ((SELECT PlacesReservedAmount
			FROM ConferenceDayBooking
			WHERE ConferenceDayBookingID = @ConferenceDayBookingID) < @NewPlacesReservedAmount)
	BEGIN
		;THROW 52000, 'You can only decrease number of places reserved.
		 If you would like to increase it, make a new booking.',1
	END
	ELSE
	BEGIN
		UPDATE ConferenceDayBooking
			SET PlacesReservedAmount = @NewPlacesReservedAmount
			WHERE ConferenceDayBookingID = @ConferenceDayBookingID
	END
END

GO
CREATE PROCEDURE RemoveParticiptanReservationForConferenceDay
	@ConferenceDayReseverationID int
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
			DELETE FROM WorkshopReservations
				WHERE ConferenceDayReservationID = @ConferenceDayReseverationID
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		print error_message()
		ROLLBACK TRANSACTION
	END CATCH
END

GO
CREATE PROCEDURE RemoveParticiptanReservationForWorkshop
	@WorkshopReservationID int
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		BEGIN TRAN
			DELETE FROM WorkshopReservations
				WHERE WorkshopReservationID = @WorkshopReservationID
		COMMIT TRAN
	END TRY

	BEGIN CATCH
		print error_message()
		ROLLBACK TRANSACTION
	END CATCH
END

GO
CREATE PROCEDURE IncreaseParticipantLimitForConferenceDay
	@ConferenceDayID int,
	@NewParticipantLimit int
AS
BEGIN
	SET NOCOUNT ON;
	IF (@NewParticipantLimit <= (SELECT ParticipantLimit 
								FROM ConferenceDays 
								WHERE ConferenceDayID = @ConferenceDayID))
	BEGIN
		; THROW 52000, 'You can only increase participant limit for conferenece day',1
	END
	ELSE
		UPDATE ConferenceDays
			SET ParticipantLimit = @NewParticipantLimit
			WHERE ConferenceDayID = @ConferenceDayID
END

GO
CREATE PROCEDURE IncreaseParticipantLimitForWorkshop
	@WorkshopID int,
	@NewParticipantLimit int
AS
BEGIN
	SET NOCOUNT ON;
	IF (@NewParticipantLimit <= (SELECT ParticipantLimit 
								FROM Workshops 
								WHERE WorkshopID = @WorkshopID))
	BEGIN
		; THROW 52000, 'You can only increase participant limit for workshop',1
	END
	ELSE
		UPDATE Workshops
			SET ParticipantLimit = @NewParticipantLimit
			WHERE WorkshopID = @WorkshopID
END


GO
CREATE PROCEDURE GEN_AddPayment
	@Amount money,
	@ConferenceDayBookingID int,
	@Date date
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO Payments(Amount, PaymentDate, ConferenceDayBookingID)
			VALUES(@Amount, @Date, @ConferenceDayBookingID)
END

GO
CREATE PROCEDURE GEN_AssignParticipantToConferenceDayBooking
	@ConferenceDayBookingID int,
	@ParticipantID int,
	@Date date
AS
BEGIN
	SET NOCOUNT ON;
		INSERT INTO ConferenceDayReservations(ReservationDate,ConferenceDayBookingID, ParticipantID)
			VALUES(@Date, @ConferenceDayBookingID, @ParticipantID)
END

GO
CREATE PROCEDURE GEN_AssignParticipantToWorkshopBooking
	@WorkshopBookingID int,
	@ParticipantID int,
	@Date date
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ConfDayBookingID int = (SELECT ConferenceDayBookingID
														FROM WorkshopBooking
														WHERE WorkshopBookingID = @WorkshopBookingID)

	DECLARE @ParticipantsConferenceDayReservationID int = (SELECT ConferenceDayReservationID
														FROM ConferenceDayReservations
														WHERE (ParticipantID = @ParticipantID) AND (ConferenceDayBookingID = @ConfDayBookingID))

	IF (@ParticipantsConferenceDayReservationID is null)
	BEGIN
		; THROW 52000, 'Participant not assigned for appropriate conferenece day booking.', 1
	END

	INSERT INTO WorkshopReservations(ReservationDate,WorkshopBookingID, ConferenceDayReservationID)
		VALUES(@Date, @WorkshopBookingID, @ParticipantsConferenceDayReservationID)
END

GO
CREATE PROCEDURE GEN_BookPlacesForConferenceDay
	@CustomerID int,
	@ConferenceDayID int,
	@PlacesReservedAmount int,
	@Date date
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO ConferenceDayBooking(PlacesReservedAmount, BookingDate, CustomerID, ConferenceDayID)
		VALUES(@PlacesReservedAmount, @Date, @CustomerID, @ConferenceDayID)
END

GO
CREATE PROCEDURE GEN_BookPlacesForWorkshop -- Może wymaga przerobienia
	@WorkshopID int,
	@PlacesReservedAmount int, 
	@ConferenceDayBookingID int,
	@Date date
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO WorkshopBooking(PlacesReservedAmount, BookingDate, WorkshopID, ConferenceDayBookingID)
		VALUES(@PlacesReservedAmount, @Date, @WorkshopID, @ConferenceDayBookingID)
END