USE u_mpawlowi

CREATE TABLE Conferences (
  ConferenceID   int IDENTITY NOT NULL, 
  ConferenceName varchar(50) NOT NULL, 
  StartDate      date NOT NULL, 
  DaysAmount     int NOT NULL CHECK(DaysAmount >= 1), 
  ConferenceType varchar(50) NOT NULL, 
  BuildingID     int NOT NULL, 
  OrganizerID    int NOT NULL, 
  CustomerID     int NOT NULL, 
  PRIMARY KEY CLUSTERED (ConferenceID));
CREATE TABLE Organizers (
  OrganizerID int IDENTITY NOT NULL, 
  CompanyName varchar(50) NOT NULL UNIQUE, 
  Phone       varchar(50) NOT NULL, 
  Address     varchar(50) NOT NULL, 
  Country     varchar(50) NOT NULL, 
  City        varchar(50) NOT NULL, 
  PostalCode  varchar(50) NOT NULL, 
  PRIMARY KEY CLUSTERED (OrganizerID));
CREATE TABLE BuildingOwners (
  BuildingOwnerID int IDENTITY NOT NULL, 
  CompanyName     varchar(50) NOT NULL UNIQUE, 
  Phone           varchar(50) NOT NULL, 
  Address         varchar(50) NOT NULL, 
  Country         varchar(50) NOT NULL, 
  City            varchar(50) NOT NULL, 
  PostalCode      varchar(50) NOT NULL, 
  PRIMARY KEY CLUSTERED (BuildingOwnerID));
CREATE TABLE Buildings (
  BuildingID      int IDENTITY NOT NULL, 
  Address         varchar(50) NOT NULL, 
  ContactPhone    varchar(50) NOT NULL, 
  BuildingOwnerID int NOT NULL, 
  PRIMARY KEY CLUSTERED (BuildingID));
CREATE TABLE Partners (
  PartnerID       int IDENTITY NOT NULL, 
  CompanyName     varchar(50) NOT NULL UNIQUE, 
  PartnerCategory varchar(50) NOT NULL, 
  Phone           varchar(50) NOT NULL, 
  Address         varchar(50) NOT NULL, 
  PostalCode      varchar(50) NOT NULL, 
  City            varchar(50) NOT NULL, 
  Country         varchar(50) NOT NULL, 
  PRIMARY KEY CLUSTERED (PartnerID));
CREATE TABLE PartnersForConferences (
  PartnerID    int NOT NULL, 
  ConferenceID int NOT NULL, 
  PRIMARY KEY CLUSTERED (PartnerID, 
  ConferenceID));
CREATE TABLE Rooms (
  RoomID       int IDENTITY NOT NULL, 
  RoomName     varchar(50) NOT NULL, 
  RoomCapacity int NOT NULL CHECK(RoomCapacity > 0), 
  BuildingID   int NOT NULL, 
  PRIMARY KEY CLUSTERED (RoomID));
CREATE TABLE Workshops (
  WorkshopID       int IDENTITY NOT NULL, 
  WorkshopName     varchar(50) NOT NULL, 
  Price            money NOT NULL CHECK(Price >= 0), 
  StartTime        time NOT NULL, 
  EndTime          time NOT NULL, 
  ParticipantLimit int NOT NULL CHECK(ParticipantLimit > 0), 
  RoomID           int NOT NULL, 
  ConferenceDayID  int NOT NULL, 
  PRIMARY KEY CLUSTERED (WorkshopID));
CREATE TABLE ConferenceDays (
  ConferenceDayID  int IDENTITY NOT NULL, 
  DayNumber        int NOT NULL CHECK(DayNumber >= 1), 
  ParticipantLimit int NOT NULL CHECK(ParticipantLimit > 0), 
  [Date]           date NOT NULL, 
  ConferenceID     int NOT NULL, 
  PRIMARY KEY CLUSTERED (ConferenceDayID));
CREATE TABLE Employees (
  EmployeeID int IDENTITY NOT NULL, 
  FirstName  varchar(50) NOT NULL, 
  LastName   varchar(50) NOT NULL, 
  Address    varchar(50) NOT NULL, 
  City       varchar(50) NOT NULL, 
  Phone      varchar(50) NOT NULL, 
  PRIMARY KEY CLUSTERED (EmployeeID));
CREATE TABLE EmployeesForConferenceDays (
  EmployeeID      int NOT NULL, 
  ConferenceDayID int NOT NULL, 
  PRIMARY KEY CLUSTERED (EmployeeID, 
  ConferenceDayID));
CREATE TABLE ConferenceDayBooking (
  ConferenceDayBookingID int IDENTITY NOT NULL, 
  PlacesReservedAmount   int NOT NULL CHECK(PlacesReservedAmount > 0), 
  BookingDate            date NOT NULL, 
  IsCancelled            bit DEFAULT '0' NOT NULL, 
  CustomerID             int NOT NULL, 
  ConferenceDayID        int NOT NULL, 
  PRIMARY KEY CLUSTERED (ConferenceDayBookingID));
CREATE TABLE Customers (
  CustomerID int IDENTITY NOT NULL, 
  FirstName  varchar(50) NOT NULL, 
  LastName   varchar(50) NOT NULL, 
  Phone      varchar(50) NOT NULL, 
  Email      varchar(50) NOT NULL CHECK(Email LIKE '%_@_%._%'), 
  Address    varchar(50) NOT NULL, 
  PostalCode varchar(50) NOT NULL, 
  City       varchar(50) NOT NULL, 
  Country    varchar(50) NOT NULL, 
  PRIMARY KEY CLUSTERED (CustomerID));
CREATE TABLE Companies (
  CustomerID  int NOT NULL, 
  CompanyID   int IDENTITY NOT NULL, 
  CompanyName varchar(50) NOT NULL UNIQUE, 
  NIP         varchar(50) NOT NULL, 
  PRIMARY KEY CLUSTERED (CustomerID, 
  CompanyID));
CREATE TABLE Payments (
  PaymentID              int IDENTITY NOT NULL, 
  Amount                 money NOT NULL CHECK(Amount > 0), 
  PaymentDate            date NOT NULL, 
  ConferenceDayBookingID int NOT NULL, 
  PRIMARY KEY CLUSTERED (PaymentID));
CREATE TABLE WorkshopBooking (
  WorkshopBookingID      int IDENTITY NOT NULL, 
  PlacesReservedAmount   int NOT NULL CHECK(PlacesReservedAmount > 0), 
  BookingDate            date NOT NULL, 
  IsCancelled            bit DEFAULT '0' NOT NULL, 
  WorkshopID             int NOT NULL, 
  ConferenceDayBookingID int NOT NULL, 
  PRIMARY KEY CLUSTERED (WorkshopBookingID));
CREATE TABLE PriceInfo (
  PriceInfoID     int IDENTITY NOT NULL, 
  ConferenceDayID int NOT NULL, 
  InitialDate     date NOT NULL, 
  Price           money NOT NULL CHECK(Price > 0), 
  StudentDiscount real NOT NULL CHECK(StudentDiscount <= 1 AND StudentDiscount >= 0), 
  PRIMARY KEY CLUSTERED (PriceInfoID));
CREATE TABLE ConferenceDayReservations (
  ConferenceDayReservationID int IDENTITY NOT NULL, 
  ReservationDate            date NOT NULL, 
  ParticipantID              int NOT NULL, 
  ConferenceDayBookingID     int NOT NULL, 
  PRIMARY KEY CLUSTERED (ConferenceDayReservationID));
CREATE TABLE Participants (
  ParticipantID int IDENTITY NOT NULL, 
  FirstName     varchar(50) NOT NULL, 
  LastName      varchar(50) NOT NULL, 
  BirthDate     date NOT NULL, 
  Email         varchar(50) NOT NULL CHECK(Email LIKE '%_@_%._%'), 
  PRIMARY KEY CLUSTERED (ParticipantID));
CREATE TABLE Students (
  ParticipantID  int NOT NULL, 
  CardID         int NOT NULL, 
  ExpirationDate date NOT NULL, 
  PRIMARY KEY CLUSTERED (ParticipantID, 
  CardID));
CREATE TABLE WorkshopReservations (
  WorkshopReservationID      int IDENTITY NOT NULL, 
  ReservationDate            date NOT NULL, 
  WorkshopBookingID          int NOT NULL, 
  ConferenceDayReservationID int NOT NULL, 
  PRIMARY KEY CLUSTERED (WorkshopReservationID));
ALTER TABLE Conferences ADD CONSTRAINT FKConference324472 FOREIGN KEY (OrganizerID) REFERENCES Organizers (OrganizerID);
ALTER TABLE Buildings ADD CONSTRAINT FKBuildings784537 FOREIGN KEY (BuildingOwnerID) REFERENCES BuildingOwners (BuildingOwnerID);
ALTER TABLE Conferences ADD CONSTRAINT FKConference475199 FOREIGN KEY (BuildingID) REFERENCES Buildings (BuildingID);
ALTER TABLE PartnersForConferences ADD CONSTRAINT FKPartnersFo229207 FOREIGN KEY (PartnerID) REFERENCES Partners (PartnerID);
ALTER TABLE PartnersForConferences ADD CONSTRAINT FKPartnersFo611831 FOREIGN KEY (ConferenceID) REFERENCES Conferences (ConferenceID);
ALTER TABLE Rooms ADD CONSTRAINT FKRooms994958 FOREIGN KEY (BuildingID) REFERENCES Buildings (BuildingID);
ALTER TABLE Workshops ADD CONSTRAINT FKWorkshops151547 FOREIGN KEY (RoomID) REFERENCES Rooms (RoomID);
ALTER TABLE ConferenceDays ADD CONSTRAINT FKConference689988 FOREIGN KEY (ConferenceID) REFERENCES Conferences (ConferenceID);
ALTER TABLE Workshops ADD CONSTRAINT FKWorkshops976736 FOREIGN KEY (ConferenceDayID) REFERENCES ConferenceDays (ConferenceDayID);
ALTER TABLE EmployeesForConferenceDays ADD CONSTRAINT FKEmployeesF719312 FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID);
ALTER TABLE EmployeesForConferenceDays ADD CONSTRAINT FKEmployeesF764688 FOREIGN KEY (ConferenceDayID) REFERENCES ConferenceDays (ConferenceDayID);
ALTER TABLE Students ADD CONSTRAINT FKStudents971491 FOREIGN KEY (ParticipantID) REFERENCES Participants (ParticipantID);
ALTER TABLE ConferenceDayReservations ADD CONSTRAINT FKConference74141 FOREIGN KEY (ParticipantID) REFERENCES Participants (ParticipantID);
ALTER TABLE WorkshopReservations ADD CONSTRAINT FKWorkshopRe101140 FOREIGN KEY (ConferenceDayReservationID) REFERENCES ConferenceDayReservations (ConferenceDayReservationID);
ALTER TABLE WorkshopReservations ADD CONSTRAINT FKWorkshopRe592703 FOREIGN KEY (WorkshopBookingID) REFERENCES WorkshopBooking (WorkshopBookingID);
ALTER TABLE Payments ADD CONSTRAINT FKPayments321954 FOREIGN KEY (ConferenceDayBookingID) REFERENCES ConferenceDayBooking (ConferenceDayBookingID);
ALTER TABLE ConferenceDayBooking ADD CONSTRAINT FKConference310116 FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID);
ALTER TABLE Companies ADD CONSTRAINT FKCompanies259074 FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID);
ALTER TABLE ConferenceDayBooking ADD CONSTRAINT FKConference447239 FOREIGN KEY (ConferenceDayID) REFERENCES ConferenceDays (ConferenceDayID);
ALTER TABLE WorkshopBooking ADD CONSTRAINT FKWorkshopBo241185 FOREIGN KEY (ConferenceDayBookingID) REFERENCES ConferenceDayBooking (ConferenceDayBookingID);
ALTER TABLE ConferenceDayReservations ADD CONSTRAINT FKConference87939 FOREIGN KEY (ConferenceDayBookingID) REFERENCES ConferenceDayBooking (ConferenceDayBookingID);
ALTER TABLE WorkshopBooking ADD CONSTRAINT FKWorkshopBo808220 FOREIGN KEY (WorkshopID) REFERENCES Workshops (WorkshopID);
ALTER TABLE PriceInfo ADD CONSTRAINT FKPriceInfo736566 FOREIGN KEY (ConferenceDayID) REFERENCES ConferenceDays (ConferenceDayID);
ALTER TABLE Conferences ADD CONSTRAINT FKConference232345 FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID);



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

GO
CREATE FUNCTION IsStudent
(
	@ParticipantID int
)
RETURNS bit
AS
BEGIN
	DECLARE @IsStudent bit
	SET @IsStudent = (
		SELECT Count(CardID)
		FROM Students
		WHERE ParticipantID = @ParticipantID
	)
	RETURN @IsStudent
END


/* Author: Grzegorz Poręba */
GO
CREATE VIEW AvailableWorkshops
AS
  SELECT C.ConferenceName                              AS 'Conference name',
    W.WorkshopName                                     AS 'Workshop name',
    CD.Date                                            AS 'Workshop date',
    B.Address                                          AS 'Conference address',
    R.RoomName                                         AS 'Workshop Room',
    W.StartTime,
    W.EndTime,
    dbo.GetNumberOfFreePlacesForWorkshop(W.WorkshopID) AS 'Places left',
    W.Price,
    W.WorkshopID,
    CD.ConferenceDayID,
    C.ConferenceID
  FROM dbo.Workshops AS W
    INNER JOIN dbo.ConferenceDays AS CD
    ON W.ConferenceDayID = CD.ConferenceDayID
    INNER JOIN dbo.Conferences AS C
    ON CD.ConferenceID = C.ConferenceID
    INNER JOIN dbo.Buildings AS B
    ON C.BuildingID = B.BuildingID
    INNER JOIN dbo.Rooms AS R
    ON W.RoomID = R.RoomID
  WHERE (dbo.GetNumberOfFreePlacesForWorkshop(W.WorkshopID) > 0)

/* Author: Grzegorz Poręba */
GO
CREATE VIEW ParticipantsForConferenceDay
AS
  SELECT P.FirstName, P.LastName, P.ParticipantID, CB.ConferenceDayID, CB.CustomerID
  FROM dbo.ConferenceDayReservations AS CR
    INNER JOIN dbo.Participants
    AS P ON CR.ParticipantID = P.ParticipantID
    INNER JOIN dbo.ConferenceDayBooking
    AS CB ON CR.ConferenceDayBookingID = CB.ConferenceDayBookingID


/* Author: Mateusz Pawłowicz */
GO
CREATE VIEW ClientsWhoMustFullfilBookings
AS
  SELECT
    Customers.CustomerID,
    Customers.FirstName,
    Customers.Phone,
    Customers.LastName,
    Customers.Email,
    ConferenceDayBooking.PlacesReservedAmount AS [Places reserved],
    ConferenceDayBooking.BookingDate AS [Booking date],
    (SELECT COUNT (ConferenceDayReservationID) 
    FROM ConferenceDayReservations
    WHERE ConferenceDayBooking.ConferenceDayBookingID =   ConferenceDayReservations.ConferenceDayBookingID
  ) AS [Places assigned]
  FROM
    Customers INNER JOIN
    ConferenceDayBooking ON Customers.CustomerID = ConferenceDayBooking.CustomerID;



/* Author: Mateusz Pawłowicz */
GO
CREATE VIEW WorkshopBookingPayingInfo
AS
  SELECT
    WorkshopBooking.WorkshopBookingID,
    WorkshopBooking.ConferenceDayBookingID,
    WorkshopBooking.PlacesReservedAmount,
    count(WorkshopReservations.WorkshopReservationID) as 'PlacesAssigned',
    Workshops.Price as 'RegularPriceForPlace',
    count(Students.ParticipantID) as 'StudentsAmount',
    (cast(Workshops.Price* (count(WorkshopReservations.WorkshopReservationID)) as numeric(10,2))) as 'PriceForReservedPlaces',
    (Workshops.Price * WorkshopBooking.PlacesReservedAmount) as 'MaxExpectedPaymentForBooking'

  FROM
    WorkshopBooking INNER JOIN
    Workshops ON WorkshopBooking.WorkshopID = Workshops.WorkshopID LEFT JOIN
    ConferenceDayReservations ON WorkshopBooking.ConferenceDayBookingID = ConferenceDayReservations.ConferenceDayBookingID LEFT JOIN
    WorkshopReservations ON WorkshopBooking.WorkshopBookingID = WorkshopReservations.WorkshopBookingID INNER JOIN
    ConferenceDays ON Workshops.ConferenceDayID = ConferenceDays.ConferenceDayID  INNER JOIN
    Conferences ON ConferenceDays.ConferenceID = Conferences.ConferenceID LEFT JOIN
    Students ON( (ConferenceDayReservations.ParticipantID = Students.ParticipantID) AND (DATEDIFF(day,Conferences.StartDate,Students.ExpirationDate)>=0 ))
  GROUP BY WorkshopBooking.WorkshopBookingID, WorkshopBooking.PlacesReservedAmount, Workshops.Price, WorkshopBooking.ConferenceDayBookingID;

/* Author: Grzegorz Poręba */
GO
CREATE VIEW [dbo].[ImportantClients]
AS
SELECT dbo.Customers.CustomerID,
       dbo.Customers.FirstName,
       dbo.Customers.LastName,
       dbo.Customers.Phone,
       dbo.Customers.Email,
       dbo.IsCompany(Customers.CustomerID) AS IsCompany,
       SUM(dbo.ConferenceDayBooking.PlacesReservedAmount)
                                AS [Total places reserved],
       SUM(dbo.Payments.Amount) AS [Total Payments],
       COUNT(DISTINCT dbo.ConferenceDays.ConferenceID)
                                AS [Conferences participated]
FROM dbo.Customers
         INNER JOIN
     dbo.ConferenceDayBooking ON dbo.Customers.CustomerID = dbo.ConferenceDayBooking.CustomerID
         INNER JOIN
     dbo.Payments ON dbo.ConferenceDayBooking.ConferenceDayBookingID = dbo.Payments.ConferenceDayBookingID
         INNER JOIN
     dbo.ConferenceDays ON dbo.ConferenceDayBooking.ConferenceDayID = dbo.ConferenceDays.ConferenceDayID
GROUP BY dbo.Customers.CustomerID,  dbo.Customers.FirstName, dbo.Customers.LastName, dbo.Customers.Phone, dbo.Customers.Email

/* Author: Grzegorz Poręba */
GO
CREATE VIEW [dbo].[ParticipantsForWorkshops]
AS
SELECT P.ParticipantID, P.FirstName, P.LastName, WB.WorkshopBookingID
FROM dbo.WorkshopReservations AS WR
         INNER JOIN
     dbo.ConferenceDayReservations AS CR ON WR.ConferenceDayReservationID = CR.ConferenceDayReservationID
         INNER JOIN
     dbo.Participants AS P ON CR.ParticipantID = P.ParticipantID
         INNER JOIN
     dbo.WorkshopBooking AS WB ON WR.WorkshopBookingID = WB.WorkshopBookingID

/* Author: Mateusz Pawłowicz */
GO
CREATE VIEW ConferenceDayPayingInfo
AS
SELECT CDB.ConferenceDayBookingID, C.ConferenceID, CDB.ConferenceDayID, CDB.CustomerID, CDB.BookingDate,
        CDB.PlacesReservedAmount as 'BookedPlaces', COUNT(CDR.ConferenceDayReservationID) as 'PlacesAssigned',
        COUNT(S.ParticipantID) as 'Students', (CAST((PI.price * ((COUNT(CDR.ConferenceDayReservationID)
          - COUNT(S.ParticipantID) + COUNT(S.ParticipantID)*PI.StudentDiscount)) )as numeric(10,2))) as 'ConferenceDayActualPrice',
        (dbo.GetPriceStageForDate(CDB.BookingDate,CDB.ConferenceDayID)* CDB.PlacesReservedAmount) as 'ConferenceDayMaxExpectedPrice',
        (ISNULL(WI.ActualPrice,0)) as 'WorkshopActualPrice', (ISNULL(WI.MaxExpectedPrice,0)) as 'WorkshopMaxExpectedPrice'
FROM ConferenceDayBooking as CDB
    INNER JOIN ConferenceDays as CD 
        ON CD.ConferenceDayID = CDB.ConferenceDayID
    INNER JOIN Conferences as C
        ON CD.ConferenceID = C.ConferenceID
    LEFT JOIN ConferenceDayReservations as CDR 
        ON CDR.ConferenceDayBookingID = CDB.ConferenceDayBookingID
    LEFT JOIN Students as S 
        ON (CDR.ParticipantID = S.ParticipantID) AND (DATEDIFF(day, C.StartDate, S.ExpirationDate) >= 0)
    INNER JOIN PriceInfo as PI
        ON (PI.PriceInfoID = dbo.GetPriceInfoForDate(CDB.BookingDate,CDB.ConferenceDayID))
    LEFT JOIN (SELECT WBPI.ConferenceDayBookingID, SUM(WBPI.PriceForReservedPlaces) as 'ActualPrice',
                SUM(WBPI.MaxExpectedPaymentForBooking) as 'MaxExpectedPrice'
                FROM WorkshopBookingPayingInfo as WBPI
                GROUP BY WBPI.ConferenceDayBookingID) as WI
        ON CDB.ConferenceDayBookingID = WI.ConferenceDayBookingID
GROUP BY CDB.ConferenceDayBookingID, CDB.ConferenceDayID, CDB.CustomerID, CDB.BookingDate, CDB.PlacesReservedAmount,
          PI.Price, PI.StudentDiscount, C.ConferenceID, WI.ActualPrice, WI.MaxExpectedPrice

/* Author: Mateusz Pawłowicz */
GO
CREATE VIEW ConferencePayingInfo
AS
SELECT CustomerID, ConferenceID, cast((SUM(ConferenceDayActualPrice) + SUM(WorkshopActualPrice)) as numeric(10,2))
        as 'ActualPriceToPayForConference',
        cast((SUM(ConferenceDayMaxExpectedPrice) + SUM(WorkshopMaxExpectedPrice)) as numeric(10,2))
        as 'MaxExpectedPriceToPayForConference'
FROM ConferenceDayPayingInfo
GROUP BY CustomerID, ConferenceID



/* Author: Mateusz Pawłowicz */
GO
CREATE VIEW PaymentsDiffInfo
AS
SELECT P.ConferenceDayBookingID, CAST(SUM(P.Amount) as numeric(10,2)) as 'PaidMoney',
      CAST(CDPI.ConferenceDayActualPrice + CDPI.WorkshopActualPrice as numeric(10,2)) as 'ActualPriceToPay',
      CAST(CDPI.ConferenceDayMaxExpectedPrice + CDPI.WorkshopMaxExpectedPrice as numeric(10,2)) as 'MaxExpectedPriceToPay'
FROM Payments as P
    INNER JOIN ConferenceDayPayingInfo as CDPI
        ON P.ConferenceDayBookingID = CDPI.ConferenceDayBookingID
GROUP BY P.ConferenceDayBookingID ,(CDPI.ConferenceDayActualPrice + CDPI.WorkshopActualPrice),
          (CDPI.ConferenceDayMaxExpectedPrice + CDPI.WorkshopMaxExpectedPrice) 



		  
/* Author: Grzegorz Poręba */

GO
CREATE VIEW [dbo].[ClientsToCall]
AS
SELECT CI.ConferenceDayBookingID,
       CI.BookingDate,
       C.ConferenceID,
       C.StartDate,
       CI.BookedPlaces,
       CI.PlacesAssigned,
       ISNULL(PAI.PaidMoney, 0)  AS 'Paid money',
       CI.CustomerID,
       CL.FirstName                 AS 'Client name',
       CL.LastName                  AS 'Client surname',
       CL.phone                     AS 'Client phone',
       CL.email                     AS 'Client email',
       dbo.IsCompany(CL.CustomerID) AS 'Is company'
FROM dbo.ConferenceDayPayingInfo AS CI
         LEFT OUTER JOIN
     dbo.PaymentsDiffInfo AS PAI ON CI.ConferenceDayBookingID = PAI.ConferenceDayBookingID AND
                                    PAI.PaidMoney > CI.ConferenceDayActualPrice + CI.WorkshopActualPrice
         INNER JOIN
     dbo.ConferenceDayBooking AS CB ON CI.ConferenceDayBookingID = CB.ConferenceDayBookingID AND CB.isCancelled = 0
         INNER JOIN
     dbo.ConferenceDays AS CD ON CI.ConferenceDayID = CD.ConferenceDayID
         INNER JOIN
     dbo.Conferences AS C ON CD.ConferenceID = C.ConferenceID
         INNER JOIN
     dbo.Customers AS CL ON CI.CustomerID = CL.CustomerID
WHERE (DATEDIFF(day, GETDATE(), C.StartDate) <= 14)
  AND (DATEDIFF(day, GETDATE(), C.StartDate) >= 0)



GO
CREATE TRIGGER [dbo].[ForbidToSpecifyConferencesFromThePast]
    ON [dbo].[Conferences]
    AFTER INSERT, UPDATE AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @Date date = (SELECT StartDate
                          FROM inserted)
    IF ((DATEDIFF(day, GETDATE(), @Date) <= 0))
        BEGIN
            ;THROW 52000,'The conference is starting today or has already started! You can only specify future conferences.',1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[CheckForTwoTheSameConferenceDays]
    ON [dbo].[ConferenceDays]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @DayNumber int = (SELECT DayNumber
                              FROM inserted)
    DECLARE @ConferenceId int = (SELECT ConferenceID
                                 FROM inserted)
    IF ((SELECT COUNT(ConferenceDayID)
         FROM ConferenceDays
         WHERE (DayNumber = @DayNumber)
           AND (ConferenceID = @ConferenceId)) > 1)
        BEGIN
            DECLARE @message varchar(100) = 'Day ' + CAST(@DayNumber as varchar(3)) +
                                            ' has already been added for this conference';
            THROW 52000,@message,1
            ROLLBACK TRANSACTION
        END
END


GO
CREATE TRIGGER [dbo].[CheckIfConferenceDayNumberWithinDaysAmount]
    ON [dbo].[ConferenceDays]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @DayNumber int = (SELECT DayNumber
                              FROM inserted)
    DECLARE @ConferenceID int = (SELECT ConferenceID
                                 FROM inserted)
    DECLARE @DaysAmount int = (SELECT DaysAmount
                               FROM Conferences
                               WHERE ConferenceID = @ConferenceID)
    IF (@DayNumber not between 1 AND @DaysAmount)
        BEGIN
            DECLARE @message varchar(100) = 'For this conference has been specified only ' +
                                            CAST(@DaysAmount as varchar(3)) + ' days.';
            THROW 52000,@message,1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[StartHourBeforeEndHourWorkshops]
    ON [dbo].[Workshops]
    AFTER INSERT, UPDATE AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @start time(0) = (SELECT StartTime
                              FROM inserted)
    DECLARE @end time(0) = (SELECT EndTime
                            FROM inserted)
    IF ((SELECT DATEDIFF(minute, @start, @end)) < 5)
        BEGIN
            ;THROW 52000,'Workshop has to last at least 5 minutes.',1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[ParticipantAmountLessThanRoomCapacity]
    ON [dbo].[Workshops]
    AFTER INSERT, UPDATE AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @ParticipantLimit int = (SELECT ParticipantLimit
                              FROM inserted)
    DECLARE @RoomID int = (SELECT RoomID
                            FROM inserted)
    DECLARE @RoomCapacity int = (SELECT RoomCapacity
                            FROM Rooms
                            WHERE RoomID = @RoomID)
    IF (@RoomCapacity < @ParticipantLimit)
        BEGIN
            ;THROW 52000,'Cannot have more participants than it can contain people',1
            ROLLBACK TRANSACTION
        END
END



GO
CREATE TRIGGER [dbo].[WorkshopPlacessLessThanConferenceDayPlaces]
    ON [dbo].[Workshops]
    AFTER INSERT, UPDATE AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @WorkshopPlaces int = (SELECT ParticipantLimit
                                   FROM inserted)
    DECLARE @ConferenceDayPlaces int = (SELECT C.ParticipantLimit
                                        FROM inserted as I
                                                 INNER JOIN ConferenceDays as C ON I.ConferenceDayID = C.ConferenceDayID)
    IF (@WorkshopPlaces > @ConferenceDayPlaces)
        BEGIN
            ;THROW 52000,'For this workshop are more places than for conference day.',1
            ROLLBACK TRANSACTION
        END
END



GO
CREATE TRIGGER [dbo].[InitialDateBeforeConferation]
    ON [dbo].[PriceInfo]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @Date date = (SELECT InitialDate
                          FROM inserted)
    DECLARE @ConferenceStartingDay date = (SELECT C.StartDate
                                           FROM inserted as I
                                                    INNER JOIN ConferenceDays as CD ON I.ConferenceDayID = CD.ConferenceDayID
                                                    INNER JOIN Conferences as C ON CD.ConferenceID = C.ConferenceID)
    IF ((SELECT DATEDIFF(day, @Date, @ConferenceStartingDay)) < 0)
        BEGIN
            ;THROW 52000, 'This price stage is after conference has started.',1
            ROLLBACK TRANSACTION
        END
END



GO
CREATE TRIGGER [dbo].[OnePriceForOneDay]
    ON [dbo].[PriceInfo]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @InfoId int = (SELECT PriceInfoID
                           FROM inserted)
    DECLARE @Date date = (SELECT InitialDate
                          FROM inserted)
    DECLARE @ConferenceDayId int = (SELECT ConferenceDayID
                                    FROM inserted)
    IF exists(SELECT PriceInfoID
              FROM PriceInfo
              WHERE ((PriceInfoID <> @InfoId) AND (InitialDate = @Date) AND (ConferenceDayId = @ConferenceDayId)))
        BEGIN
            ;THROW 52000, 'There is already a price named for this conference day that expires at the same time.',1
            ROLLBACK TRANSACTION
        END
END



GO
CREATE TRIGGER [dbo].[ForbidToBookPlacesForFullConferenceDay]
    ON [dbo].[ConferenceDayBooking]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @ConferenceDayId int = (SELECT ConferenceDayBookingID
                                    FROM inserted)
    IF (dbo.GetNumberOfFreePlacesForConferenceDay(@ConferenceDayId) < 0)
        BEGIN
            DECLARE @FreePlaces int = dbo.GetNumberOfFreePlacesForConferenceDay(@ConferenceDayId) +
                                      (SELECT PlacesReservedAmount
                                       FROM inserted)
            DECLARE @message varchar(100) = 'There are only ' + CAST(@FreePlaces as varchar(10)) +
                                            ' places left for this conference day.';
            THROW 52000,@message,1
            ROLLBACK TRANSACTION
        END
END



GO
CREATE TRIGGER [dbo].[ForbidToBookPlacesForStartingConference]
    ON [dbo].[ConferenceDayBooking]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @ConferenceDayID int = (SELECT ConferenceDayID
                                    FROM inserted)
    DECLARE @Date date = (SELECT BookingDate
                          FROM inserted)
    DECLARE @ConferenceStartDay date = (SELECT StartDate
                                        FROM Conferences
                                        WHERE ConferenceID = (SELECT ConferenceID
                                                              FROM ConferenceDays
                                                              WHERE ConferenceDayID = @ConferenceDayID))
    IF ((DATEADD(DAY, -14, @ConferenceStartDay)) < @Date)
        BEGIN
            ;THROW 53000,'The conference is starting in less than two weeks. It is too late to book or update data.',1
            ROLLBACK TRANSACTION
        END
END



GO
CREATE TRIGGER [dbo].[ForbidToBookPlacesIfThereIsNoPriceStage]
    ON [dbo].[ConferenceDayBooking]
    AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @Date date = (SELECT BookingDate
                          FROM inserted)
    DECLARE @Conference_day_id int = (SELECT ConferenceDayID
                                      FROM inserted)
    IF (dbo.GetPriceStageForDate(@Date, @Conference_day_id) is null)
        BEGIN
            ;
            THROW 52000,'For this conference day there is no price stage at now. It maybe too late or to early too book places...',1
        END
END


GO
CREATE TRIGGER [dbo].[ForbidToNarrowDownPlacesReservedIfParticipantsAssigned]
    ON [dbo].[ConferenceDayBooking]
    AFTER UPDATE AS
BEGIN
    DECLARE @ConferenceDayBookingID int = (SELECT ConferenceDayBookingID
                                           FROM inserted)
    DECLARE @PlacesWanted int = (SELECT PlacesReservedAmount
                                 FROM inserted)
    DECLARE @PlacesSet int = (SELECT COUNT(ConferenceDayReservationID)
                              FROM ConferenceDayReservations
                              WHERE ConferenceDayReservationID = @ConferenceDayBookingID)
    IF (@PlacesSet > @PlacesWanted)
        BEGIN
            DECLARE @message varchar(100) =
                    'There is too many participants assigned to this booking. Amount of participants: ' +
                    CAST(@PlacesSet as varchar(10));
            THROW 52000,@message,1
            ROLLBACK TRANSACTION
        END
END


GO
CREATE TRIGGER [dbo].[ForbidToPayForCancelledBooking]
    ON [dbo].[Payments]
    AFTER INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @BookingID int = (SELECT ConferenceDayBookingID
                              FROM inserted)
    IF ((SELECT IsCancelled
         FROM ConferenceDayBooking
         WHERE ConferenceDayBookingID = @BookingID) = 1)
        BEGIN
            ;THROW 52000,'This booking has already been cancelled. You can not pay for it.',1
            ROLLBACK TRANSACTION
        END
END



GO
CREATE TRIGGER [dbo].[ForbidToAssingParticipantToCancelledBooking]
    ON [dbo].[ConferenceDayReservations]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @ConferenceDayBookingID int = (SELECT ConferenceDayBookingID
                                           FROM inserted)
    IF ((SELECT IsCancelled
         FROM ConferenceDayBooking
         WHERE ConferenceDayBookingID = @ConferenceDayBookingID) = 1)
        BEGIN
            ;THROW 52000,'This booking has been cancelled. So you cannot assign participant to it.',1
            ROLLBACK TRANSACTION
        END
END



GO
CREATE TRIGGER [dbo].[ForbidToOverreservePlacesForConferenceDay]
    ON [dbo].[ConferenceDayReservations]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @ConferenceDayBookingID int = (SELECT ConferenceDayBookingID
                                           FROM inserted)
    DECLARE @PlacesBooked int = (SELECT PlacesReservedAmount
                                 FROM ConferenceDayBooking
                                 WHERE ConferenceDayBookingID = @ConferenceDayBookingID)
    IF (@PlacesBooked < (SELECT COUNT(ConferenceDayReservationID)
                         FROM ConferenceDayReservations
                         WHERE (ConferenceDayBookingID = @ConferenceDayBookingID)))
        BEGIN
            ;THROW 53000, 'All places has been reserved for this booking',1
            ROLLBACK TRANSACTION
        END
END



GO
CREATE TRIGGER [dbo].[PKUniquePairsOnConference_day_reservations]
    ON [dbo].[ConferenceDayReservations]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @ParticipantID int = (SELECT ParticipantID
                                  FROM inserted)
    DECLARE @ConferenceDayBookingID int = (SELECT ConferenceDayBookingID
                                           FROM inserted)
    IF (1 < (SELECT COUNT(ConferenceDayReservationID)
             FROM ConferenceDayReservations
             WHERE (ConferenceDayBookingID = @ConferenceDayBookingID)
               AND (ParticipantID = @ParticipantID)))
        BEGIN
            ;THROW 55000, 'This participant has already reserved a place for this conference day from this client.',1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[CheckConferenceDaysForWorkshopBooking]
    ON [dbo].[WorkshopBooking]
    AFTER INSERT, UPDATE AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @BookingConferneceDayID int = (SELECT ConferenceDayBookingID
                                           FROM ConferenceDayBooking
                                           WHERE ConferenceDayBookingID = (SELECT ConferenceDayBookingID
                                                                           FROM inserted))
    DECLARE @WorkshopConferneceDayID int = (SELECT ConferenceDayID
                                            FROM Workshops
                                            WHERE WorkshopID = (SELECT WorkshopID
                                                                FROM inserted))
    IF (@BookingConferneceDayID <> @WorkshopConferneceDayID)
        BEGIN
            ;
            THROW 52000,'This workshop takes place in different conference day than the conference day for which conference day booking has been specified',1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[ForbidToBookPlacesForCancelledConferenceDayBooking]
    ON [dbo].[WorkshopBooking]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @ConferenceDayBookingID int = (SELECT ConferenceDayBookingID
                                           FROM inserted)
    IF ((SELECT IsCancelled
         FROM ConferenceDayBooking
         WHERE ConferenceDayBookingID = @ConferenceDayBookingID) = 1)
        BEGIN
            ;THROW 52000,'This conference day booking has been cancelled.',1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[ForbidToBookPlacesForFullWorkshop]
    ON [dbo].[WorkshopBooking]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @WorkshopID int = (SELECT WorkshopID
                               FROM inserted)
    IF (dbo.GetNumberOfFreePlacesForWorkshop(@WorkshopID) < 0)
        BEGIN
            DECLARE @FreePlaces int = dbo.GetNumberOfFreePlacesForWorkshop(@WorkshopID) + (SELECT PlacesReservedAmount
                                                                                           FROM inserted)
            DECLARE @message varchar(100) = 'There are only ' + CAST(@FreePlaces as varchar(10)) +
                                            ' places left for this workshop.';
            THROW 52000,@message,1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[PKUniquePairsOnWorkshop_booking]
    ON [dbo].[WorkshopBooking]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @ConferenceDayBookingID int = (SELECT ConferenceDayBookingID
                                           FROM inserted)
    DECLARE @WorkshopID int = (SELECT WorkshopID
                               FROM inserted)
    IF (1 < (SELECT COUNT(WorkshopBookingID)
             FROM WorkshopBooking
             WHERE (WorkshopBookingID = @WorkshopID)
               AND (ConferenceDayBookingID = @ConferenceDayBookingID)))
        BEGIN
            ;THROW 53000, 'This client has already booked some places which are assigned to this conference day booking',1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[ForbidToOverreservePlacesForWorkshop]
    ON [dbo].[WorkshopReservations]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @WorkshopBookingID int = (SELECT WorkshopReservationID
                                      FROM inserted)
    DECLARE @ConferenceDayReservationID int = (SELECT ConferenceDayReservationID
                                               FROM inserted)
    DECLARE @PlacesBooked int = (SELECT PlacesReservedAmount
                                 FROM WorkshopBooking
                                 WHERE WorkshopBookingID = @WorkshopBookingID)
    IF (@PlacesBooked < (SELECT COUNT(WorkshopReservationID)
                         FROM WorkshopReservations
                         WHERE (WorkshopBookingID = @WorkshopBookingID)))
        BEGIN
            ;THROW 53000, 'All places for this booking has been filled already',1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[PKUniquePairsOnWorkshop_reservations]
    ON [dbo].[WorkshopReservations]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @WorkshopBookingID int = (SELECT WorkshopBookingID
                                      FROM inserted)
    DECLARE @ConferenceDayReservationID int = (SELECT ConferenceDayReservationID
                                               FROM inserted)
    IF (1 < (SELECT COUNT(WorkshopReservationID)
             FROM WorkshopReservations
             WHERE (WorkshopReservationID = @WorkshopBookingID)
               AND (ConferenceDayReservationID = @ConferenceDayReservationID)))
        BEGIN
            ;THROW 53000, 'This participant has already booked a place for this workshop',1
            ROLLBACK TRANSACTION
        END
END

GO
CREATE TRIGGER [dbo].[ForbidToReservePlacesForSimultaneousWorkshops]
    ON [dbo].[WorkshopReservations]
    AFTER INSERT AS
BEGIN
    DECLARE @WorkshopID int = (SELECT WorkshopID
                               FROM WorkshopBooking
                               WHERE WorkshopBookingID = (SELECT WorkshopBookingID
                                                          FROM inserted))
    DECLARE @StartingHour time(0) = (SELECT StartTime
                                     FROM Workshops
                                     WHERE WorkshopID = @WorkshopID)
    DECLARE @EndHour time(0) = (SELECT EndTime
                                FROM Workshops
                                WHERE WorkshopID = @WorkshopID)
    DECLARE @ParticipantID int = (SELECT ParticipantID
                                  FROM ConferenceDayReservations
                                  WHERE ConferenceDayReservationID = (SELECT ConferenceDayReservationID
                                                                      FROM inserted))
    DECLARE @ConferenceDayReservationID int = (SELECT ConferenceDayReservationID
                                               FROM inserted)
    DECLARE @ConferenceDayID int = (SELECT ConferenceDayID
                                    FROM Workshops
                                    WHERE WorkshopID = @WorkshopID)
    DECLARE @tempWorkshopReservationID int
    DECLARE @tempWorkshopID int
    DECLARE @tempStartingHour time(0)
    DECLARE @tempEndHour time(0)
    --Choosing all workshops that participant is already going on this conference day
    DECLARE curs CURSOR LOCAL FOR (SELECT WR.WorkshopReservationID
                                   from Participants as P
                                            INNER JOIN ConferenceDayReservations as CR
                                                       ON P.ParticipantID = CR.ParticipantID
                                            INNER JOIN ConferenceDayBooking as CB
                                                       ON CB.ConferenceDayBookingID = CR.ConferenceDayBookingID
                                            INNER JOIN WorkshopReservations as WR
                                                       ON WR.ConferenceDayReservationID = CR.ConferenceDayReservationID
                                   WHERE (CB.ConferenceDayID = @ConferenceDayID)
                                     AND (P.ParticipantID = @ParticipantID))
    OPEN curs
    FETCH NEXT FROM curs INTO @tempWorkshopReservationID
    WHILE @@FETCH_STATUS = 0 BEGIN
        IF @tempWorkshopReservationID <> (SELECT WorkshopReservationID
                                          FROM inserted)
            BEGIN
                SET @tempWorkshopID = (SELECT WorkshopID
                                       FROM WorkshopBooking
                                       WHERE WorkshopBookingID = (SELECT WorkshopBookingID
                                                                  FROM WorkshopReservations
                                                                  WHERE WorkshopReservationID = @tempWorkshopReservationID))
                SET @tempStartingHour = (SELECT StartTime
                                         FROM Workshops
                                         WHERE WorkshopID = @tempWorkshopID)
                SET @tempEndHour = (SELECT EndTime
                                    FROM Workshops
                                    WHERE WorkshopID = @tempWorkshopID)
                IF (((@tempStartingHour > @StartingHour) AND (@tempStartingHour < @EndHour)) or
                    ((@tempEndHour > @StartingHour) AND (@tempEndHour < @EndHour)) or
                    ((@StartingHour > @tempStartingHour) AND (@StartingHour < @tempEndHour)) or
                    ((@EndHour > @tempStartingHour) AND (@EndHour < @tempEndHour)))
                    BEGIN
                        DECLARE @message varchar(100) = 'This participant is taking part in workshop: ' +
                                                        cast(@tempWorkshopID as varchar(20)) +
                                                        ' which is in the same time as requested workshop.'
                        CLOSE curs
                        DEALLOCATE curs;
                        THROW 54000, @message,1
                        ROLLBACK TRANSACTION
                    END
            END
        FETCH NEXT FROM curs INTO @tempWorkshopReservationID
    END
    CLOSE curs
    DEALLOCATE curs
END
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
		INSERT INTO Customers(FirstName,LastName,Email,Address, PostalCode, City, Country, Phone)
			VALUES (@FirstName, @LastName, @Email, @Address, @PostalCode, @City, @Country, @Phone)
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
CREATE PROCEDURE AddCompany
	@FirstName varchar(50),
	@LastName varchar(50),
	@Phone varchar(50),
	@Email varchar(50),
	@Address varchar(50),
	@PostalCode varchar(50),
	@City varchar(50),
	@Country varchar(50),
	@CompanyName varchar(50),
	@NIP varchar(50)
AS
BEGIN
	EXEC AddCustomer @FirstName, @LastName, @Email, @Address, @PostalCode, @City, @Country, @Phone
	DECLARE @CustomerID int = (SELECT TOP 1 CustomerID
								FROM Customers
								WHERE FirstName = @FirstName AND LastName = @LastName)
	EXEC AddCompanyData @CustomerID, @CompanyName, @NIP

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
CREATE PROCEDURE AddStudent
	@FirstName varchar(50),
	@LastName varchar(50),
	@BirthDate date,
	@Email varchar(50),
	@CardID int,
	@ExpirationDate date
AS
BEGIN
	EXEC AddParticipant @FirstName, @LastName, @BirthDate, @Email
	DECLARE @ParticipantID int = (SELECT TOP 1 ParticipantID
								FROM Participants
								WHERE FirstName = @FirstName AND LastName = @LastName)
	EXEC AddCompanyData @ParticipantID, @CardID, @ExpirationDate

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
		; THROW 52000,'Employee already assigned for other conference during that day',1
	END
	ELSE
	BEGIN
		INSERT INTO EmployeesForConferenceDays(EmployeeID,ConferenceDayID)
			VALUES(@EmployeeID, @ConferenceDayID)
	END
END

GO
CREATE PROCEDURE AssignPartnerToConference  
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
			DELETE FROM ConferenceDayReservations
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
CREATE PROCEDURE GEN_BookPlacesForWorkshop
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

GO
INSERT INTO Customers (FirstName, LastName, Phone, Email, Address, PostalCode, City, Country)
VALUES ('Neville', 'Walker', '146986341', 'Etiam@tellusid.net', 'Ap #389-9512 Neque St.', 'Z2440', 'l Ecluse',
        'Cocos (Keeling) Islands'),
       ('Wyoming', 'Mcdonald', '404880626', 'suscipit.nonummy@diamloremauctor.com', 'P.O. Box 171, 2839 Ut Ave',
        '7538 HL', 'Belém', 'Australia'),
       ('Rae', 'Schneider', '043207048', 'lobortis@condimentumDonec.ca', '966-8121 In Road', '7979 AJ',
        'Marcq-en-Baroeul', 'Comoros'),
       ('Xena', 'Carr', '7727386', 'porttitor.vulputate@Utsagittislobortis.edu', 'P.O. Box 613, 6607 At St.',
        '73957', 'Meerhout', 'Dominican Republic'),
       ('Emery', 'Davidson', '512516479', 'magna.Ut.tincidunt@orcitincidunt.edu', '194-771 Venenatis Av.', 'Y8X 8A5',
        'Acerra', 'Kiribati'),
       ('Kellie', 'Kirby', '3769322', 'Cum.sociis.natoque@molestie.edu', '8302 Donec Rd.', '493656', 'Ilhéus',
        'Saint Kitts and Nevis'),
       ('Sydnee', 'Avila', '1334044', 'nulla.Integer@mauris.edu', 'Ap #700-6742 Interdum Ave', '856448', 'Kitscoty',
        'Greece'),
       ('Whoopi', 'Whitehead', '3140039', 'tempor.arcu.Vestibulum@blanditatnisi.co.uk', '8706 Luctus Street', '81324',
        'Saint-Étienne-du-Rouvray', 'Iraq'),
       ('Victoria', 'Jefferson', '412726091', 'rutrum@Nullamfeugiatplacerat.co.uk', 'P.O. Box 456, 5596 Lobortis St.',
        '2786', 'Contagem', 'Saint Vincent and The Grenadines'),
       ('Adrienne', 'Morales', '608554553', 'sapien@lacusQuisquepurus.co.uk', '2574 Amet Av.', '33801',
        'Sint-Martens-Bodegem', 'Mauritius');
INSERT INTO Customers (FirstName, LastName, Phone, Email, Address, PostalCode, City, Country)
VALUES ('Nicole', 'Snider', '4853240', 'accumsan.convallis.ante@magna.net', 'Ap #979-852 Justo. Ave', '12781',
        'Santa Maria a Monte', 'Chile'),
       ('Autumn', 'Ballard', '2258977', 'in.aliquet@arcu.org', '2584 Tristique Road', '4523 ZU', 'Zipaquirá',
        'Hong Kong'),
       ('Cheyenne', 'Mcdowell', '8218912', 'tristique@molestiedapibusligula.com', '289-3582 Quis, Avenue', '231969',
        'Brampton', 'Timor-Leste'),
       ('Whitney', 'Daniel', '6407974', 'odio.Etiam.ligula@Donecfelisorci.org', 'Ap #912-7289 Gravida Av.', '5423',
        'Macul', 'Montenegro'),
       ('Kylie', 'Walker', '182665434', 'et@Donecvitae.co.uk', '263-2852 Dolor. Av.', '48352', 'Rahim Yar Khan',
        'Libya'),
       ('Maya', 'Chang', '7217639', 'tristique.neque@Duisa.co.uk', 'Ap #360-100 Ultricies St.', '64299',
        'Ospedaletto d Alpinolo', 'Panama'),
       ('Sacha', 'Richard', '7400584', 'Curabitur@magnatellusfaucibus.co.uk', 'Ap #255-9957 Adipiscing St.', '9599',
        'Hawick', 'Benin'),
       ('Emerald', 'Lawrence', '375723433', 'tristique@ligula.edu', 'Ap #157-6345 Felis Rd.', '6749 GK', 'Naumburg',
        'Gibraltar'),
       ('Jin', 'Townsend', '907888838', 'nulla@commodotinciduntnibh.net', '1071 Luctus Road', '710496', 'Socchieve',
        'Mongolia'),
       ('Moses', 'Alford', '960814577', 'augue@nisl.co.uk', '8995 Lacinia St.', '63401', 'Varanasi', 'Fiji');
INSERT INTO Customers (FirstName, LastName, Phone, Email, Address, PostalCode, City, Country)
VALUES ('Abel', 'Garcia', '9762375', 'Donec@vulputatemauris.co.uk', '4699 Euismod Rd.', '83881-901', 'Ajaccio',
        'Saudi Arabia'),
       ('Ralph', 'Huff', '8257523', 'tincidunt@auctor.co.uk', 'P.O. Box 597, 6365 Arcu Street', '19937', 'Höchst',
        'Azerbaijan'),
       ('Jenna', 'Bowers', '757550159', 'nec.luctus@loremluctus.co.uk', '175-5580 A, Ave', '64-662', 'Rixensart',
        'United Arab Emirates'),
       ('Catherine', 'Bennett', '8129905', 'risus.Nunc.ac@dui.ca', 'P.O. Box 616, 1655 Porttitor Street', '108586',
        'Bois-de-Villers', 'Guernsey'),
       ('Britanni', 'Lancaster', '9532003', 'ac.feugiat.non@nonummyipsum.com', 'P.O. Box 979, 6689 Eget St.', '93104',
        'Berbroek', 'Togo'),
       ('Kuame', 'Gilliam', '9240225', 'ultricies.adipiscing.enim@ridiculus.com', '907-3791 Nibh. Ave', '6035', 'Ponti',
        'El Salvador'),
       ('Jacqueline', 'Villarreal', '2461755', 'et.netus.et@liberonecligula.ca', '366-2800 Proin Av.', '6594 DH',
        'MŽlin', 'Saudi Arabia'),
       ('Hedwig', 'Sanders', '4269834', 'odio.tristique.pharetra@lacus.com', '890-5206 Adipiscing Rd.', '91185',
        'Matamata', 'British Indian Ocean Territory'),
       ('Constance', 'Hendrix', '8212541', 'non.nisi@nislsem.com', 'Ap #743-6939 Enim, Ave', '3442', 'Lunel',
        'Mauritius'),
       ('Zia', 'Pitts', '3105593', 'a@eleifendnec.org', 'P.O. Box 231, 4089 Elit, Avenue', '2903', 'Bergama',
        'Algeria');
INSERT INTO Customers (FirstName, LastName, Phone, Email, Address, PostalCode, City, Country)
VALUES ('Teegan', 'Marks', '757036428', 'vitae.nibh@eunequepellentesque.co.uk', 'Ap #471-3814 Cum Avenue', '76949',
        'Kaliningrad', 'South Sudan'),
       ('Hayden', 'Love', '985662829', 'sit@parturient.edu', 'Ap #615-1866 Elit, Rd.', '8012', 'Courcelles',
        'Åland Islands'),
       ('Brock', 'Phillips', '767164915', 'nunc.nulla@erat.edu', '3141 Mauris Av.', '78573', 'Arlon',
        'South Georgia and The South Sandwich Islands'),
       ('Kerry', 'Stark', '381106566', 'porttitor.tellus.non@imperdiet.edu', '801-1758 Morbi St.', '1799', 'San Andrés',
        'Finland'),
       ('Angela', 'Gibbs', '189636917', 'dis.parturient.montes@penatibuset.edu',
        'P.O. Box 592, 4842 Consectetuer Street', 'Z1498', 'Cognelee', 'Saint Lucia'),
       ('Roanna', 'Garner', '201004931', 'primis@mauris.co.uk', 'P.O. Box 884, 2460 Auctor. Av.', '60508', 'Pukekohe',
        'Kazakhstan'),
       ('Wynne', 'Pacheco', '037749617', 'a.odio@purusinmolestie.net', 'Ap #319-3308 Molestie Av.', '70-046', 'Lipetsk',
        'Ukraine'),
       ('Dillon', 'Rasmussen', '286115382', 'eget@loremluctus.com', '279-7478 Felis. Street', '64-284', 'Barranquilla',
        'Papua New Guinea'),
       ('Trevor', 'Gonzales', '330953079', 'metus.sit@variusultricesmauris.co.uk', '208-6793 Nisi Rd.', '995080',
        'Istres', 'Guernsey'),
       ('Ann', 'Savage', '9827422', 'tincidunt.adipiscing@Lorem.net', 'Ap #589-212 Lorem St.', '444578',
        'Monte Vidon Corrado', 'Norfolk Island');
INSERT INTO Customers (FirstName, LastName, Phone, Email, Address, PostalCode, City, Country)
VALUES ('Natalie', 'Ball', '0914917', 'eget.massa.Suspendisse@ornareliberoat.ca', 'P.O. Box 273, 416 Diam. St.',
        '984211', 'Fredericton', 'Greenland'),
       ('Ali', 'Blackwell', '095897012', 'non@Etiam.edu', 'Ap #674-6251 Orci Av.', '680934', 'Ramsey', 'China'),
       ('Daria', 'Cain', '595952651', 'Proin.dolor@amet.edu', 'P.O. Box 669, 4898 Curabitur Av.', 'Z7062', 'Liers',
        'Macao'),
       ('Grady', 'Daniels', '2139335', 'dictum.Proin@ametmassaQuisque.org', 'Ap #405-6463 Faucibus Ave', 'Z0978',
        'Bursa', 'Cayman Islands'),
       ('Taylor', 'Dunn', '7524816', 'augue.eu.tempor@loremsemper.net', '6209 In Ave', 'P6V 6W5', 'Pskov',
        'Martinique'),
       ('Kennedy', 'Vang', '9728595', 'Praesent@Donectincidunt.ca', 'Ap #509-3934 Mi St.', '644867', 'A Coruña',
        'Angola'),
       ('Austin', 'Holder', '6693751', 'Nunc.sollicitudin.commodo@Innecorci.ca', 'Ap #119-5452 Egestas. Road', '51501',
        'Mango', 'Belarus'),
       ('Kevin', 'Taylor', '1744368', 'non.egestas.a@ProinmiAliquam.com', '1161 Sagittis Ave', '9286', 'Autre-Eglise',
        'Vanuatu'),
       ('Claudia', 'Heath', '507498714', 'nisl.Maecenas@Suspendisse.org', '395-8907 Fermentum Avenue', '9040', 'Vucht',
        'Gambia'),
       ('Hermione', 'Strong', '327224054', 'convallis.ligula.Donec@nibh.edu', '3132 Elit. St.', 'N5Z 0X9',
        'Corvino San Quirico', 'Qatar');
INSERT INTO Customers (FirstName, LastName, Phone, Email, Address, PostalCode, City, Country)
VALUES ('Emery', 'Miller', '337722265', 'tempor@Fusce.ca', 'P.O. Box 104, 200 Nullam St.', '488165', 'Solesino',
        'Australia'),
       ('Shaine', 'Walters', '319198792', 'magna.Suspendisse.tristique@malesuadafamesac.org',
        'Ap #477-4567 Mollis Street', '7293', 'Burlington', 'Denmark'),
       ('Ariana', 'Brewer', '5431424', 'non@dolordapibus.edu', 'Ap #282-7208 Cursus St.', '759684', 'New Glasgow',
        'Namibia'),
       ('Shad', 'Scott', '219882500', 'mollis@facilisisfacilisismagna.net', '110-574 Nec, Avenue', '4549', 'Laramie',
        'India'),
       ('Magee', 'Byrd', '967838668', 'Mauris@laoreetliberoet.ca', '5991 Curabitur Road', '9296', 'Rutland',
        'New Caledonia'),
       ('Vernon', 'Shields', '218113488', 'enim.nisl.elementum@sem.net', 'Ap #241-8566 Morbi Av.', '69420', 'Emden',
        'Christmas Island'),
       ('Ria', 'Dominguez', '0778605', 'pharetra.ut.pharetra@urnanec.net', '408-4733 Facilisis St.', '6256',
        'Martello/Martell', 'Morocco'),
       ('Wade', 'Camacho', '8230326', 'Cras.dictum.ultricies@Donecdignissim.com', '2033 Egestas, Ave', '396868',
        'Columbus', 'Fiji'),
       ('Sopoline', 'Lester', '1488295', 'ultrices.a@pharetranibh.com', '591-1131 Neque Ave', '69413-896', 'Bothey',
        'Antigua and Barbuda'),
       ('Stephen', 'Schneider', '631696872', 'eleifend@amet.net', 'P.O. Box 188, 9921 Rhoncus. Ave', '70500',
        'Shawville', 'El Salvador');
INSERT INTO Customers (FirstName, LastName, Phone, Email, Address, PostalCode, City, Country)
VALUES ('Chiquita', 'Mccullough', '7765039', 'tincidunt.tempus.risus@dolorsitamet.edu', 'P.O. Box 514, 5011 Morbi Rd.',
        '4223', 'Sint-Pauwels', 'Yemen'),
       ('Casey', 'Hurley', '3406108', 'ut.ipsum@sed.edu', '7126 Auctor St.', '70011', 'Trevignano Romano', 'Macedonia'),
       ('Charissa', 'Tyson', '2719151', 'ac.arcu@euodioPhasellus.edu', '4473 Quisque Road', '2090', 'Ross-on-Wye',
        'Maldives'),
       ('Bert', 'Castillo', '4602821', 'libero.Proin.sed@odio.org', 'Ap #518-5781 Tellus Rd.', '61558-586', 'Goulburn',
        'Macedonia'),
       ('Sloane', 'Guerra', '103770823', 'Donec.porttitor@dolor.co.uk', 'P.O. Box 444, 5300 Nunc Avenue', '98-211',
        'Ludwigsfelde', 'Costa Rica'),
       ('Imani', 'Cherry', '185257716', 'a@Donectemporest.ca', 'P.O. Box 377, 578 Fringilla Rd.', '9727', 'Jumet',
        'Russian Federation'),
       ('Travis', 'Stewart', '647006499', 'nostra@atarcu.org', 'Ap #714-6543 Ultrices St.', '425606', 'Melton Mowbray',
        'Romania'),
       ('Inez', 'Nguyen', '2458683', 'varius.orci.in@libero.co.uk', '4562 At St.', '9325', 'Turgutlu', 'China'),
       ('Justina', 'Nieves', '7306116', 'scelerisque.dui@antelectusconvallis.com', '613-8919 Quis Road', '37112',
        'Merbes-le-Ch‰teau', 'Trinidad and Tobago'),
       ('Zena', 'Harvey', '3715111', 'arcu.Vestibulum.ante@nuncinterdum.org', 'Ap #329-9439 Parturient St.', '983643',
        'Halifax', 'Armenia');
SET IDENTITY_INSERT Companies ON
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (50, 1, 'Douglas Inc', '042167777');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (18, 2, 'Kiehn, Pouros and Schoen', '044640330');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (54, 3, 'Gleichner-Stanton', '966898001');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (53, 4, 'Von Inc', '378906983');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (38, 6, 'Wilkinson-Moore', '736813422');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (61, 8, 'Ankunding-Padberg', '205427088');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (20, 9, 'McLaughlin Inc', '879539447');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (8, 10, 'Quitzon, Lakin and Goodwin', '917541053');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (14, 12, 'Gutmann and Sons', '129238246');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (42, 13, 'Steuber and Sons', '037890390');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (45, 14, 'Doyle, Thompson and Sporer', '808281659');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (44, 15, 'Larson LLC', '223826208');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (43, 16, 'Emard-Ankunding', '819628053');
insert into Companies (CustomerID, CompanyID, CompanyName, NIP) values (36, 17, 'Nikolaus-Predovic', '159368466');
SET IDENTITY_INSERT Companies OFF 
SET IDENTITY_INSERT Partners ON
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (1, 'Toy Group', 'Cleaning', '1384269295', '32143 Stone Corner Lane', '2234', 'Gafargaon', 'Bangladesh');
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (2, 'O''Kon Group', 'Cleaning', '4623840632', '7 Northridge Avenue', '4775-446', 'Nine', 'Portugal');
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (3, 'Dibbert-Dooley', 'Security', '4695364269', '3994 Nancy Street', 'WF9', 'Buurhakaba', 'Somalia');
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (4, 'West, Blanda and Boyle', 'Security', '3088270682', '02 Carioca Alley', '56017', 'Žiežmariai', 'Lithuania');
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (5, 'West LLC', 'Cleaning', '8538069629', '233 Old Gate Lane', '10801', 'Bayan Gol', 'China');
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (6, 'Beatty-Heaney', 'Tech support', '6902205664', '9 Hanover Place', '45075 CEDEX 2', 'Orléans', 'France');
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (7, 'Kling LLC', 'Tech support', '7413049639', '1 Hallows Terrace', '452056', 'Phnom Penh', 'Cambodia');
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (8, 'Volkman Inc', 'Cleaning', '2135041189', '2 Bonner Court', '1255', 'Maindang', 'Philippines');
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (9, 'Lueilwitz Group', 'Car rental', '6196093885', '0 Coolidge Crossing', '253-0041', 'Dashtobod', 'Uzbekistan');
insert into Partners (PartnerID, CompanyName, PartnerCategory, Phone, Address, PostalCode, City, Country) values (10, 'Schinner LLC', 'Tech support', '3715744350', '27281 Autumn Leaf Terrace', '89110-000', 'Tuanjie', 'China');
SET IDENTITY_INSERT Partners OFF
SET IDENTITY_INSERT Organizers ON
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (1, 'Keebler, Padberg and Zemlak', '1994285678', '5580 Norway Maple Pass', 'Tanzania', 'Kyaka', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (2, 'Treutel, Halvorson and Berge', '5791447449', '3 Hoepker Place', 'Poland', 'Dziewin', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (3, 'Steuber Group', '8408650732', '8 Northridge Street', 'China', 'Yangchao', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (4, 'Stoltenberg LLC', '1141053410', '0957 Autumn Leaf Park', 'Philippines', 'Basiao', '5806');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (5, 'Wintheiser Group', '8453952683', '158 Shelley Pass', 'Philippines', 'Pagsabangan', '3318');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (6, 'Welch LLC', '4275884228', '976 La Follette Park', 'Madagascar', 'Fianarantsoa', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (7, 'Terry, Pacocha and Mueller', '4901377156', '4617 Park Meadow Terrace', 'China', 'Yangxu', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (8, 'Ritchie-Rice', '6065610733', '358 Sachs Drive', 'China', 'Gunziying', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (9, 'Stamm-Hickle', '8051689296', '2 Quincy Center', 'Armenia', 'Getahovit', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (10, 'Stiedemann, Bradtke and Effertz', '1165885889', '4453 Village Green Hill', 'Poland', 'Krzynowłoga Mała', '06-316');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (11, 'Nikolaus, Beer and O''Connell', '4477442652', '978 7th Alley', 'China', 'Anwen', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (12, 'Okuneva Group', '5733295665', '443 Cordelia Street', 'Thailand', 'Nong Chik', '94170');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (13, 'King, Pollich and Howe', '5224813172', '695 Lillian Alley', 'Bangladesh', 'Khulna', '9242');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (14, 'Doyle-Turcotte', '8545841346', '4 Almo Center', 'Sweden', 'Bromma', '168 58');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (15, 'Wolf LLC', '7753620406', '43099 Holy Cross Court', 'Dominican Republic', 'Cotuí', '10210');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (16, 'McCullough-Bogisich', '8285835187', '578 Orin Circle', 'Ukraine', 'Krasnosilka', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (17, 'Collins and Sons', '7117540204', '63 Debs Alley', 'Indonesia', 'Leran Kulon', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (18, 'Wisozk and Sons', '7836737187', '5635 Fieldstone Place', 'Philippines', 'Bacag', '8603');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (19, 'Bosco, Borer and Zieme', '5469369011', '6774 Carpenter Junction', 'Thailand', 'Tha Bo', '43110');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (20, 'Barton LLC', '5358790393', '0 Ramsey Circle', 'Brazil', 'Pelotas', '96000-000');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (21, 'Cummerata, Wisozk and Heathcote', '1069250091', '05 Morning Parkway', 'Portugal', 'Boleiros', '2495-313');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (22, 'Hickle-Batz', '7489749859', '46441 Monument Point', 'Indonesia', 'Sabang', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (23, 'Oberbrunner, Miller and Wisoky', '8001503150', '95 Spohn Place', 'Costa Rica', 'Esquipulas', '20706');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (24, 'Shields Inc', '6896082290', '9 Oriole Terrace', 'Venezuela', 'Ciudad Guayana', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (25, 'Metz-Cummings', '8592176025', '9 Waxwing Junction', 'China', 'Jiamaogong', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (26, 'Ward Group', '5303152466', '9088 Mcguire Place', 'Pakistan', 'Lakki Marwat', '28420');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (27, 'Mitchell, Schimmel and Schaden', '5023896487', '6183 Park Meadow Park', 'Tajikistan', 'Vakhsh', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (28, 'Rohan LLC', '1611036737', '2 Di Loreto Place', 'Colombia', 'La Victoria', '155007');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (29, 'Douglas, Murphy and Green', '5891002383', '001 Jenifer Point', 'Russia', 'Knyaginino', '606340');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (30, 'Boyle-Leannon', '6201356202', '667 Anzinger Trail', 'Comoros', 'Mirontsi', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (31, 'Schuppe, Jacobs and Beatty', '6989327109', '809 Helena Lane', 'China', 'Guanyinsi', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (32, 'Morissette-Pouros', '4284356903', '54181 Hollow Ridge Trail', 'Uzbekistan', 'Quva', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (33, 'Bode, Hickle and Torphy', '7899740035', '09877 Myrtle Center', 'Philippines', 'Looc', '5507');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (34, 'Upton-Senger', '2664731862', '13216 Bowman Circle', 'Honduras', 'Gracias', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (35, 'Bergnaum, Graham and Hagenes', '6463828722', '8 Mallory Road', 'Canada', 'La Sarre', 'J9Z');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (36, 'McGlynn-Williamson', '1169884513', '0 Prairieview Crossing', 'Philippines', 'Talalora', '6719');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (37, 'Johns and Sons', '4514323956', '807 Banding Junction', 'Philippines', 'Talisay', '4602');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (38, 'Adams, Stoltenberg and Walsh', '9754724997', '1707 Starling Point', 'China', 'Litan', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (39, 'Bergnaum-Schmitt', '7267897729', '97 Hooker Park', 'Indonesia', 'Sendang', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (40, 'Oberbrunner Inc', '6289448656', '4503 Washington Avenue', 'Madagascar', 'Ambarakaraka', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (41, 'Marvin, Hilll and Pfeffer', '3825307252', '0129 Toban Terrace', 'Peru', 'Cajacay', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (42, 'Cronin-Bernhard', '3886344919', '87292 Debra Avenue', 'China', 'Hongzhou', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (43, 'Koss, Bode and Cormier', '1261606580', '5 Loomis Way', 'Indonesia', 'Modis', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (44, 'Murray and Sons', '6025395664', '6361 Novick Junction', 'Greece', 'Néa Filadélfeia', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (45, 'Mann-Ryan', '2004321524', '22446 Colorado Hill', 'Ukraine', 'Kozelets’', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (46, 'Feil-Ullrich', '3232916890', '618 Dorton Way', 'United States', 'Long Beach', '90805');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (47, 'Lind Inc', '9238861863', '02 Huxley Drive', 'Peru', 'Otuzco', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (48, 'Cronin LLC', '9191079715', '076 Stoughton Hill', 'China', 'Pinglumiao', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (49, 'Abernathy-Botsford', '3811493692', '1 Lukken Plaza', 'Israel', 'Yehud', '32-708');
insert into Organizers (OrganizerID, CompanyName, Phone, Address, Country, City, PostalCode) values (50, 'Von and Sons', '8709115528', '62 Oak Valley Alley', 'Russia', 'Starobelokurikha', '659633');
SET IDENTITY_INSERT Organizers OFF
SET IDENTITY_INSERT BuildingOwners ON
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (1, 'Larkin-Wolff', '7048601607', '29 Coleman Junction', 'Poland', 'Osiedle-Nowiny', '93-154');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (2, 'Friesen-Stamm', '3315799706', '925 Vera Place', 'Poland', 'Brzączowice', '32-447');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (3, 'Dibbert LLC', '8109607203', '2035 Donald Road', 'Poland', 'Sępólno Krajeńskie', '89-400');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (4, 'Fadel Inc', '1931299757', '8852 Farragut Lane', 'Poland', 'Milicz', '56-300');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (5, 'Jenkins, Abbott and Bode', '1471239006', '3 Chive Alley', 'Poland', 'Malbork', '82-210');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (6, 'Lang LLC', '8447566389', '32539 Mallory Junction', 'Poland', 'Tomaszów Mazowiecki', '97-280');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (7, 'Hansen, Osinski and Schuster', '4218462361', '1 Coleman Terrace', 'Poland', 'Budziszewice', '97-212');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (8, 'Senger, Kunze and Morar', '3799524408', '85002 Northview Road', 'Poland', 'Lisia Góra', '33-140');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (9, 'Treutel-Christiansen', '6151847224', '830 Pond Road', 'Poland', 'Spytkowice', '34-745');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (10, 'Herman, Miller and Grady', '1546534251', '8 Rigney Drive', 'Poland', 'Ząbkowice Śląskie', '57-201');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (11, 'Feil, Schmidt and Connelly', '5629308034', '504 Loftsgordon Pass', 'Poland', 'Fajsławice', '21-060');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (12, 'O''Connell-Ebert', '5751126314', '42206 Green Plaza', 'Poland', 'Chybie', '43-520');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (13, 'Rohan, Kilback and Boehm', '4763221410', '177 Harper Junction', 'Poland', 'Wodzierady', '98-105');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (14, 'Reinger-Johnston', '3201247402', '697 Goodland Center', 'Poland', 'Gubin', '66-635');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (15, 'Rowe Inc', '2116794628', '525 Delaware Junction', 'Poland', 'Czerniewice', '97-216');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (16, 'Kris, Gibson and McLaughlin', '2481365142', '612 Sullivan Plaza', 'Poland', 'Kłoczew', '08-550');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (17, 'Green-Schulist', '8213687348', '47107 Bultman Circle', 'Poland', 'Dziemiany', '83-425');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (18, 'Gutmann and Sons', '2803628121', '235 Green Crossing', 'Poland', 'Dębica', '39-210');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (19, 'Rolfson, Thiel and Russel', '7479432033', '379 Elka Trail', 'Poland', 'Trzemeszno', '62-240');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (20, 'Ziemann Group', '3173805884', '534 Hallows Court', 'Poland', 'Skorogoszcz', '49-345');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (21, 'Schamberger-Strosin', '8832185779', '293 Sunfield Point', 'Poland', 'Kołczygłowy', '77-140');
insert into BuildingOwners (BuildingOwnerID, CompanyName, Phone, Address, Country, City, PostalCode) values (22, 'Langworth-Keebler', '1622739104', '4 Melby Junction', 'Poland', 'Grzęska', '37-240');
SET IDENTITY_INSERT BuildingOwners OFF
SET IDENTITY_INSERT Buildings ON
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (1, '361 Golf Course Way', '6461493557', 2);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (2, '216 Annamark Center', '8098880332', 8);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (3, '93366 Dennis Point', '8135459681', 21);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (4, '68913 American Ash Avenue', '8642230766', 18);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (5, '1 Menomonie Lane', '4267768235', 22);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (6, '98 Division Center', '9864979825', 1);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (7, '24 Tennyson Pass', '1121801449', 14);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (8, '59 Vernon Crossing', '9509507067', 15);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (9, '4882 Express Hill', '1829158555', 10);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (10, '8021 Milwaukee Pass', '3515967207', 8);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (11, '79569 Loomis Crossing', '5831881778', 13);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (12, '3 Rieder Point', '1014734354', 15);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (13, '5 Waywood Court', '3506733394', 20);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (14, '23 Fulton Circle', '8154321406', 17);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (15, '7998 Nancy Hill', '6397735817', 20);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (16, '262 8th Hill', '5084481625', 14);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (17, '3284 School Alley', '6932464265', 15);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (18, '41 Continental Junction', '8692222988', 2);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (19, '31 Bellgrove Court', '3023364056', 17);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (20, '9248 Michigan Avenue', '5061415000', 3);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (21, '5 Gina Road', '4085942802', 4);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (22, '22246 Valley Edge Hill', '3671025596', 1);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (23, '594 Lukken Place', '1496843778', 22);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (24, '652 Debra Trail', '9688233183', 16);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (25, '5 Anderson Road', '8694597928', 20);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (26, '82 Marcy Circle', '2085264337', 17);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (27, '50 Hovde Circle', '9102043119', 20);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (28, '047 Washington Court', '2279435609', 17);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (29, '8 Elka Drive', '7842205461', 13);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (30, '8562 John Wall Park', '6183325372', 10);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (31, '99355 Sachtjen Lane', '4471021817', 13);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (32, '30890 Rowland Drive', '3777659392', 2);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (33, '492 Dexter Road', '2069226378', 10);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (34, '28262 Gulseth Pass', '4916403734', 10);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (35, '76 Village Center', '5264729902', 20);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (36, '878 Fairview Junction', '7401776050', 17);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (37, '3 Kingsford Center', '5895918267', 19);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (38, '46561 Petterle Park', '9842255750', 17);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (39, '95 Summerview Lane', '6194735872', 14);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (40, '487 Carpenter Lane', '3181791386', 14);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (41, '04 Harbort Way', '6267081476', 11);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (42, '6302 Marcy Lane', '4718180756', 2);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (43, '3779 Marcy Parkway', '9958942959', 18);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (44, '39615 Caliangt Lane', '4783451927', 3);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (45, '3 Vera Center', '4118981780', 20);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (46, '7568 Haas Way', '6424789522', 9);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (47, '936 Schlimgen Road', '8363401595', 22);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (48, '5348 Michigan Court', '4158564477', 17);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (49, '2 David Hill', '9957574067', 13);
insert into Buildings (BuildingID, Address, ContactPhone, BuildingOwnerID) values (50, '2319 Sauthoff Court', '1065253059', 9);
SET IDENTITY_INSERT Buildings OFF
SET IDENTITY_INSERT Rooms ON
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (1,'08D',35,9),(2,'05S',15,44),(3,'38N',17,27),(4,'68H',40,49),(5,'81B',32,13),(6,'03Z',23,27),(7,'39J',48,49),(8,'08O',49,31),(9,'47Z',50,24),(10,'11B',27,22);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (11,'61I',34,45),(12,'10W',40,46),(13,'08M',45,50),(14,'30G',29,43),(15,'31L',30,16),(16,'11A',32,48),(17,'99F',32,3),(18,'28H',29,33),(19,'74R',49,22),(20,'25U',45,38);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (21,'01Y',43,25),(22,'57P',29,48),(23,'57U',44,1),(24,'77A',45,19),(25,'55L',38,28),(26,'92A',31,23),(27,'44L',46,28),(28,'49A',50,39),(29,'45P',41,49),(30,'16Y',28,36);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (31,'71Y',47,43),(32,'72M',22,26),(33,'99Q',37,50),(34,'17Z',37,43),(35,'91L',16,44),(36,'37N',20,6),(37,'90C',16,8),(38,'85O',18,22),(39,'87D',45,35),(40,'97Q',43,10);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (41,'79Y',48,7),(42,'91Z',43,16),(43,'12D',30,28),(44,'31X',21,14),(45,'67A',20,50),(46,'99N',23,45),(47,'46S',50,49),(48,'54E',50,43),(49,'57A',46,22),(50,'72Z',26,1);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (51,'11N',15,9),(52,'50C',27,39),(53,'72N',49,44),(54,'70V',46,38),(55,'62U',37,3),(56,'26I',16,20),(57,'27L',29,23),(58,'08N',20,8),(59,'13F',16,18),(60,'00Y',44,25);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (61,'68G',50,19),(62,'06S',17,2),(63,'45F',33,43),(64,'95Y',50,49),(65,'31B',15,8),(66,'11P',36,5),(67,'09A',42,29),(68,'26J',21,24),(69,'68P',45,49),(70,'38G',20,19);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (71,'44Y',16,13),(72,'46S',20,2),(73,'15C',41,41),(74,'42F',20,43),(75,'01U',39,21),(76,'95P',22,29),(77,'21Z',26,47),(78,'01E',47,38),(79,'58W',15,4),(80,'41Q',30,49);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (81,'89V',29,50),(82,'11G',28,13),(83,'70S',15,47),(84,'84W',23,37),(85,'28C',16,48),(86,'98U',16,10),(87,'22Q',32,36),(88,'21G',45,45),(89,'63L',33,12),(90,'23I',17,16);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (91,'67A',48,48),(92,'74F',39,17),(93,'89D',29,45),(94,'61E',49,34),(95,'18H',17,34),(96,'93W',44,27),(97,'41F',38,33),(98,'51E',50,50),(99,'37W',49,8),(100,'52T',18,12);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (101,'29D',42,49),(102,'12M',45,50),(103,'31M',24,32),(104,'37Z',46,29),(105,'08Q',26,10),(106,'14M',22,45),(107,'36G',48,6),(108,'57T',29,43),(109,'06A',34,14),(110,'09W',44,36);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (111,'89Z',45,3),(112,'35H',17,25),(113,'77G',30,38),(114,'61B',29,18),(115,'19Z',30,6),(116,'64U',22,5),(117,'47I',16,26),(118,'14Q',37,9),(119,'90W',27,1),(120,'80A',20,27);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (121,'87B',17,32),(122,'88I',27,7),(123,'78M',18,29),(124,'22M',49,24),(125,'01F',33,7),(126,'44X',30,16),(127,'17N',21,22),(128,'12M',34,2),(129,'47P',20,43),(130,'99G',36,29);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (131,'00J',29,34),(132,'17G',18,38),(133,'24Y',23,14),(134,'09W',45,34),(135,'10Q',44,26),(136,'66G',39,48),(137,'66K',41,12),(138,'76P',25,18),(139,'96F',49,8),(140,'16I',45,14);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (141,'72K',34,36),(142,'16B',34,19),(143,'38H',50,5),(144,'38S',41,42),(145,'70N',45,12),(146,'53Q',20,22),(147,'48E',39,22),(148,'48G',15,8),(149,'66P',37,23),(150,'38H',21,28);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (151,'71O',18,19),(152,'56T',50,33),(153,'77W',38,26),(154,'82K',31,14),(155,'60D',37,10),(156,'51Q',46,12),(157,'69B',29,13),(158,'45T',32,19),(159,'29T',17,1),(160,'78C',28,4);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (161,'72A',46,27),(162,'66K',20,34),(163,'63W',19,32),(164,'73Q',37,25),(165,'70M',17,18),(166,'25O',23,46),(167,'00R',25,31),(168,'74M',50,44),(169,'57O',23,41),(170,'43Q',16,2);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (171,'11L',32,50),(172,'08T',20,17),(173,'66N',20,49),(174,'29F',29,3),(175,'07N',26,1),(176,'69E',19,17),(177,'82G',37,20),(178,'24G',33,50),(179,'96G',46,25),(180,'96N',20,38);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (181,'67K',32,4),(182,'19U',44,35),(183,'67M',34,47),(184,'99B',27,6),(185,'49Q',19,7),(186,'98E',15,29),(187,'07W',27,14),(188,'01P',45,45),(189,'93K',49,35),(190,'84U',39,38);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (191,'28N',45,39),(192,'22M',28,24),(193,'55Y',21,33),(194,'90G',19,10),(195,'96C',47,8),(196,'59O',45,13),(197,'05P',47,44),(198,'95Y',37,50),(199,'50V',50,8),(1100,'76D',34,44);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (201,'59A',50,15),(202,'05J',45,16),(203,'56F',36,37),(204,'03I',32,14),(205,'11J',47,32),(206,'27K',48,30),(207,'25A',23,44),(208,'37C',44,26),(209,'59H',41,5),(2010,'77O',21,39);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (211,'55R',49,50),(212,'19S',35,17),(213,'78I',28,11),(214,'36M',21,16),(215,'55H',29,3),(216,'17W',16,10),(217,'66L',32,49),(218,'83K',29,16),(219,'99P',42,2),(220,'62Y',35,1);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (221,'59V',33,40),(222,'65A',30,40),(223,'54M',31,19),(224,'26S',44,42),(225,'54E',27,28),(226,'18H',42,5),(227,'73S',41,18),(228,'53X',36,28),(229,'76F',28,46),(230,'29V',48,49);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (231,'96H',49,20),(232,'67T',22,26),(233,'81P',31,23),(234,'30S',34,3),(235,'42U',33,21),(236,'08L',42,25),(237,'05Z',41,29),(238,'02Y',23,26),(239,'09E',16,2),(240,'99E',21,12);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (241,'56Y',19,31),(242,'64G',50,5),(243,'41B',25,26),(244,'51O',33,42),(245,'73R',21,1),(246,'46O',39,43),(247,'42V',15,3),(248,'63S',46,30),(249,'51R',22,31),(250,'66T',22,28);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (251,'47O',42,3),(252,'29A',41,38),(253,'73J',18,47),(254,'59K',37,36),(255,'74E',30,35),(256,'01I',40,6),(257,'35E',35,1),(258,'01S',46,34),(259,'50D',17,29),(260,'92X',38,31);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (261,'27V',32,40),(262,'34V',30,38),(263,'61F',45,5),(264,'88O',27,16),(265,'60H',37,30),(266,'42Z',39,17),(267,'25V',25,43),(268,'86K',38,2),(269,'42X',49,12),(270,'36S',25,33);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (271,'62Q',20,13),(272,'11K',18,25),(273,'28F',31,2),(274,'22M',39,42),(275,'92U',40,4),(276,'59F',24,34),(277,'18A',39,32),(278,'64Q',19,5),(279,'48D',20,11),(280,'60K',24,37);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (281,'54L',41,34),(282,'04Y',37,15),(283,'38A',41,11),(284,'21R',22,20),(285,'69Z',49,42),(286,'80K',44,11),(287,'87K',20,35),(288,'35D',46,22),(289,'66T',15,9),(290,'97I',30,43);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (291,'34S',42,1),(292,'69P',44,42),(293,'38X',17,41),(294,'85Z',42,27),(295,'04W',41,25),(296,'58D',30,41),(297,'44F',33,48),(298,'25F',22,25),(299,'23P',40,23),(2100,'04C',20,20);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (301,'06S',40,23),(302,'98I',44,21),(303,'70F',32,45),(304,'62V',45,31),(305,'41Z',38,11),(306,'22P',25,22),(307,'19Q',25,10),(308,'43K',15,31),(309,'05N',31,16),(3010,'20F',19,1);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (311,'08R',50,20),(312,'54F',46,34),(313,'20U',29,49),(314,'58V',40,32),(315,'08Q',44,3),(316,'10L',46,29),(317,'22P',16,22),(318,'68R',27,8),(319,'48N',30,48),(320,'20Q',19,43);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (321,'07W',30,18),(322,'25J',48,25),(323,'74G',17,35),(324,'87U',30,16),(325,'95X',48,17),(326,'96C',17,18),(327,'69M',36,29),(328,'17G',42,17),(329,'70J',20,49),(330,'52Q',38,48);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (331,'00H',47,46),(332,'37I',30,34),(333,'40B',44,48),(334,'57I',49,14),(335,'23D',28,35),(336,'47K',49,49),(337,'33A',29,41),(338,'51H',35,40),(339,'70U',27,28),(340,'12N',39,35);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (341,'89D',17,41),(342,'19P',41,25),(343,'21Z',36,48),(344,'14G',48,42),(345,'53T',19,31),(346,'29G',28,13),(347,'77E',45,8),(348,'39G',37,10),(349,'26E',49,26),(350,'67P',24,32);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (351,'92Z',17,11),(352,'45Y',36,36),(353,'19B',32,21),(354,'26S',40,44),(355,'80E',29,38),(356,'65Y',19,26),(357,'08V',31,25),(358,'99O',43,49),(359,'48A',39,21),(360,'46R',17,50);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (361,'01P',17,3),(362,'68B',23,23),(363,'32X',33,19),(364,'04K',38,1),(365,'83A',48,17),(366,'86X',46,27),(367,'24H',29,11),(368,'95H',33,30),(369,'15D',27,48),(370,'81P',22,13);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (371,'90C',42,24),(372,'04G',44,49),(373,'33K',40,14),(374,'81M',49,16),(375,'94V',18,33),(376,'62U',30,11),(377,'86S',41,30),(378,'66U',35,47),(379,'28B',20,2),(380,'07X',27,9);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (381,'87R',39,42),(382,'60Z',16,25),(383,'74V',36,7),(384,'68M',46,25),(385,'72U',40,37),(386,'27L',27,29),(387,'16I',28,3),(388,'49N',20,18),(389,'85V',30,40),(390,'76F',49,48);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (391,'13S',15,12),(392,'07W',31,24),(393,'97I',23,33),(394,'13Q',36,14),(395,'53L',19,23),(396,'27B',26,21),(397,'12I',46,48),(398,'20Y',44,37),(399,'11W',43,5),(3100,'36O',36,17);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (401,'09C',50,23),(402,'91W',38,46),(403,'60E',27,41),(404,'49K',31,10),(405,'33S',26,11),(406,'19H',38,1),(407,'60W',26,20),(408,'43U',35,33),(409,'54E',15,39),(4010,'53G',39,9);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (411,'49S',24,21),(412,'14L',47,6),(413,'68J',15,36),(414,'06K',28,10),(415,'24J',38,26),(416,'21T',32,33),(417,'29K',40,31),(418,'40C',26,27),(419,'78T',30,39),(420,'49H',41,28);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (421,'56U',15,26),(422,'46Y',42,18),(423,'2R',42,1),(424,'41U',40,31),(425,'37H',30,23),(426,'52Y',17,5),(427,'26R',23,6),(428,'31L',23,14),(429,'94V',28,31),(430,'92C',36,44);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (431,'37P',44,28),(432,'46M',22,12),(433,'03G',38,20),(434,'47G',28,46),(435,'58D',42,1),(436,'07M',48,7),(437,'70U',26,48),(438,'38I',43,31),(439,'43B',15,9),(440,'54U',40,36);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (441,'76Q',23,21),(442,'22O',40,18),(443,'93D',18,8),(444,'24Y',31,43),(445,'90M',16,21),(446,'57D',20,49),(447,'22J',34,3),(448,'54M',39,20),(449,'09X',39,12),(450,'57W',30,43);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (451,'25V',27,7),(452,'42P',28,38),(453,'12D',42,28),(454,'63T',22,14),(455,'99Q',31,5),(456,'25Q',44,1),(457,'45Y',19,43),(458,'11T',19,14),(459,'41A',29,50),(460,'08Y',29,12);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (461,'88L',20,14),(462,'39A',28,23),(463,'13R',30,8),(464,'73Q',34,50),(465,'82W',37,24),(466,'32U',17,15),(467,'44I',19,32),(468,'15S',48,36),(469,'39Z',33,50),(470,'15N',28,38);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (471,'33G',22,2),(472,'72O',46,18),(473,'29U',41,23),(474,'42G',37,1),(475,'83F',20,19),(476,'57P',32,21),(477,'81C',48,29),(478,'64V',24,48),(479,'61B',36,11),(480,'76A',22,13);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (481,'00O',30,32),(482,'92G',44,24),(483,'93G',22,33),(484,'46M',36,43),(485,'31J',42,17),(486,'25Q',38,38),(487,'76E',18,22),(488,'07S',39,11),(489,'21X',25,50),(490,'73M',43,3);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (491,'13G',42,50),(492,'72N',23,6),(493,'17G',47,25),(494,'89U',18,48),(495,'64H',21,49),(496,'28J',37,12),(497,'89C',49,13),(498,'08X',31,35),(499,'00R',22,50),(4100,'73Z',27,34);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (501,'09L',19,37),(502,'77S',25,17),(503,'17U',21,14),(504,'71P',26,5),(505,'47Y',21,1),(506,'67U',44,34),(507,'43P',46,38),(508,'55X',23,44),(509,'79T',32,27),(5010,'84M',46,39);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (511,'03M',43,33),(512,'47D',33,40),(513,'82N',33,39),(514,'12L',45,35),(515,'75I',32,50),(516,'31U',27,35),(517,'64T',20,28),(518,'56L',26,14),(519,'44V',16,47),(520,'08K',46,16);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (521,'36U',18,37),(522,'73F',16,8),(523,'21L',23,15),(524,'44Y',46,28),(525,'23W',36,42),(526,'79R',43,12),(527,'06K',23,14),(528,'82F',16,32),(529,'74P',49,37),(530,'36V',40,23);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (531,'43A',43,18),(532,'55F',44,5),(533,'60O',48,8),(534,'35D',16,22),(535,'42J',47,41),(536,'54S',44,40),(537,'33U',16,12),(538,'20N',25,32),(539,'40C',39,46),(540,'99M',38,25);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (541,'50U',32,18),(542,'00O',42,42),(543,'25W',50,48),(544,'51P',42,21),(545,'77S',47,36),(546,'42F',42,49),(547,'06P',25,8),(548,'24O',20,46),(549,'74J',26,7),(550,'51J',37,42);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (551,'15I',33,5),(552,'53G',46,21),(553,'51E',22,38),(554,'23M',47,15),(555,'70R',35,45),(556,'59I',20,12),(557,'1R',27,12),(558,'86B',32,19),(559,'76P',28,49),(560,'70I',30,28);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (561,'09S',24,11),(562,'17L',46,28),(563,'98X',18,6),(564,'87T',19,39),(565,'18M',33,28),(566,'11H',40,5),(567,'76C',50,29),(568,'84E',45,13),(569,'38Q',47,35),(570,'02U',43,28);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (571,'88B',37,32),(572,'09Z',20,5),(573,'18E',22,17),(574,'44R',37,15),(575,'07F',38,9),(576,'75M',33,37),(577,'47H',40,2),(578,'24O',49,10),(579,'04S',19,22),(580,'53M',30,24);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (581,'93K',48,40),(582,'92Y',29,39),(583,'89G',27,9),(584,'97G',38,1),(585,'55Z',18,27),(586,'10P',39,46),(587,'42Q',33,12),(588,'81A',32,30),(589,'23F',38,23),(590,'83M',38,16);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (591,'07G',31,9),(592,'86Y',26,33),(593,'12K',40,11),(594,'09Y',44,5),(595,'28M',49,15),(596,'79K',24,45),(597,'60F',37,44),(598,'86B',43,30),(599,'25A',28,18),(5100,'05K',16,27);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (601,'84L',50,43),(602,'95L',36,24),(603,'18G',47,42),(604,'79V',36,44),(605,'92Y',46,32),(606,'20U',40,21),(607,'88X',39,16),(608,'05Y',38,48),(609,'51Y',25,41),(6010,'28A',30,27);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (611,'30O',20,20),(612,'21O',37,16),(613,'58X',19,32),(614,'24E',19,15),(615,'25P',35,1),(616,'93J',21,10),(617,'21P',43,37),(618,'16G',31,27),(619,'08R',24,49),(620,'24Q',45,23);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (621,'71E',25,37),(622,'03C',17,41),(623,'73K',42,16),(624,'74X',20,50),(625,'10N',23,50),(626,'5R',27,37),(627,'59E',19,34),(628,'87R',32,37),(629,'86P',42,50),(630,'85V',30,14);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (631,'64V',25,30),(632,'54D',18,40),(633,'77O',50,1),(634,'35H',38,3),(635,'06A',20,4),(636,'41R',27,21),(637,'35A',49,36),(638,'13Q',45,46),(639,'83I',37,15),(640,'50T',24,49);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (641,'54G',24,2),(642,'49C',40,34),(643,'65A',42,18),(644,'38V',23,2),(645,'57J',33,18),(646,'01U',23,6),(647,'18F',43,3),(648,'88X',45,40),(649,'51Y',15,44),(650,'67S',35,44);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (651,'73P',26,27),(652,'48Q',43,2),(653,'28N',43,24),(654,'39I',24,26),(655,'15R',41,41),(656,'68B',48,5),(657,'63Z',20,48),(658,'48B',47,24),(659,'19O',39,24),(660,'31T',24,3);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (661,'48N',21,43),(662,'5R',29,45),(663,'99Y',26,2),(664,'38H',45,49),(665,'99Q',28,5),(666,'33H',16,48),(667,'04O',19,30),(668,'80A',20,15),(669,'68X',47,1),(670,'30D',45,42);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (671,'74X',25,30),(672,'75R',19,15),(673,'64K',30,29),(674,'63Y',16,38),(675,'42N',47,43),(676,'74S',31,30),(677,'38U',37,11),(678,'55T',18,3),(679,'94K',38,29),(680,'35N',29,33);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (681,'51Z',41,4),(682,'89I',45,27),(683,'97R',16,18),(684,'72J',46,34),(685,'94Y',15,38),(686,'20V',23,23),(687,'74R',31,22),(688,'39F',41,11),(689,'41N',39,5),(690,'87O',42,16);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (691,'86A',40,17),(692,'50P',25,50),(693,'49T',27,13),(694,'21H',18,49),(695,'48O',27,19),(696,'70S',21,34),(697,'87K',17,34),(698,'01I',22,40),(699,'70P',23,7),(6100,'72I',39,45);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (701,'05Z',42,3),(702,'61D',47,25),(703,'72U',18,6),(704,'64W',30,19),(705,'60S',38,29),(706,'04N',30,20),(707,'80Q',17,32),(708,'28B',16,11),(709,'13F',16,40),(7010,'88M',19,6);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (711,'39P',25,44),(712,'38I',46,20),(713,'00Z',46,3),(714,'34V',32,23),(715,'66D',44,35),(716,'85J',50,4),(717,'84C',29,35),(718,'51R',28,21),(719,'59J',20,44),(720,'16C',46,1);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (721,'89K',41,23),(722,'80Y',30,26),(723,'19N',31,46),(724,'33P',34,40),(725,'84J',37,44),(726,'03E',37,40),(727,'83B',35,46),(728,'66D',46,31),(729,'96I',31,40),(730,'65C',39,21);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (731,'75A',46,29),(732,'83B',16,8),(733,'26D',27,13),(734,'73U',25,27),(735,'34Y',28,35),(736,'21K',40,19),(737,'95U',45,44),(738,'95A',31,19),(739,'05Y',50,10),(740,'98P',32,16);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (741,'75C',15,50),(742,'15U',25,48),(743,'95T',33,38),(744,'96U',16,12),(745,'03F',46,39),(746,'93C',18,11),(747,'49D',45,8),(748,'22Q',16,30),(749,'22G',24,2),(750,'61N',34,44);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (751,'94N',32,2),(752,'21A',40,13),(753,'91P',32,33),(754,'63J',23,22),(755,'28U',25,47),(756,'62I',39,28),(757,'46Y',47,9),(758,'31N',35,22),(759,'45D',18,48),(760,'02O',26,11);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (761,'26J',24,45),(762,'92C',50,11),(763,'41Z',25,15),(764,'58I',20,15),(765,'77K',20,27),(766,'79H',38,26),(767,'50W',19,24),(768,'28Z',38,6),(769,'34R',48,27),(770,'34Z',25,11);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (771,'33D',19,17),(772,'81A',38,8),(773,'31P',15,8),(774,'32I',44,13),(775,'84P',20,14),(776,'60E',41,20),(777,'00F',41,38),(778,'59H',20,15),(779,'01W',38,6),(780,'47V',18,6);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (781,'71G',26,29),(782,'21N',33,11),(783,'06G',32,49),(784,'52P',48,40),(785,'23L',48,3),(786,'08E',49,26),(787,'79S',21,39),(788,'84G',41,39),(789,'69Z',35,24),(790,'47V',27,47);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (791,'87T',33,45),(792,'08F',34,22),(793,'50U',44,16),(794,'00Q',33,31),(795,'67C',23,19),(796,'95F',39,40),(797,'39D',44,29),(798,'05Y',31,4),(799,'68W',16,2),(7100,'14F',50,1);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (801,'27R',50,37),(802,'66T',35,40),(803,'49T',42,17),(804,'49A',35,18),(805,'10W',34,18),(806,'61Y',29,4),(807,'01R',49,8),(808,'73P',29,26),(809,'09Z',20,39),(8010,'85U',27,30);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (811,'63S',46,50),(812,'05S',22,23),(813,'47Q',46,47),(814,'38P',37,18),(815,'58F',43,47),(816,'24V',34,43),(817,'24E',32,45),(818,'03U',31,25),(819,'36K',42,31),(820,'57V',30,43);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (821,'22O',39,34),(822,'11A',36,26),(823,'10R',48,21),(824,'82V',20,46),(825,'74W',43,38),(826,'51Y',23,35),(827,'07W',20,40),(828,'57R',30,3),(829,'77W',45,40),(830,'91X',46,33);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (831,'97W',38,1),(832,'81I',19,34),(833,'21G',41,8),(834,'34C',48,15),(835,'75E',40,5),(836,'79M',41,30),(837,'30M',21,27),(838,'67V',16,12),(839,'99W',38,8),(840,'95B',50,22);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (841,'55N',23,21),(842,'95Y',17,49),(843,'96E',23,15),(844,'71I',30,12),(845,'57W',30,37),(846,'38H',19,37),(847,'12X',21,36),(848,'11U',37,12),(849,'94A',41,12),(850,'00A',21,31);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (851,'70P',24,20),(852,'35A',17,7),(853,'07N',49,43),(854,'08X',39,16),(855,'23R',42,1),(856,'90J',18,26),(857,'18C',41,32),(858,'58Q',36,45),(859,'74W',38,6),(860,'59P',15,46);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (861,'57P',47,19),(862,'80R',36,31),(863,'34X',49,21),(864,'41Q',47,34),(865,'87B',22,28),(866,'72E',27,36),(867,'81A',31,30),(868,'74U',43,39),(869,'33Q',48,8),(870,'74X',29,22);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (871,'64Q',37,14),(872,'99F',20,42),(873,'71T',15,19),(874,'46I',46,17),(875,'74J',24,21),(876,'49O',28,50),(877,'43T',25,30),(878,'55I',46,21),(879,'31T',16,47),(880,'94L',16,39);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (881,'28C',42,47),(882,'75S',42,3),(883,'78Q',48,5),(884,'49A',30,35),(885,'45B',34,46),(886,'21J',45,34),(887,'62U',17,44),(888,'00C',44,1),(889,'44K',18,40),(890,'03G',39,18);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (891,'72I',35,31),(892,'53T',20,15),(893,'69S',17,23),(894,'21I',28,43),(895,'95O',29,20),(896,'90I',37,44),(897,'80E',43,35),(898,'28Z',38,22),(899,'28V',44,30),(8100,'82K',33,35);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (901,'39M',16,5),(902,'53T',48,13),(903,'45Z',49,11),(904,'26M',30,13),(905,'45T',29,5),(906,'32D',24,30),(907,'10H',21,38),(908,'55K',38,46),(909,'95C',22,36),(9010,'50J',32,5);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (911,'96I',31,36),(912,'52U',44,37),(913,'11C',48,47),(914,'90X',48,9),(915,'08O',40,50),(916,'74Q',34,50),(917,'09L',37,50),(918,'17F',50,49),(919,'52S',25,30),(920,'12B',48,34);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (921,'54J',30,46),(922,'42K',40,39),(923,'79E',20,42),(924,'81O',46,22),(925,'79A',46,19),(926,'48B',15,45),(927,'48Q',44,32),(928,'82C',38,19),(929,'82V',39,3),(930,'05N',22,6);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (931,'48X',41,13),(932,'85W',41,23),(933,'69G',20,48),(934,'36K',39,6),(935,'59U',25,14),(936,'84O',29,32),(937,'15G',49,14),(938,'32Q',33,48),(939,'92W',17,10),(940,'52I',42,11);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (941,'89P',42,4),(942,'08G',18,20),(943,'43Y',21,24),(944,'34A',35,7),(945,'94Z',36,34),(946,'50U',29,50),(947,'03D',25,33),(948,'95I',26,48),(949,'91T',40,9),(950,'66Y',30,27);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (951,'09Z',43,20),(952,'08K',31,12),(953,'43H',32,30),(954,'00W',16,48),(955,'80V',27,30),(956,'21C',28,5),(957,'98F',44,26),(958,'94Z',42,1),(959,'55R',15,38),(960,'41R',42,20);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (961,'08Y',30,11),(962,'41I',32,31),(963,'64H',29,2),(964,'57N',21,42),(965,'00V',35,9),(966,'49F',18,9),(967,'52Y',17,46),(968,'90K',16,20),(969,'00E',23,31),(970,'89J',48,13);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (971,'24D',35,15),(972,'23Z',23,47),(973,'03Q',50,22),(974,'95U',19,40),(975,'66T',18,12),(976,'42H',16,5),(977,'48Z',27,48),(978,'84S',41,11),(979,'31D',18,19),(980,'06C',39,32);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (981,'59B',48,50),(982,'76P',39,39),(983,'94N',38,38),(984,'35W',45,5),(985,'36L',33,33),(986,'78S',26,26),(987,'01X',21,35),(988,'10J',25,12),(989,'18Q',46,12),(990,'48C',15,46);
INSERT INTO Rooms (RoomID,RoomName,RoomCapacity,BuildingID) VALUES (991,'46P',38,2),(992,'65L',17,33),(993,'34O',43,14),(994,'11D',25,14),(995,'31D',24,19),(996,'09Z',46,36),(997,'51U',20,30),(998,'25O',17,50),(999,'93C',41,26),(9100,'57S',18,44);
SET IDENTITY_INSERT Rooms OFF
SET IDENTITY_INSERT Participants ON
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (1, 'Morie', 'Domino', '1955-05-10', 'mdomino0@abc.net.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (2, 'Teresa', 'Knevit', '1988-05-25', 'tknevit1@ehow.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (3, 'Cathie', 'Smeed', '1996-04-19', 'csmeed2@ustream.tv');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (4, 'Marcellina', 'Grindle', '1986-10-06', 'mgrindle3@latimes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (5, 'Karine', 'Credland', '1968-05-22', 'kcredland4@constantcontact.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (6, 'Patric', 'Cosker', '1973-10-08', 'pcosker5@meetup.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (7, 'Georgy', 'Slemmonds', '2004-08-02', 'gslemmonds6@macromedia.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (8, 'Richard', 'Blaase', '1985-12-11', 'rblaase7@vimeo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (9, 'West', 'Ellis', '1976-09-27', 'wellis8@123-reg.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (10, 'Tim', 'Blackmoor', '1967-01-20', 'tblackmoor9@wix.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (11, 'Toddie', 'Eyam', '1975-08-29', 'teyama@vistaprint.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (12, 'Regine', 'Weddup', '1991-10-04', 'rweddupb@newsvine.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (13, 'Sergei', 'Reuter', '1979-07-07', 'sreuterc@jiathis.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (14, 'Stearne', 'Goaley', '1971-02-18', 'sgoaleyd@typepad.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (15, 'Robin', 'Pagen', '1990-12-05', 'rpagene@barnesandnoble.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (16, 'Orson', 'Kloster', '1983-03-25', 'oklosterf@alibaba.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (17, 'Meryl', 'Bever', '1985-02-15', 'mbeverg@homestead.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (18, 'Shelby', 'Knutsen', '1952-04-07', 'sknutsenh@economist.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (19, 'Jessey', 'Rookeby', '1963-10-03', 'jrookebyi@myspace.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (20, 'Herschel', 'Wonfar', '1998-12-16', 'hwonfarj@indiatimes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (21, 'Finley', 'Pluck', '1961-11-29', 'fpluckk@google.de');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (22, 'Jilli', 'Conboy', '1956-01-14', 'jconboyl@apple.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (23, 'Berny', 'Sargint', '1990-11-27', 'bsargintm@ning.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (24, 'Gretna', 'Hourigan', '1962-10-20', 'ghourigann@e-recht24.de');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (25, 'Lauraine', 'Argont', '1960-04-29', 'largonto@feedburner.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (26, 'Ashil', 'Jedrzejewsky', '1967-11-30', 'ajedrzejewskyp@google.pl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (27, 'Wylie', 'Jorger', '1999-06-06', 'wjorgerq@mtv.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (28, 'Tarra', 'Bice', '1982-10-05', 'tbicer@w3.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (29, 'Sarene', 'Youens', '1991-07-11', 'syouenss@photobucket.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (30, 'Catlee', 'Markie', '1963-12-18', 'cmarkiet@typepad.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (31, 'Marlin', 'Heake', '2002-04-15', 'mheakeu@dedecms.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (32, 'Orelee', 'Smidmor', '1952-11-12', 'osmidmorv@people.com.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (33, 'Halette', 'Lathbury', '1996-11-25', 'hlathburyw@google.com.hk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (34, 'Marillin', 'Winsper', '1995-10-31', 'mwinsperx@wp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (35, 'Rakel', 'Dalwood', '1997-10-14', 'rdalwoody@pcworld.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (36, 'Ariel', 'Dorrian', '1966-05-23', 'adorrianz@blogs.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (37, 'Gerianne', 'Hatherell', '1988-11-04', 'ghatherell10@columbia.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (38, 'Kathye', 'Carty', '1995-02-26', 'kcarty11@odnoklassniki.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (39, 'Staci', 'Swales', '2001-10-14', 'sswales12@unicef.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (40, 'Clareta', 'Banham', '1959-04-21', 'cbanham13@howstuffworks.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (41, 'Mannie', 'Muirden', '1967-01-21', 'mmuirden14@vistaprint.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (42, 'Averil', 'Scotti', '1951-07-25', 'ascotti15@yellowbook.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (43, 'Gayleen', 'Guilford', '1952-12-14', 'gguilford16@umich.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (44, 'Lawry', 'Winning', '1988-03-28', 'lwinning17@meetup.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (45, 'Ezequiel', 'Holehouse', '1983-10-13', 'eholehouse18@microsoft.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (46, 'Nananne', 'Larkins', '1959-11-20', 'nlarkins19@cafepress.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (47, 'Ellynn', 'Bromhead', '1987-01-12', 'ebromhead1a@sitemeter.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (48, 'Tiffany', 'Gittus', '1950-10-13', 'tgittus1b@dmoz.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (49, 'Mira', 'Laffling', '1964-03-11', 'mlaffling1c@tumblr.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (50, 'Bartlett', 'Hansom', '1960-06-12', 'bhansom1d@ning.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (51, 'Liz', 'Littley', '1983-05-01', 'llittley1e@huffingtonpost.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (52, 'Angel', 'MacKimmie', '1956-01-19', 'amackimmie1f@yale.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (53, 'Tallou', 'Ciepluch', '1969-12-24', 'tciepluch1g@chicagotribune.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (54, 'Tara', 'Paulazzi', '1967-10-03', 'tpaulazzi1h@histats.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (55, 'Jasper', 'Edgler', '1959-07-30', 'jedgler1i@jimdo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (56, 'Ashley', 'Murty', '1991-09-14', 'amurty1j@businesswire.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (57, 'Vivi', 'De Witt', '1986-02-07', 'vdewitt1k@feedburner.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (58, 'Lona', 'Rother', '1992-07-26', 'lrother1l@answers.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (59, 'Bogey', 'Kilmurray', '2000-05-14', 'bkilmurray1m@chronoengine.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (60, 'Risa', 'Glazer', '1981-05-20', 'rglazer1n@independent.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (61, 'Tremain', 'Balch', '1954-05-03', 'tbalch1o@princeton.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (62, 'Basil', 'Ridel', '1970-01-09', 'bridel1p@dot.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (63, 'Gordan', 'Ondrich', '1995-12-27', 'gondrich1q@twitter.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (64, 'Kris', 'Keslake', '1958-09-15', 'kkeslake1r@wired.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (65, 'Ban', 'Gatesman', '1953-04-09', 'bgatesman1s@ehow.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (66, 'Dehlia', 'Genny', '1988-04-08', 'dgenny1t@engadget.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (67, 'Nikolaos', 'Tuckerman', '1981-06-10', 'ntuckerman1u@so-net.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (68, 'Theda', 'Carrel', '1992-09-22', 'tcarrel1v@blinklist.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (69, 'Reiko', 'Slyne', '1967-11-24', 'rslyne1w@tmall.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (70, 'Tedmund', 'Harrold', '1984-07-21', 'tharrold1x@patch.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (71, 'Christian', 'Heinish', '2001-09-13', 'cheinish1y@irs.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (72, 'Mitchael', 'Pellatt', '1955-09-13', 'mpellatt1z@cbslocal.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (73, 'Rozina', 'Gullefant', '1967-04-04', 'rgullefant20@psu.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (74, 'Lauritz', 'Toal', '1971-03-14', 'ltoal21@sakura.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (75, 'Isabel', 'Reiner', '1968-02-23', 'ireiner22@cloudflare.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (76, 'Illa', 'Harrhy', '1952-10-27', 'iharrhy23@aboutads.info');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (77, 'Finley', 'Blaxley', '1998-02-08', 'fblaxley24@w3.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (78, 'Kassie', 'Duligal', '1995-03-28', 'kduligal25@google.it');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (79, 'Danni', 'Perulli', '1999-12-17', 'dperulli26@virginia.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (80, 'Francisco', 'Hens', '1969-07-18', 'fhens27@chronoengine.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (81, 'Essie', 'Ledgeway', '1968-03-30', 'eledgeway28@rakuten.co.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (82, 'Rabbi', 'Goudard', '1975-09-19', 'rgoudard29@wisc.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (83, 'Sybille', 'Eager', '1955-11-17', 'seager2a@barnesandnoble.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (84, 'Corby', 'Bentzen', '1997-10-17', 'cbentzen2b@tmall.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (85, 'Vivyanne', 'McPaik', '1952-05-03', 'vmcpaik2c@biglobe.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (86, 'Orland', 'Stendall', '1970-02-04', 'ostendall2d@geocities.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (87, 'Kirsti', 'Hazeldine', '1978-09-12', 'khazeldine2e@edublogs.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (88, 'Isiahi', 'Creeboe', '1993-03-08', 'icreeboe2f@furl.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (89, 'Bernice', 'Faltskog', '1951-12-18', 'bfaltskog2g@virginia.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (90, 'Priscella', 'Brimblecomb', '1976-11-28', 'pbrimblecomb2h@amazon.de');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (91, 'Yasmin', 'Beardon', '1974-06-24', 'ybeardon2i@scientificamerican.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (92, 'Roth', 'Simms', '1975-11-07', 'rsimms2j@un.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (93, 'Toddy', 'Ashwell', '1958-01-10', 'tashwell2k@google.ca');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (94, 'Elizabet', 'Daintree', '1991-08-02', 'edaintree2l@cnet.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (95, 'Zola', 'Scarr', '1996-10-07', 'zscarr2m@loc.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (96, 'Brander', 'Dalglish', '1976-01-07', 'bdalglish2n@zimbio.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (97, 'Chrissie', 'Sylett', '1964-05-24', 'csylett2o@comcast.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (98, 'Chuck', 'Tickel', '1953-06-28', 'ctickel2p@ed.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (99, 'Sorcha', 'Rosbrough', '1951-12-25', 'srosbrough2q@youtu.be');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (100, 'Fran', 'Imason', '2000-03-22', 'fimason2r@reddit.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (101, 'Titus', 'Himsworth', '1970-08-19', 'thimsworth2s@fotki.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (102, 'Astrid', 'Clipson', '1990-11-08', 'aclipson2t@163.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (103, 'Winfield', 'Law', '1967-08-22', 'wlaw2u@house.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (104, 'Colline', 'Brixey', '1966-08-06', 'cbrixey2v@1und1.de');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (105, 'Christoforo', 'Fulford', '1997-11-17', 'cfulford2w@friendfeed.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (106, 'Ondrea', 'Overill', '1965-09-16', 'ooverill2x@chron.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (107, 'Brigg', 'Van Merwe', '1969-03-13', 'bvanmerwe2y@un.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (108, 'Wilmette', 'Bausmann', '2004-11-23', 'wbausmann2z@people.com.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (109, 'Caty', 'Antonescu', '1987-08-05', 'cantonescu30@goo.gl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (110, 'Sandye', 'Helks', '1983-10-27', 'shelks31@1688.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (111, 'Adriena', 'Fairbanks', '1966-12-09', 'afairbanks32@nba.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (112, 'Andriana', 'Guiu', '1951-06-08', 'aguiu33@google.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (113, 'Brady', 'Bendel', '2001-11-13', 'bbendel34@nationalgeographic.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (114, 'Chilton', 'Zemler', '1960-04-15', 'czemler35@cdbaby.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (115, 'Jan', 'McIntosh', '1994-04-11', 'jmcintosh36@sina.com.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (116, 'Jarrett', 'Walworth', '1987-12-31', 'jwalworth37@marketwatch.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (117, 'Saunderson', 'Phillippo', '1978-02-21', 'sphillippo38@1688.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (118, 'Allyson', 'Jaegar', '2001-11-17', 'ajaegar39@wp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (119, 'Chrisse', 'Golsby', '1973-09-25', 'cgolsby3a@home.pl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (120, 'Israel', 'Meron', '1968-07-24', 'imeron3b@usgs.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (121, 'Caritta', 'Mudie', '1965-06-22', 'cmudie3c@archive.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (122, 'Theresina', 'Jakolevitch', '1956-04-08', 'tjakolevitch3d@parallels.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (123, 'Alphard', 'Wenn', '1987-04-03', 'awenn3e@multiply.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (124, 'Shelli', 'Wiffield', '1951-10-02', 'swiffield3f@bbb.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (125, 'Eugen', 'Philps', '1991-05-16', 'ephilps3g@icio.us');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (126, 'Curt', 'Vasnetsov', '1992-07-27', 'cvasnetsov3h@webnode.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (127, 'Brade', 'Preble', '1951-03-08', 'bpreble3i@dyndns.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (128, 'Durante', 'Merali', '1999-12-28', 'dmerali3j@aol.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (129, 'Morgan', 'Backshell', '1999-07-09', 'mbackshell3k@xrea.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (130, 'Debra', 'Bloschke', '1966-05-02', 'dbloschke3l@rediff.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (131, 'Elli', 'Juszkiewicz', '1981-09-08', 'ejuszkiewicz3m@skyrock.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (132, 'Toddie', 'Juggins', '1968-06-23', 'tjuggins3n@livejournal.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (133, 'Bevon', 'Hollingdale', '1970-03-06', 'bhollingdale3o@jiathis.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (134, 'Salvidor', 'Broddle', '1996-06-20', 'sbroddle3p@pcworld.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (135, 'Solomon', 'Broadey', '1993-11-06', 'sbroadey3q@linkedin.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (136, 'Billy', 'Arnaudin', '1975-06-27', 'barnaudin3r@geocities.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (137, 'Susi', 'Udall', '1986-05-14', 'sudall3s@drupal.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (138, 'Prisca', 'Sitlington', '2000-12-13', 'psitlington3t@ucoz.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (139, 'Salomi', 'Kleinzweig', '2001-03-05', 'skleinzweig3u@g.co');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (140, 'Tiler', 'Danes', '1997-02-18', 'tdanes3v@aboutads.info');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (141, 'Vitoria', 'Probet', '1959-05-16', 'vprobet3w@github.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (142, 'Casey', 'Gaydon', '1957-08-13', 'cgaydon3x@loc.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (143, 'Peri', 'Santello', '1974-09-28', 'psantello3y@sfgate.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (144, 'Mitchell', 'Petrelli', '1956-10-16', 'mpetrelli3z@typepad.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (145, 'Hilary', 'Cunnow', '1960-12-08', 'hcunnow40@flavors.me');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (146, 'Ulrike', 'Pinching', '1998-02-15', 'upinching41@fda.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (147, 'Wes', 'Cardwell', '1960-11-22', 'wcardwell42@youtu.be');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (148, 'Deny', 'Vitall', '1976-09-27', 'dvitall43@scientificamerican.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (149, 'Karin', 'Ledington', '1990-05-13', 'kledington44@illinois.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (150, 'Sutton', 'Elesander', '1989-08-24', 'selesander45@symantec.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (151, 'Flossie', 'Plum', '1979-02-20', 'fplum46@typepad.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (152, 'Jessee', 'St Ledger', '1976-09-26', 'jstledger47@geocities.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (153, 'Hilary', 'Tows', '1990-09-03', 'htows48@devhub.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (154, 'Louie', 'Brinson', '1954-12-07', 'lbrinson49@pagesperso-orange.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (155, 'Siward', 'Swiffan', '1972-07-28', 'sswiffan4a@desdev.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (156, 'Hymie', 'Micklewicz', '1968-09-23', 'hmicklewicz4b@zdnet.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (157, 'Vassili', 'Doylend', '1953-05-19', 'vdoylend4c@tiny.cc');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (158, 'Carie', 'Teece', '2003-11-26', 'cteece4d@ucoz.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (159, 'Daveen', 'Stutard', '1956-07-20', 'dstutard4e@geocities.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (160, 'Tove', 'Gayforth', '1961-08-18', 'tgayforth4f@istockphoto.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (161, 'Manya', 'Scrine', '1999-09-01', 'mscrine4g@forbes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (162, 'Jeffry', 'Ledingham', '1964-06-29', 'jledingham4h@acquirethisname.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (163, 'Kassia', 'Onge', '1981-07-14', 'konge4i@thetimes.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (164, 'Harold', 'Lendon', '1963-05-12', 'hlendon4j@umn.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (165, 'Cece', 'Schuchmacher', '1964-06-26', 'cschuchmacher4k@nifty.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (166, 'Clarance', 'de Voiels', '1950-07-31', 'cdevoiels4l@webnode.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (167, 'Barry', 'O''Brogane', '1989-10-28', 'bobrogane4m@npr.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (168, 'Tina', 'Brewerton', '1956-10-27', 'tbrewerton4n@sciencedirect.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (169, 'Cherri', 'Pothbury', '1963-11-26', 'cpothbury4o@chron.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (170, 'Garland', 'Abeau', '1977-05-21', 'gabeau4p@exblog.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (171, 'Lindie', 'Fairhead', '2002-11-01', 'lfairhead4q@addthis.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (172, 'Orelle', 'Lambis', '1986-11-28', 'olambis4r@amazon.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (173, 'Helaine', 'Clardge', '1958-10-02', 'hclardge4s@geocities.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (174, 'Remy', 'Jakubovitch', '1951-10-10', 'rjakubovitch4t@comsenz.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (175, 'Ashien', 'Caff', '1986-03-11', 'acaff4u@about.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (176, 'Clay', 'Jannaway', '2004-07-08', 'cjannaway4v@yelp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (177, 'Eulalie', 'Perrelle', '1991-08-12', 'eperrelle4w@moonfruit.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (178, 'Cristiano', 'Hounson', '2003-12-14', 'chounson4x@cnn.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (179, 'Nicola', 'Ramirez', '1971-09-21', 'nramirez4y@amazon.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (180, 'Cyrill', 'Whitbread', '1958-03-25', 'cwhitbread4z@google.nl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (181, 'Skyler', 'Doberer', '1994-09-28', 'sdoberer50@state.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (182, 'Jocelyn', 'Overbury', '1986-09-14', 'joverbury51@auda.org.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (183, 'Lanny', 'Lownes', '1975-11-01', 'llownes52@pinterest.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (184, 'Nevsa', 'Arnaudin', '1950-12-15', 'narnaudin53@istockphoto.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (185, 'Angeli', 'Lumbley', '1977-02-05', 'alumbley54@hao123.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (186, 'Donnajean', 'Asher', '1951-07-10', 'dasher55@acquirethisname.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (187, 'Rosene', 'Indruch', '1962-01-04', 'rindruch56@cyberchimps.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (188, 'Cal', 'O''Hartnedy', '1980-04-09', 'cohartnedy57@usda.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (189, 'Beverie', 'Fiennes', '1985-09-12', 'bfiennes58@nymag.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (190, 'Payton', 'Hudghton', '1958-11-07', 'phudghton59@cam.ac.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (191, 'Elisha', 'Klejin', '2001-07-31', 'eklejin5a@posterous.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (192, 'Leesa', 'Chaimson', '1988-01-29', 'lchaimson5b@trellian.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (193, 'Violante', 'Berard', '1998-03-18', 'vberard5c@marriott.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (194, 'Amara', 'MacBey', '1952-01-30', 'amacbey5d@posterous.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (195, 'Ashil', 'Peabody', '1962-03-28', 'apeabody5e@economist.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (196, 'Ebba', 'Haistwell', '1974-11-17', 'ehaistwell5f@plala.or.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (197, 'Lian', 'Epple', '1993-05-10', 'lepple5g@angelfire.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (198, 'Carly', 'Louden', '1956-11-02', 'clouden5h@google.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (199, 'Inigo', 'Lodwig', '1951-01-24', 'ilodwig5i@csmonitor.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (200, 'Pearle', 'Verity', '1953-03-18', 'pverity5j@dot.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (201, 'Verine', 'Cardenoso', '1960-08-25', 'vcardenoso5k@salon.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (202, 'Lynea', 'Andreuzzi', '1970-07-04', 'landreuzzi5l@bbb.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (203, 'Sanderson', 'Derle', '1972-09-05', 'sderle5m@reuters.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (204, 'Ynes', 'Maiklem', '1958-03-20', 'ymaiklem5n@usatoday.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (205, 'Tatiana', 'Laver', '1994-04-26', 'tlaver5o@vkontakte.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (206, 'Stanford', 'Truett', '1975-09-23', 'struett5p@wunderground.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (207, 'Felice', 'Hearley', '1998-01-27', 'fhearley5q@independent.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (208, 'Derrik', 'Headford', '1998-10-28', 'dheadford5r@printfriendly.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (209, 'Shelley', 'Choffin', '1993-09-23', 'schoffin5s@intel.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (210, 'Wilden', 'Trimnell', '1997-04-19', 'wtrimnell5t@ezinearticles.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (211, 'Clarance', 'Cutsforth', '2002-09-21', 'ccutsforth5u@mit.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (212, 'Kelsey', 'Haking', '1977-07-21', 'khaking5v@github.io');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (213, 'Vanni', 'Mechi', '1994-01-03', 'vmechi5w@dell.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (214, 'Broderic', 'Rolse', '1982-07-07', 'brolse5x@indiatimes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (215, 'Micky', 'Kivlehan', '1965-07-06', 'mkivlehan5y@pinterest.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (216, 'Bax', 'Bygreaves', '1973-11-21', 'bbygreaves5z@pagesperso-orange.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (217, 'Joete', 'Collete', '1970-10-21', 'jcollete60@sitemeter.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (218, 'Kermie', 'Sawyer', '1951-06-13', 'ksawyer61@forbes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (219, 'Ophelie', 'McElmurray', '1982-10-09', 'omcelmurray62@hc360.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (220, 'Hatty', 'Meller', '1957-11-15', 'hmeller63@google.ca');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (221, 'Ethelbert', 'Urling', '1959-11-28', 'eurling64@de.vu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (222, 'Vanda', 'Sherrell', '1991-02-25', 'vsherrell65@google.com.br');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (223, 'Farlee', 'McGettigan', '1961-07-23', 'fmcgettigan66@cbc.ca');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (224, 'Janifer', 'Pampling', '1984-01-08', 'jpampling67@independent.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (225, 'Correy', 'Polland', '1971-10-15', 'cpolland68@abc.net.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (226, 'Gustavus', 'Ferrarini', '1978-11-24', 'gferrarini69@cdc.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (227, 'Winifield', 'Sarney', '1997-09-05', 'wsarney6a@addthis.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (228, 'Robers', 'Spitaro', '1998-09-25', 'rspitaro6b@bing.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (229, 'Lu', 'Holsall', '2003-02-19', 'lholsall6c@gizmodo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (230, 'Rafe', 'Maycock', '1954-12-10', 'rmaycock6d@reverbnation.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (231, 'Allie', 'Selway', '2000-08-11', 'aselway6e@buzzfeed.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (232, 'Lorne', 'Gilby', '1983-04-05', 'lgilby6f@soup.io');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (233, 'Jonis', 'Rops', '1979-07-28', 'jrops6g@51.la');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (234, 'Lucila', 'Corringham', '1951-05-22', 'lcorringham6h@joomla.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (235, 'Gaspar', 'Kobera', '2004-02-19', 'gkobera6i@va.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (236, 'Tallie', 'De la Eglise', '1982-01-23', 'tdelaeglise6j@imageshack.us');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (237, 'Verla', 'Lyddiard', '1964-03-18', 'vlyddiard6k@t.co');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (238, 'Benton', 'Schuck', '1952-02-11', 'bschuck6l@time.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (239, 'Daisi', 'Issard', '1979-04-23', 'dissard6m@weebly.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (240, 'Rorie', 'Excell', '1981-09-17', 'rexcell6n@dot.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (241, 'Bogart', 'Orable', '1961-07-26', 'borable6o@tripod.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (242, 'Joanna', 'Spray', '1976-09-09', 'jspray6p@phoca.cz');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (243, 'Bruce', 'Klemz', '1976-06-18', 'bklemz6q@buzzfeed.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (244, 'Nora', 'McCobb', '1958-11-05', 'nmccobb6r@nsw.gov.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (245, 'Sherwynd', 'Lodeke', '1982-07-08', 'slodeke6s@tamu.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (246, 'Chance', 'Harrisson', '1992-05-14', 'charrisson6t@printfriendly.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (247, 'Ric', 'Lipprose', '1982-11-02', 'rlipprose6u@shinystat.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (248, 'Heriberto', 'Tompkinson', '1958-06-16', 'htompkinson6v@engadget.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (249, 'Darbie', 'Mordie', '1998-10-06', 'dmordie6w@rediff.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (250, 'Abbe', 'Farraway', '1954-05-23', 'afarraway6x@instagram.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (251, 'Trenton', 'Bitterton', '1976-08-09', 'tbitterton6y@so-net.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (252, 'Karisa', 'Wadie', '2002-11-19', 'kwadie6z@soup.io');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (253, 'Consuela', 'Delgaty', '2000-07-01', 'cdelgaty70@pen.io');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (254, 'Friedrich', 'Brawn', '1989-10-12', 'fbrawn71@amazon.de');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (255, 'Jacky', 'Trenbey', '1997-12-14', 'jtrenbey72@va.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (256, 'Rolph', 'Duckerin', '1959-07-01', 'rduckerin73@blogs.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (257, 'Lenci', 'Utton', '1995-08-01', 'lutton74@studiopress.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (258, 'Jobi', 'Snowling', '1988-12-24', 'jsnowling75@reverbnation.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (259, 'Evangelina', 'Rooper', '1996-11-30', 'erooper76@cocolog-nifty.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (260, 'Curran', 'Boyson', '1987-05-13', 'cboyson77@i2i.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (261, 'Thain', 'Sheaf', '1967-03-06', 'tsheaf78@statcounter.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (262, 'Sergei', 'Mishaw', '1951-03-04', 'smishaw79@gravatar.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (263, 'Atlante', 'Peggram', '1997-10-26', 'apeggram7a@pbs.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (264, 'Elwyn', 'Chable', '1979-10-19', 'echable7b@goodreads.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (265, 'Marlin', 'Varns', '1969-06-13', 'mvarns7c@mail.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (266, 'Jeannie', 'Steade', '1961-02-18', 'jsteade7d@moonfruit.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (267, 'Mic', 'Overstreet', '1967-06-11', 'moverstreet7e@japanpost.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (268, 'Royce', 'Pagett', '1988-09-06', 'rpagett7f@independent.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (269, 'Kenn', 'Huband', '1965-09-12', 'khuband7g@comsenz.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (270, 'Jaye', 'Arnison', '1975-06-18', 'jarnison7h@ask.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (271, 'Kip', 'Nibley', '1988-08-25', 'knibley7i@miibeian.gov.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (272, 'Germayne', 'Cardenas', '1989-09-13', 'gcardenas7j@abc.net.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (273, 'Madlin', 'Akam', '1975-06-10', 'makam7k@list-manage.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (274, 'Pippy', 'Jakubovitch', '1952-03-08', 'pjakubovitch7l@nps.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (275, 'Kara-lynn', 'Bocock', '1952-02-26', 'kbocock7m@ning.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (276, 'Jessa', 'Moggle', '1950-09-27', 'jmoggle7n@google.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (277, 'Lyndy', 'Elbourne', '1986-07-10', 'lelbourne7o@ezinearticles.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (278, 'Chane', 'Ikins', '2000-04-06', 'cikins7p@ycombinator.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (279, 'Vivienne', 'Askwith', '1984-09-28', 'vaskwith7q@ehow.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (280, 'Mabel', 'Boaler', '2000-12-15', 'mboaler7r@edublogs.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (281, 'Cassandre', 'Simoncello', '1988-04-28', 'csimoncello7s@dedecms.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (282, 'Quentin', 'Turland', '1975-09-05', 'qturland7t@statcounter.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (283, 'Kelcey', 'Gilhespy', '1993-04-14', 'kgilhespy7u@pinterest.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (284, 'Gilberto', 'Pearsall', '1961-08-05', 'gpearsall7v@tinyurl.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (285, 'Laird', 'Allsworth', '1985-01-23', 'lallsworth7w@51.la');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (286, 'Ame', 'Altimas', '1987-08-14', 'aaltimas7x@marriott.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (287, 'Yorke', 'Bilsford', '1968-12-09', 'ybilsford7y@altervista.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (288, 'Michelina', 'Pochon', '1962-08-06', 'mpochon7z@china.com.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (289, 'Francesca', 'Delamere', '2000-08-12', 'fdelamere80@msn.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (290, 'Lyell', 'Grimster', '1950-01-12', 'lgrimster81@home.pl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (291, 'Pietra', 'Wrinch', '1966-06-19', 'pwrinch82@canalblog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (292, 'Ardelle', 'Latore', '2000-10-03', 'alatore83@cnbc.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (293, 'Humbert', 'Lavery', '1967-07-02', 'hlavery84@w3.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (294, 'Denise', 'Glenny', '1985-01-02', 'dglenny85@jalbum.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (295, 'Stefan', 'Dougher', '1968-01-15', 'sdougher86@sogou.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (296, 'Pepillo', 'Plott', '1970-07-16', 'pplott87@slate.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (297, 'Bastien', 'Davidsohn', '1988-07-08', 'bdavidsohn88@cnet.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (298, 'Aurlie', 'Froome', '1965-05-24', 'afroome89@is.gd');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (299, 'Carline', 'Marshallsay', '1965-12-24', 'cmarshallsay8a@oracle.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (300, 'Dall', 'Allan', '1955-06-06', 'dallan8b@behance.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (301, 'Serene', 'Amery', '1983-07-22', 'samery8c@deliciousdays.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (302, 'Clair', 'MacKomb', '1959-12-14', 'cmackomb8d@rambler.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (303, 'Dredi', 'O''Duane', '1989-08-05', 'doduane8e@simplemachines.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (304, 'Wolfgang', 'Letixier', '1990-05-30', 'wletixier8f@ameblo.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (305, 'Grazia', 'Sannes', '1971-02-05', 'gsannes8g@uiuc.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (306, 'Denny', 'Shipway', '2003-06-07', 'dshipway8h@opensource.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (307, 'Collie', 'Basile', '1953-02-07', 'cbasile8i@issuu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (308, 'Rickie', 'Feronet', '1951-05-26', 'rferonet8j@freewebs.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (309, 'Marris', 'McGeechan', '2004-10-19', 'mmcgeechan8k@mtv.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (310, 'Chilton', 'Woolaghan', '1978-12-30', 'cwoolaghan8l@mashable.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (311, 'Tobiah', 'Boyland', '1998-01-18', 'tboyland8m@timesonline.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (312, 'Augustina', 'Drohan', '1982-07-17', 'adrohan8n@yolasite.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (313, 'Sabrina', 'O''Carran', '1961-01-03', 'socarran8o@samsung.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (314, 'Findlay', 'Dench', '1979-07-07', 'fdench8p@independent.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (315, 'Pennie', 'Covotti', '1987-02-14', 'pcovotti8q@jiathis.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (316, 'Cody', 'Franek', '1981-04-23', 'cfranek8r@bloglovin.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (317, 'Lenka', 'Stoile', '1991-05-23', 'lstoile8s@baidu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (318, 'Adolf', 'Fenne', '1999-03-02', 'afenne8t@squarespace.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (319, 'Daffy', 'Rugg', '1977-01-07', 'drugg8u@addthis.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (320, 'Fenelia', 'Bygrove', '1952-09-06', 'fbygrove8v@vkontakte.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (321, 'Norbert', 'Gulliman', '1994-04-07', 'ngulliman8w@ox.ac.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (322, 'Ronalda', 'Koba', '1951-06-30', 'rkoba8x@tripadvisor.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (323, 'Kenton', 'Phil', '1998-07-25', 'kphil8y@hibu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (324, 'Myca', 'Furmage', '1953-06-11', 'mfurmage8z@google.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (325, 'Samson', 'Abade', '2003-01-06', 'sabade90@free.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (326, 'Antonia', 'Peasby', '1975-03-11', 'apeasby91@intel.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (327, 'Denna', 'Letford', '1972-10-05', 'dletford92@example.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (328, 'Koralle', 'Gossart', '2003-05-17', 'kgossart93@dedecms.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (329, 'Alexio', 'Lannon', '2003-08-19', 'alannon94@weibo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (330, 'Annelise', 'Jouannot', '1952-05-25', 'ajouannot95@google.it');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (331, 'Jemie', 'Danskine', '1971-07-29', 'jdanskine96@4shared.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (332, 'Dukie', 'Worledge', '1966-06-02', 'dworledge97@stanford.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (333, 'Clarie', 'Pearn', '1953-09-13', 'cpearn98@engadget.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (334, 'Park', 'Winspeare', '1965-08-21', 'pwinspeare99@topsy.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (335, 'Venus', 'Keal', '1959-08-31', 'vkeal9a@posterous.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (336, 'Zaccaria', 'Vlahos', '1999-11-24', 'zvlahos9b@guardian.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (337, 'Beatrisa', 'Abercromby', '1971-05-05', 'babercromby9c@ftc.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (338, 'Jasmina', 'Sidnall', '1971-04-19', 'jsidnall9d@so-net.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (339, 'Napoleon', 'Brackenbury', '1959-10-28', 'nbrackenbury9e@dell.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (340, 'Byram', 'Hancox', '1972-09-28', 'bhancox9f@google.de');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (341, 'Britta', 'Cullerne', '1950-01-22', 'bcullerne9g@tripadvisor.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (342, 'Daniella', 'Doby', '1950-04-02', 'ddoby9h@acquirethisname.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (343, 'Paige', 'Reyes', '1953-12-23', 'preyes9i@moonfruit.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (344, 'Hailee', 'McMurdo', '1975-10-01', 'hmcmurdo9j@meetup.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (345, 'Gayleen', 'O''Kenny', '1992-06-25', 'gokenny9k@nbcnews.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (346, 'Abran', 'Zorzenoni', '1955-11-06', 'azorzenoni9l@unblog.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (347, 'Emmanuel', 'Bagger', '1977-11-23', 'ebagger9m@apple.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (348, 'Anastasie', 'Castledine', '1955-05-15', 'acastledine9n@wufoo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (349, 'Buddy', 'Dettmar', '1980-02-21', 'bdettmar9o@weather.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (350, 'Olav', 'Puckring', '1998-08-27', 'opuckring9p@elpais.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (351, 'Loren', 'Jaslem', '1967-04-02', 'ljaslem9q@google.com.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (352, 'Randal', 'Oliver-Paull', '1989-10-27', 'roliverpaull9r@dedecms.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (353, 'Delila', 'Luparto', '1977-08-19', 'dluparto9s@npr.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (354, 'Anet', 'Heyfield', '1952-10-25', 'aheyfield9t@123-reg.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (355, 'Amanda', 'Winchcombe', '1968-08-26', 'awinchcombe9u@google.com.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (356, 'Enrique', 'Carlan', '1987-10-10', 'ecarlan9v@unc.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (357, 'Alasteir', 'Graber', '1968-11-21', 'agraber9w@ifeng.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (358, 'Doralin', 'Thickins', '1970-08-01', 'dthickins9x@webeden.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (359, 'Hendrick', 'Gildersleeve', '1982-10-14', 'hgildersleeve9y@dion.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (360, 'Thorny', 'Feye', '1983-03-29', 'tfeye9z@dagondesign.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (361, 'Trish', 'Churchill', '1963-11-16', 'tchurchilla0@cisco.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (362, 'Pennie', 'MacInnes', '1955-03-02', 'pmacinnesa1@usda.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (363, 'Dorette', 'Milborn', '1977-07-29', 'dmilborna2@shinystat.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (364, 'Amelita', 'Heyfield', '1991-05-14', 'aheyfielda3@ucoz.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (365, 'Basilius', 'MacCaughen', '1955-11-03', 'bmaccaughena4@baidu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (366, 'Mohammed', 'Bloxsome', '1968-10-18', 'mbloxsomea5@yolasite.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (367, 'Louisette', 'Gilpin', '1951-01-12', 'lgilpina6@cbsnews.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (368, 'Lexi', 'Dewberry', '1959-06-24', 'ldewberrya7@illinois.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (369, 'Wayne', 'Beacon', '1978-06-06', 'wbeacona8@domainmarket.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (370, 'Duffie', 'Canny', '1959-07-10', 'dcannya9@usa.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (371, 'Madlin', 'Cloake', '1950-06-08', 'mcloakeaa@github.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (372, 'Violetta', 'Colson', '1997-12-08', 'vcolsonab@devhub.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (373, 'Howard', 'Warstall', '1963-03-01', 'hwarstallac@constantcontact.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (374, 'Toby', 'Walworche', '1962-05-07', 'twalworchead@creativecommons.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (375, 'Seamus', 'Mogie', '1953-01-17', 'smogieae@bravesites.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (376, 'Gennifer', 'Grishukov', '2002-02-23', 'ggrishukovaf@blogger.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (377, 'Tybie', 'Tolotti', '1983-05-20', 'ttolottiag@noaa.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (378, 'Gwendolyn', 'Bunker', '2003-03-24', 'gbunkerah@webs.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (379, 'Dar', 'Ledur', '1972-01-25', 'dledurai@hatena.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (380, 'Obie', 'Ewdale', '1951-06-16', 'oewdaleaj@discovery.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (381, 'Gleda', 'Moyser', '1997-10-14', 'gmoyserak@t-online.de');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (382, 'Kelsy', 'Ortiger', '1963-09-20', 'kortigeral@telegraph.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (383, 'Finn', 'MacSporran', '1986-05-01', 'fmacsporranam@cam.ac.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (384, 'Catlin', 'Rumke', '1957-09-25', 'crumkean@bbb.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (385, 'Nedi', 'Tonbye', '1980-09-06', 'ntonbyeao@qq.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (386, 'Mufi', 'Creaney', '1994-08-31', 'mcreaneyap@gravatar.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (387, 'Chucho', 'Faull', '1998-04-06', 'cfaullaq@addthis.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (388, 'Flossie', 'Fryett', '1960-01-28', 'ffryettar@over-blog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (389, 'Marwin', 'Vero', '1954-09-23', 'mveroas@bloglines.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (390, 'Angelo', 'Osmond', '1973-10-04', 'aosmondat@nature.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (391, 'Doroteya', 'Duester', '1965-01-09', 'dduesterau@t.co');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (392, 'Nanete', 'Fawbert', '1964-04-13', 'nfawbertav@flavors.me');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (393, 'Terrijo', 'Wragge', '1994-04-10', 'twraggeaw@miibeian.gov.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (394, 'Marcela', 'Corneliussen', '1988-11-06', 'mcorneliussenax@ibm.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (395, 'Sherlocke', 'Farnworth', '1970-10-13', 'sfarnworthay@stumbleupon.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (396, 'Archy', 'Adiscot', '1977-04-08', 'aadiscotaz@shutterfly.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (397, 'Robbert', 'Stratley', '1968-04-18', 'rstratleyb0@reverbnation.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (398, 'Lynnet', 'Elmar', '1999-04-11', 'lelmarb1@cbslocal.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (399, 'Marcelline', 'Euplate', '1983-12-22', 'meuplateb2@businessweek.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (400, 'Obed', 'Rammell', '1965-03-14', 'orammellb3@timesonline.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (401, 'Lynn', 'Havik', '1973-04-30', 'lhavikb4@pinterest.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (402, 'Madlin', 'Rennick', '1961-09-06', 'mrennickb5@surveymonkey.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (403, 'Marshal', 'Donke', '1977-03-12', 'mdonkeb6@si.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (404, 'Kalinda', 'Thinn', '1985-01-11', 'kthinnb7@surveymonkey.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (405, 'Jacquenetta', 'Tapin', '1984-09-28', 'jtapinb8@berkeley.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (406, 'Eryn', 'Lyddyard', '1995-07-24', 'elyddyardb9@bing.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (407, 'Halsey', 'Stempe', '1965-02-12', 'hstempeba@ustream.tv');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (408, 'Jarad', 'Wofenden', '1954-06-06', 'jwofendenbb@posterous.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (409, 'Glen', 'Vincent', '1994-06-04', 'gvincentbc@pen.io');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (410, 'Griff', 'Cupper', '1990-11-03', 'gcupperbd@quantcast.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (411, 'Isidora', 'Zavattero', '1977-09-21', 'izavatterobe@usda.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (412, 'Mira', 'Syne', '1992-01-29', 'msynebf@a8.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (413, 'Kettie', 'Mixhel', '1993-03-22', 'kmixhelbg@canalblog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (414, 'Ettore', 'Manvell', '1963-01-25', 'emanvellbh@bluehost.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (415, 'Raine', 'Dancer', '1952-02-18', 'rdancerbi@etsy.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (416, 'Con', 'Hedditch', '1963-05-08', 'chedditchbj@desdev.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (417, 'Clevie', 'Taffie', '1959-08-15', 'ctaffiebk@archive.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (418, 'Rand', 'Blondelle', '1998-07-10', 'rblondellebl@bizjournals.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (419, 'Demetris', 'Smyth', '1955-12-26', 'dsmythbm@friendfeed.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (420, 'Florida', 'Jossel', '1961-01-18', 'fjosselbn@exblog.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (421, 'Madelon', 'Raithmill', '1967-11-05', 'mraithmillbo@pagesperso-orange.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (422, 'Bruis', 'Magee', '1984-03-31', 'bmageebp@moonfruit.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (423, 'Herve', 'Paice', '1965-04-09', 'hpaicebq@phpbb.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (424, 'Danette', 'Adamek', '1963-09-30', 'dadamekbr@state.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (425, 'Benedicto', 'Solloway', '1985-01-28', 'bsollowaybs@nhs.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (426, 'Kris', 'Tilley', '1975-05-29', 'ktilleybt@ihg.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (427, 'Harper', 'Spooner', '1970-05-10', 'hspoonerbu@europa.eu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (428, 'Rod', 'Marskell', '1983-07-26', 'rmarskellbv@google.es');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (429, 'Toby', 'Du Plantier', '1958-08-17', 'tduplantierbw@instagram.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (430, 'Beret', 'Sayers', '1995-04-21', 'bsayersbx@miibeian.gov.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (431, 'Nat', 'Knutton', '1996-04-05', 'nknuttonby@dropbox.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (432, 'Gabie', 'Makey', '1954-06-17', 'gmakeybz@dmoz.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (433, 'Mozes', 'Cornelius', '1988-01-17', 'mcorneliusc0@paypal.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (434, 'Lezlie', 'Gallen', '1986-07-22', 'lgallenc1@cnn.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (435, 'Clifford', 'Massel', '1975-03-28', 'cmasselc2@fda.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (436, 'Marcus', 'Chess', '1987-03-08', 'mchessc3@mtv.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (437, 'Alleen', 'Simmill', '1985-03-05', 'asimmillc4@tmall.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (438, 'Stirling', 'Absolom', '1993-07-04', 'sabsolomc5@google.com.br');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (439, 'Marwin', 'Brookfield', '1993-09-09', 'mbrookfieldc6@facebook.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (440, 'Carleen', 'Chivrall', '1997-02-19', 'cchivrallc7@nba.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (441, 'Adriana', 'Rhyme', '1954-06-20', 'arhymec8@youtube.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (442, 'Merla', 'Bonds', '1961-09-30', 'mbondsc9@sogou.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (443, 'Craggy', 'Sharland', '1991-02-09', 'csharlandca@tripod.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (444, 'Cathy', 'Van der Hoeven', '1985-07-24', 'cvanderhoevencb@wired.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (445, 'Artie', 'Geertsen', '1974-12-12', 'ageertsencc@live.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (446, 'Casi', 'Gogarty', '2002-01-23', 'cgogartycd@squidoo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (447, 'Amaleta', 'Cary', '2000-03-26', 'acaryce@bloglines.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (448, 'Jacquie', 'Yanuk', '1992-11-03', 'jyanukcf@cdbaby.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (449, 'Alexandro', 'Ingree', '1975-08-04', 'aingreecg@webeden.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (450, 'Isacco', 'Gerckens', '1987-11-03', 'igerckensch@angelfire.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (451, 'Aliza', 'Downham', '1954-05-21', 'adownhamci@flavors.me');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (452, 'Goran', 'Flageul', '1984-05-14', 'gflageulcj@microsoft.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (453, 'Gwyn', 'Crotty', '1978-02-09', 'gcrottyck@cnbc.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (454, 'Cherey', 'Darrach', '1994-05-25', 'cdarrachcl@photobucket.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (455, 'Shantee', 'Plaschke', '2000-09-18', 'splaschkecm@sourceforge.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (456, 'Barnabe', 'Trimby', '1994-06-21', 'btrimbycn@sfgate.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (457, 'Demetri', 'Holley', '1993-06-01', 'dholleyco@friendfeed.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (458, 'Nat', 'Gabala', '1988-11-22', 'ngabalacp@guardian.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (459, 'Upton', 'Skouling', '1968-02-08', 'uskoulingcq@canalblog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (460, 'Rianon', 'Mecchi', '1976-08-22', 'rmecchicr@whitehouse.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (461, 'Myrlene', 'Errichiello', '1983-05-11', 'merrichiellocs@godaddy.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (462, 'Nap', 'Tirte', '1971-10-25', 'ntirtect@cyberchimps.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (463, 'Orsa', 'Weth', '1985-10-02', 'owethcu@prweb.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (464, 'Borg', 'Feckey', '1978-04-26', 'bfeckeycv@arizona.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (465, 'Malissia', 'Cicculi', '1999-09-29', 'mcicculicw@ca.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (466, 'Karlene', 'Greenroyd', '1959-05-01', 'kgreenroydcx@weebly.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (467, 'Blaine', 'Welsby', '1980-09-05', 'bwelsbycy@lycos.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (468, 'Florette', 'Lineham', '1998-09-08', 'flinehamcz@infoseek.co.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (469, 'Theressa', 'Lansdale', '1966-04-29', 'tlansdaled0@naver.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (470, 'Stanwood', 'Aymer', '1987-08-08', 'saymerd1@uol.com.br');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (471, 'Van', 'Garrique', '1973-03-23', 'vgarriqued2@gizmodo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (472, 'Anastasia', 'Driussi', '1993-04-23', 'adriussid3@amazon.co.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (473, 'Alyss', 'Fairn', '1986-12-27', 'afairnd4@jiathis.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (474, 'Ora', 'Cracknell', '1979-12-01', 'ocracknelld5@webs.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (475, 'Pavla', 'Leebeter', '1976-02-14', 'pleebeterd6@cam.ac.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (476, 'Samuel', 'Lambird', '1956-07-07', 'slambirdd7@sciencedaily.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (477, 'Hildagard', 'Lettsom', '1977-07-03', 'hlettsomd8@fc2.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (478, 'Magdalena', 'Assard', '1951-12-29', 'massardd9@google.com.br');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (479, 'Theodore', 'Engley', '1972-08-30', 'tengleyda@scribd.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (480, 'Kacie', 'Plewes', '1969-12-28', 'kplewesdb@businesswire.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (481, 'Julita', 'O''Hanlon', '1996-05-07', 'johanlondc@upenn.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (482, 'Jamima', 'Maharey', '1990-07-09', 'jmahareydd@eepurl.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (483, 'Carita', 'Antal', '1964-11-24', 'cantalde@archive.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (484, 'Lydon', 'Sarle', '1981-03-08', 'lsarledf@mediafire.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (485, 'Benedikta', 'Rozycki', '1967-12-25', 'brozyckidg@meetup.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (486, 'Urban', 'Ruck', '1953-05-05', 'uruckdh@vimeo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (487, 'Gauthier', 'Mellodey', '1962-12-06', 'gmellodeydi@plala.or.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (488, 'Rorie', 'Beasleigh', '1991-05-07', 'rbeasleighdj@nature.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (489, 'Eilis', 'Newlands', '1958-09-02', 'enewlandsdk@comcast.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (490, 'Mae', 'McCambrois', '1998-11-10', 'mmccambroisdl@accuweather.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (491, 'Rozella', 'Quilkin', '1959-12-08', 'rquilkindm@istockphoto.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (492, 'Binny', 'Buchett', '2002-09-23', 'bbuchettdn@1und1.de');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (493, 'Jeannie', 'Zamudio', '1954-03-16', 'jzamudiodo@linkedin.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (494, 'Eduardo', 'Moukes', '1962-09-10', 'emoukesdp@baidu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (495, 'Aili', 'Reynault', '1984-12-16', 'areynaultdq@un.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (496, 'Ashli', 'Faraker', '1972-04-06', 'afarakerdr@phoca.cz');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (497, 'Manfred', 'Ballinghall', '1962-06-11', 'mballinghallds@phpbb.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (498, 'Jasmina', 'Gebb', '1989-06-26', 'jgebbdt@bravesites.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (499, 'Moshe', 'Darragh', '1990-01-25', 'mdarraghdu@cornell.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (500, 'Milt', 'Lightowler', '1993-09-09', 'mlightowlerdv@army.mil');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (501, 'Miguelita', 'Gyngell', '1998-07-06', 'mgyngelldw@disqus.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (502, 'Kerry', 'Labbe', '1953-01-19', 'klabbedx@forbes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (503, 'Suzi', 'Dukes', '1983-05-27', 'sdukesdy@nature.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (504, 'Fancy', 'Aylmer', '1964-05-13', 'faylmerdz@economist.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (505, 'Hurlee', 'Winnett', '1990-04-30', 'hwinnette0@taobao.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (506, 'Carry', 'Draycott', '1968-03-14', 'cdraycotte1@skyrock.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (507, 'Christyna', 'De Pero', '1996-11-26', 'cdeperoe2@google.com.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (508, 'Town', 'McCluney', '1980-02-15', 'tmccluneye3@drupal.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (509, 'Roxanna', 'Stonall', '1976-07-04', 'rstonalle4@weather.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (510, 'Moira', 'Roizn', '1988-12-24', 'mroizne5@ifeng.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (511, 'Bette', 'Anten', '1995-05-03', 'bantene6@sitemeter.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (512, 'Philis', 'Weerdenburg', '1981-08-31', 'pweerdenburge7@w3.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (513, 'Layla', 'Ferriere', '1984-11-19', 'lferrieree8@shutterfly.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (514, 'Donalt', 'Kristoffersen', '1959-05-22', 'dkristoffersene9@nature.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (515, 'Vance', 'Chadbourn', '1987-05-19', 'vchadbournea@webs.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (516, 'Mufi', 'Rubenczyk', '2002-06-09', 'mrubenczykeb@homestead.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (517, 'Carlynne', 'Bertomier', '2000-02-02', 'cbertomierec@topsy.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (518, 'Ange', 'Phillips', '1976-03-01', 'aphillipsed@pcworld.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (519, 'Ennis', 'Avrahm', '1973-06-28', 'eavrahmee@mapy.cz');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (520, 'Daniele', 'Canadine', '2000-03-12', 'dcanadineef@who.int');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (521, 'Winifield', 'Pridgeon', '1956-09-23', 'wpridgeoneg@apache.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (522, 'Marius', 'Duncklee', '1972-07-10', 'mdunckleeeh@shinystat.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (523, 'Christye', 'Fassman', '1964-01-01', 'cfassmanei@wikispaces.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (524, 'Jan', 'Gwatkin', '1983-08-19', 'jgwatkinej@discuz.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (525, 'Carmella', 'Whitecross', '1954-11-03', 'cwhitecrossek@diigo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (526, 'Harbert', 'Grunbaum', '1955-06-23', 'hgrunbaumel@patch.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (527, 'Anstice', 'Tremblet', '1970-04-22', 'atrembletem@photobucket.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (528, 'Oliver', 'Stonhard', '1995-01-31', 'ostonharden@php.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (529, 'Rriocard', 'Sterte', '1951-08-28', 'rsterteeo@mlb.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (530, 'Francklyn', 'Jecks', '1974-04-16', 'fjecksep@msn.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (531, 'Sumner', 'Gout', '1957-11-25', 'sgouteq@princeton.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (532, 'Xenos', 'Dooland', '1955-10-05', 'xdoolander@uol.com.br');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (533, 'Gardie', 'Asp', '1958-04-30', 'gaspes@vistaprint.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (534, 'Corrie', 'Catherall', '1981-12-07', 'ccatherallet@nymag.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (535, 'Osbert', 'Mole', '1963-04-02', 'omoleeu@sohu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (536, 'Illa', 'Spensly', '1988-07-22', 'ispenslyev@acquirethisname.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (537, 'Pepe', 'Mielnik', '1950-06-08', 'pmielnikew@kickstarter.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (538, 'Isabeau', 'Linn', '1957-02-08', 'ilinnex@unblog.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (539, 'Trude', 'Pauler', '1981-10-19', 'tpaulerey@theatlantic.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (540, 'Carmela', 'Eringey', '1991-07-23', 'ceringeyez@tumblr.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (541, 'Tanney', 'Meaking', '1989-07-30', 'tmeakingf0@yelp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (542, 'Jordanna', 'Polle', '1983-10-07', 'jpollef1@google.com.br');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (543, 'Artur', 'Fedoronko', '1959-11-21', 'afedoronkof2@vistaprint.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (544, 'Kathryn', 'MacGee', '1998-06-11', 'kmacgeef3@vistaprint.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (545, 'Anallise', 'Brewster', '1971-02-17', 'abrewsterf4@google.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (546, 'Malina', 'Jurries', '1994-10-16', 'mjurriesf5@mapy.cz');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (547, 'Anderea', 'Dewer', '1994-01-01', 'adewerf6@imdb.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (548, 'Chase', 'Cherry Holme', '1987-03-10', 'ccherryholmef7@typepad.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (549, 'Toiboid', 'Couch', '1954-05-07', 'tcouchf8@google.nl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (550, 'Lotti', 'Lantiffe', '1965-05-06', 'llantiffef9@hp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (551, 'Karissa', 'Dowding', '1976-10-18', 'kdowdingfa@hibu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (552, 'Martynne', 'Lilleman', '1970-05-26', 'mlillemanfb@sun.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (553, 'Elsie', 'McDiarmid', '1974-01-06', 'emcdiarmidfc@who.int');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (554, 'Olly', 'Whardley', '1996-08-17', 'owhardleyfd@arizona.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (555, 'Claude', 'Occleshaw', '1958-06-06', 'coccleshawfe@addthis.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (556, 'Rik', 'Swatridge', '1971-06-21', 'rswatridgeff@wufoo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (557, 'Ortensia', 'Reuble', '1980-06-07', 'oreublefg@businessinsider.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (558, 'Georgiana', 'Sadd', '1960-08-14', 'gsaddfh@hc360.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (559, 'Court', 'Cornils', '1980-10-18', 'ccornilsfi@t.co');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (560, 'Rollins', 'Fishley', '1986-06-27', 'rfishleyfj@bbc.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (561, 'Kevina', 'Ruddock', '1960-04-24', 'kruddockfk@blogger.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (562, 'Whitney', 'Tingle', '1962-07-25', 'wtinglefl@dion.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (563, 'Gabrila', 'Wrettum', '1965-07-28', 'gwrettumfm@columbia.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (564, 'Hagan', 'Ricks', '1969-04-19', 'hricksfn@wp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (565, 'Courtnay', 'Huson', '1973-12-08', 'chusonfo@jigsy.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (566, 'Collette', 'Andrichuk', '1986-10-22', 'candrichukfp@loc.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (567, 'Johnathan', 'Duffy', '1976-03-29', 'jduffyfq@gravatar.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (568, 'Irwin', 'Hryskiewicz', '1970-03-03', 'ihryskiewiczfr@redcross.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (569, 'Di', 'Skein', '1976-10-09', 'dskeinfs@123-reg.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (570, 'Lucina', 'De Lascy', '1957-02-10', 'ldelascyft@ihg.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (571, 'Feodor', 'Gardner', '1958-10-10', 'fgardnerfu@surveymonkey.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (572, 'Natka', 'Ziehm', '1958-07-17', 'nziehmfv@techcrunch.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (573, 'Rory', 'Edmeades', '1987-03-26', 'redmeadesfw@devhub.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (574, 'Brier', 'Puden', '1952-02-27', 'bpudenfx@gnu.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (575, 'Geraldine', 'Dumbrall', '1952-04-01', 'gdumbrallfy@fotki.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (576, 'Pinchas', 'Krolak', '1970-03-18', 'pkrolakfz@purevolume.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (577, 'Keven', 'Thurby', '2000-12-18', 'kthurbyg0@oracle.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (578, 'Loise', 'Thrasher', '2000-04-30', 'lthrasherg1@businesswire.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (579, 'Pail', 'Hammersley', '1973-08-22', 'phammersleyg2@tinyurl.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (580, 'Carrissa', 'Shurrock', '2001-02-07', 'cshurrockg3@gnu.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (581, 'Angelique', 'Vatcher', '1978-09-05', 'avatcherg4@wufoo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (582, 'Delcina', 'Cheek', '1961-08-13', 'dcheekg5@harvard.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (583, 'Vernor', 'Birk', '2002-08-07', 'vbirkg6@smh.com.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (584, 'Ryan', 'Vowden', '2001-01-22', 'rvowdeng7@apache.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (585, 'Conant', 'Nother', '1971-06-17', 'cnotherg8@ucoz.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (586, 'Glori', 'Burdell', '1952-09-11', 'gburdellg9@zdnet.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (587, 'Rubina', 'Andreasson', '1961-12-23', 'randreassonga@google.com.hk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (588, 'Xylina', 'Greated', '1969-02-11', 'xgreatedgb@shinystat.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (589, 'Hollyanne', 'Matveiko', '1999-02-25', 'hmatveikogc@a8.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (590, 'Niko', 'Battison', '1981-08-25', 'nbattisongd@flavors.me');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (591, 'Avrom', 'McCarry', '1997-07-12', 'amccarryge@sourceforge.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (592, 'Justine', 'Mounter', '1985-06-20', 'jmountergf@amazon.co.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (593, 'Lindie', 'Dadge', '1977-01-26', 'ldadgegg@dyndns.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (594, 'Luis', 'Kleinlerer', '1973-04-01', 'lkleinlerergh@instagram.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (595, 'Shannan', 'Donnachie', '1957-06-20', 'sdonnachiegi@sciencedirect.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (596, 'Willey', 'Rickis', '1955-11-26', 'wrickisgj@wp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (597, 'Melosa', 'Mundle', '1963-04-11', 'mmundlegk@google.com.br');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (598, 'Christin', 'Niles', '1974-09-03', 'cnilesgl@squidoo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (599, 'Bayard', 'Wandless', '1966-04-03', 'bwandlessgm@whitehouse.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (600, 'Lyle', 'Tick', '1973-10-03', 'ltickgn@gmpg.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (601, 'Rosy', 'Mordon', '1983-01-05', 'rmordongo@biblegateway.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (602, 'Ranna', 'Myatt', '1990-02-05', 'rmyattgp@histats.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (603, 'Toma', 'Ogborn', '1967-03-23', 'togborngq@cornell.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (604, 'Terrie', 'Godrich', '1955-12-25', 'tgodrichgr@telegraph.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (605, 'Annabela', 'Stranaghan', '2002-11-13', 'astranaghangs@narod.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (606, 'Karla', 'Veque', '1979-04-14', 'kvequegt@goo.gl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (607, 'Rey', 'De Clairmont', '1965-08-07', 'rdeclairmontgu@google.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (608, 'Edgardo', 'Grevel', '1956-11-27', 'egrevelgv@slideshare.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (609, 'Flin', 'Skough', '1985-03-27', 'fskoughgw@msn.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (610, 'Kirby', 'Pedrol', '1970-10-30', 'kpedrolgx@mtv.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (611, 'Jacky', 'Duffitt', '1991-10-27', 'jduffittgy@sciencedaily.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (612, 'Lorrin', 'Berriball', '1962-06-24', 'lberriballgz@linkedin.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (613, 'Penny', 'Tetford', '1996-11-10', 'ptetfordh0@sohu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (614, 'Thomasin', 'Najara', '1958-01-28', 'tnajarah1@issuu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (615, 'Peta', 'Paulmann', '1981-08-28', 'ppaulmannh2@google.com.hk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (616, 'Bobbye', 'Symondson', '1993-08-31', 'bsymondsonh3@google.co.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (617, 'Talbert', 'Leach', '1977-05-05', 'tleachh4@weather.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (618, 'Zaria', 'Randalson', '1984-05-23', 'zrandalsonh5@ask.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (619, 'Maddie', 'Emerton', '1971-03-29', 'memertonh6@woothemes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (620, 'Fraser', 'Fedder', '1969-02-04', 'ffedderh7@nps.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (621, 'Bartram', 'Nelle', '1963-12-22', 'bnelleh8@booking.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (622, 'Edsel', 'Banner', '1953-05-06', 'ebannerh9@unicef.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (623, 'Belle', 'George', '1978-07-22', 'bgeorgeha@sakura.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (624, 'Muriel', 'Van Der Vlies', '1998-09-24', 'mvandervlieshb@altervista.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (625, 'Caz', 'Pettigree', '1961-07-22', 'cpettigreehc@stumbleupon.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (626, 'Valerie', 'Tumielli', '1971-11-17', 'vtumiellihd@dailymail.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (627, 'Nerissa', 'Hinsche', '1990-07-13', 'nhinschehe@wp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (628, 'Davie', 'Davidavidovics', '1961-02-17', 'ddavidavidovicshf@nifty.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (629, 'Reggy', 'Kibbye', '2000-12-10', 'rkibbyehg@hexun.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (630, 'Kore', 'Densie', '1984-03-15', 'kdensiehh@upenn.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (631, 'Aristotle', 'Cunnane', '1957-12-15', 'acunnanehi@about.me');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (632, 'Roth', 'Ryson', '1998-01-11', 'rrysonhj@phoca.cz');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (633, 'Brittany', 'Winnett', '1985-04-28', 'bwinnetthk@msu.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (634, 'Janel', 'Rayworth', '2001-12-11', 'jrayworthhl@youtu.be');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (635, 'Vinny', 'Keech', '1963-05-03', 'vkeechhm@odnoklassniki.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (636, 'Edgardo', 'Macias', '1977-01-17', 'emaciashn@eepurl.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (637, 'Gabie', 'Ballintime', '1966-08-20', 'gballintimeho@yelp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (638, 'Silvio', 'Mitchel', '1960-07-14', 'smitchelhp@dailymotion.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (639, 'Maighdiln', 'Sorbey', '1992-08-26', 'msorbeyhq@ibm.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (640, 'Clem', 'Duley', '1974-12-02', 'cduleyhr@mapy.cz');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (641, 'Roanne', 'O''Giany', '1996-01-27', 'rogianyhs@com.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (642, 'Kathleen', 'Annatt', '1962-10-07', 'kannattht@statcounter.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (643, 'Kara', 'Sweatman', '1977-07-31', 'ksweatmanhu@eventbrite.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (644, 'Blake', 'Buncom', '1988-02-14', 'bbuncomhv@mashable.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (645, 'Allene', 'Brinicombe', '1997-02-27', 'abrinicombehw@un.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (646, 'Thea', 'Dutchburn', '1976-01-12', 'tdutchburnhx@biglobe.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (647, 'Muriel', 'Hess', '1957-04-04', 'mhesshy@wisc.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (648, 'Kenny', 'Sylvester', '1973-08-08', 'ksylvesterhz@netlog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (649, 'Ellwood', 'Bowcock', '2000-09-15', 'ebowcocki0@boston.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (650, 'Ryon', 'Habbershon', '1969-04-22', 'rhabbershoni1@edublogs.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (651, 'Rebeka', 'Husbands', '1964-05-29', 'rhusbandsi2@hostgator.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (652, 'Jacklin', 'Willimot', '1976-08-16', 'jwillimoti3@is.gd');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (653, 'Arabelle', 'Alps', '1989-12-28', 'aalpsi4@baidu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (654, 'Dan', 'Tunkin', '1969-06-20', 'dtunkini5@parallels.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (655, 'Glyn', 'O''Cooney', '1995-09-27', 'gocooneyi6@intel.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (656, 'Magda', 'Rollett', '1999-06-25', 'mrolletti7@soup.io');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (657, 'Rosabella', 'Kilpatrick', '1988-04-10', 'rkilpatricki8@51.la');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (658, 'Rossy', 'Shute', '1987-11-12', 'rshutei9@bloglovin.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (659, 'Morganne', 'Threadgould', '1980-02-13', 'mthreadgouldia@bizjournals.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (660, 'Adora', 'Coggles', '1990-03-22', 'acogglesib@ca.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (661, 'Justine', 'Defty', '1963-02-10', 'jdeftyic@usatoday.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (662, 'Dianemarie', 'Huckleby', '1981-11-21', 'dhucklebyid@skyrock.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (663, 'Brnaby', 'Gaber', '1959-05-27', 'bgaberie@yolasite.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (664, 'Kamillah', 'Donaho', '1996-02-07', 'kdonahoif@desdev.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (665, 'Johnathon', 'Ganforthe', '1968-11-17', 'jganfortheig@tumblr.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (666, 'Ibbie', 'Frany', '1952-12-26', 'ifranyih@globo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (667, 'Kristopher', 'Nolleau', '1994-01-06', 'knolleauii@ehow.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (668, 'Opaline', 'Mozzi', '1962-09-01', 'omozziij@bloglovin.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (669, 'Jeffrey', 'Markos', '2004-03-29', 'jmarkosik@spotify.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (670, 'Thomasin', 'Hanby', '1957-11-08', 'thanbyil@slate.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (671, 'Anneliese', 'Taffee', '1975-12-18', 'ataffeeim@mac.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (672, 'Willie', 'Quarless', '2004-08-07', 'wquarlessin@symantec.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (673, 'Ashley', 'Boast', '1985-07-12', 'aboastio@dailymotion.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (674, 'Gabie', 'Pimblotte', '1977-08-25', 'gpimblotteip@friendfeed.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (675, 'Zonda', 'Souter', '1952-09-16', 'zsouteriq@ovh.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (676, 'Cherianne', 'Rozalski', '1958-01-24', 'crozalskiir@huffingtonpost.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (677, 'Dulsea', 'Trill', '1990-07-24', 'dtrillis@ow.ly');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (678, 'Suzette', 'Basnett', '1985-06-20', 'sbasnettit@dion.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (679, 'Nicola', 'Hearsum', '1957-11-22', 'nhearsumiu@yellowbook.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (680, 'Halsy', 'Shires', '1978-06-08', 'hshiresiv@xrea.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (681, 'Connie', 'Beswetherick', '1962-10-14', 'cbeswetherickiw@wikia.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (682, 'Hailee', 'O''Cassidy', '1954-12-16', 'hocassidyix@github.io');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (683, 'Albert', 'Masi', '1950-04-14', 'amasiiy@smugmug.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (684, 'Jaquelyn', 'Flemmich', '1970-08-07', 'jflemmichiz@is.gd');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (685, 'Bertrand', 'Matelyunas', '2000-01-12', 'bmatelyunasj0@nhs.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (686, 'Claiborn', 'Worboys', '1966-05-26', 'cworboysj1@theatlantic.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (687, 'Raf', 'Beining', '1998-04-04', 'rbeiningj2@webs.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (688, 'Ripley', 'Boundley', '1997-08-30', 'rboundleyj3@hao123.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (689, 'Vonny', 'Castanie', '1985-12-09', 'vcastaniej4@bing.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (690, 'Brittaney', 'Wardrop', '1990-11-25', 'bwardropj5@latimes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (691, 'Emilio', 'Dows', '1992-07-18', 'edowsj6@icq.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (692, 'Griselda', 'Tal', '1961-05-30', 'gtalj7@netscape.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (693, 'Perle', 'MacNally', '1982-09-11', 'pmacnallyj8@creativecommons.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (694, 'Darrelle', 'Euplate', '1999-01-03', 'deuplatej9@wikipedia.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (695, 'Taryn', 'Dunnion', '1987-10-10', 'tdunnionja@google.ca');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (696, 'Elmore', 'Connachan', '1976-11-16', 'econnachanjb@illinois.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (697, 'Jillane', 'Wickenden', '1987-10-20', 'jwickendenjc@homestead.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (698, 'Arnaldo', 'Bumford', '1987-02-26', 'abumfordjd@pbs.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (699, 'Alika', 'Iveagh', '1988-05-11', 'aiveaghje@4shared.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (700, 'Meg', 'Cottey', '1985-09-10', 'mcotteyjf@tripod.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (701, 'Alexia', 'Kidder', '1953-11-05', 'akidderjg@a8.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (702, 'Rodina', 'Cypler', '1975-07-23', 'rcyplerjh@exblog.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (703, 'Ario', 'Feye', '1959-06-28', 'afeyeji@trellian.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (704, 'Gunter', 'Vost', '1966-10-14', 'gvostjj@utexas.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (705, 'Brit', 'Giblin', '1997-07-13', 'bgiblinjk@uol.com.br');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (706, 'Fabe', 'Margerrison', '1981-11-03', 'fmargerrisonjl@typepad.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (707, 'Zak', 'O''Meara', '1970-03-08', 'zomearajm@liveinternet.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (708, 'Miguela', 'Lehr', '1979-12-15', 'mlehrjn@go.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (709, 'Rene', 'Khan', '1982-04-27', 'rkhanjo@51.la');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (710, 'Nil', 'Gallatly', '1959-07-01', 'ngallatlyjp@yellowpages.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (711, 'Hunfredo', 'Enderson', '1986-10-22', 'hendersonjq@merriam-webster.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (712, 'Janina', 'Sturdey', '1981-05-20', 'jsturdeyjr@walmart.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (713, 'Teresina', 'Toffts', '1973-08-09', 'ttofftsjs@google.pl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (714, 'Belle', 'Lexa', '1984-07-19', 'blexajt@unc.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (715, 'Loralyn', 'Verman', '1967-02-18', 'lvermanju@fotki.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (716, 'Jeanie', 'McAuslene', '1990-03-02', 'jmcauslenejv@liveinternet.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (717, 'Elvyn', 'Antoons', '2000-05-20', 'eantoonsjw@plala.or.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (718, 'Leanna', 'McTear', '1996-05-12', 'lmctearjx@salon.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (719, 'Jasmin', 'Wasmer', '1957-12-13', 'jwasmerjy@irs.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (720, 'Salmon', 'Andryushchenko', '1969-04-11', 'sandryushchenkojz@fotki.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (721, 'Jacky', 'Brogden', '1968-02-27', 'jbrogdenk0@gravatar.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (722, 'Doloritas', 'Monsey', '1961-10-27', 'dmonseyk1@ca.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (723, 'Nessie', 'Dawtre', '1992-11-30', 'ndawtrek2@dailymotion.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (724, 'Shelly', 'Avon', '1968-09-23', 'savonk3@microsoft.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (725, 'Ikey', 'Biggadike', '1987-12-28', 'ibiggadikek4@a8.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (726, 'Joey', 'O Mullen', '1980-02-16', 'jomullenk5@unblog.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (727, 'Shaine', 'Shrimptone', '1975-12-21', 'sshrimptonek6@bandcamp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (728, 'Mickie', 'Maryman', '1972-04-25', 'mmarymank7@pbs.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (729, 'Deonne', 'Tayler', '1985-05-02', 'dtaylerk8@dyndns.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (730, 'Eldon', 'Dyott', '1960-12-05', 'edyottk9@youtube.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (731, 'Sidnee', 'Kleewein', '1965-05-05', 'skleeweinka@ucla.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (732, 'Dot', 'Bootton', '1964-02-21', 'dboottonkb@gmpg.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (733, 'Leela', 'Greeve', '1995-07-22', 'lgreevekc@uiuc.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (734, 'Tonya', 'Rosier', '1995-06-15', 'trosierkd@google.it');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (735, 'Halsey', 'Deniset', '1987-01-20', 'hdenisetke@etsy.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (736, 'Parker', 'Else', '1984-11-08', 'pelsekf@csmonitor.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (737, 'Kristy', 'Filippov', '1993-10-01', 'kfilippovkg@homestead.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (738, 'Jamie', 'Kees', '1952-09-15', 'jkeeskh@samsung.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (739, 'Patrizia', 'Sives', '1972-04-16', 'psiveski@com.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (740, 'Claudetta', 'People', '1972-09-07', 'cpeoplekj@google.nl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (741, 'Dorella', 'Nehl', '1993-10-08', 'dnehlkk@digg.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (742, 'Nathanial', 'Pache', '1958-12-28', 'npachekl@reverbnation.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (743, 'Cortney', 'McDonand', '1990-05-22', 'cmcdonandkm@godaddy.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (744, 'Alis', 'Naulty', '1965-07-21', 'anaultykn@desdev.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (745, 'Jamesy', 'Degnen', '1971-08-27', 'jdegnenko@homestead.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (746, 'Tory', 'Hevey', '2002-12-01', 'theveykp@delicious.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (747, 'Vivyanne', 'Poyle', '1971-06-02', 'vpoylekq@bloglovin.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (748, 'Holmes', 'Telling', '1991-03-28', 'htellingkr@globo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (749, 'Milzie', 'Fricker', '1979-02-07', 'mfrickerks@biglobe.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (750, 'Shawn', 'Easterfield', '1959-12-25', 'seasterfieldkt@tiny.cc');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (751, 'Dyana', 'McAlindon', '1979-06-12', 'dmcalindonku@mlb.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (752, 'Riki', 'Czaple', '1997-04-10', 'rczaplekv@digg.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (753, 'Kessiah', 'Loalday', '1985-04-25', 'kloaldaykw@tuttocitta.it');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (754, 'Brenden', 'Debrett', '1992-01-10', 'bdebrettkx@howstuffworks.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (755, 'Lenard', 'Vassall', '1978-05-26', 'lvassallky@php.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (756, 'Krystal', 'Steet', '1973-03-15', 'ksteetkz@yelp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (757, 'Elberta', 'Bernet', '1990-07-07', 'ebernetl0@wiley.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (758, 'Fawne', 'Domek', '1987-07-05', 'fdomekl1@tumblr.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (759, 'Silvio', 'Keable', '1952-10-01', 'skeablel2@com.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (760, 'Anna-diane', 'Micklewright', '1987-04-05', 'amicklewrightl3@vinaora.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (761, 'Cyril', 'Lockyer', '1991-08-29', 'clockyerl4@ihg.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (762, 'Odilia', 'Dearan', '1966-06-12', 'odearanl5@meetup.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (763, 'Daffie', 'Tourle', '1955-04-24', 'dtourlel6@blinklist.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (764, 'Evy', 'Jerwood', '1995-07-30', 'ejerwoodl7@jigsy.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (765, 'Kliment', 'Beacham', '1982-09-03', 'kbeachaml8@eventbrite.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (766, 'Reider', 'Nealy', '1971-08-23', 'rnealyl9@nytimes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (767, 'Bayard', 'Marcham', '1979-07-06', 'bmarchamla@canalblog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (768, 'Chrysler', 'Strangwood', '1977-06-08', 'cstrangwoodlb@ucoz.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (769, 'Nial', 'Twelvetree', '1974-11-01', 'ntwelvetreelc@dropbox.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (770, 'Hershel', 'Hathaway', '1969-01-16', 'hhathawayld@is.gd');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (771, 'Carter', 'Dundin', '1964-08-16', 'cdundinle@icq.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (772, 'Carrissa', 'Blanc', '1996-12-04', 'cblanclf@wisc.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (773, 'Welbie', 'Whyman', '1989-07-12', 'wwhymanlg@europa.eu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (774, 'Maye', 'Morsom', '1977-07-17', 'mmorsomlh@privacy.gov.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (775, 'Kristi', 'Dale', '1968-12-24', 'kdaleli@1und1.de');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (776, 'Simona', 'Dinkin', '1954-10-30', 'sdinkinlj@blog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (777, 'Silvester', 'Losebie', '1974-07-28', 'slosebielk@vkontakte.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (778, 'Chrystal', 'Whiffen', '1954-08-17', 'cwhiffenll@typepad.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (779, 'Gray', 'O''Connell', '1993-08-17', 'goconnelllm@engadget.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (780, 'Katerina', 'Turpey', '1951-07-07', 'kturpeyln@usda.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (781, 'Lesly', 'Francis', '1960-12-11', 'lfrancislo@amazonaws.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (782, 'Polly', 'Gavaran', '1968-03-28', 'pgavaranlp@umn.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (783, 'Adrianne', 'Crole', '1979-02-21', 'acrolelq@mozilla.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (784, 'Cherry', 'Buckie', '1965-12-04', 'cbuckielr@domainmarket.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (785, 'Tisha', 'Matijasevic', '1995-12-06', 'tmatijasevicls@a8.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (786, 'Reta', 'Atkirk', '1993-12-27', 'ratkirklt@canalblog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (787, 'Juanita', 'Henrot', '2004-06-28', 'jhenrotlu@msn.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (788, 'Ivar', 'Notton', '1950-01-13', 'inottonlv@archive.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (789, 'Jasun', 'Cordall', '1989-01-13', 'jcordalllw@list-manage.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (790, 'Bret', 'Von Salzberg', '1979-03-29', 'bvonsalzberglx@amazonaws.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (791, 'Harwilll', 'Betho', '1966-12-21', 'hbetholy@telegraph.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (792, 'Kora', 'Smalley', '2002-04-22', 'ksmalleylz@tiny.cc');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (793, 'Meghann', 'Pastor', '1953-08-12', 'mpastorm0@discuz.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (794, 'Jonathan', 'Maestro', '1971-11-25', 'jmaestrom1@qq.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (795, 'Kipper', 'Lacknor', '1957-02-22', 'klacknorm2@slashdot.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (796, 'Gwenny', 'Crossland', '2004-07-16', 'gcrosslandm3@senate.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (797, 'Claudio', 'Llorens', '1992-01-24', 'cllorensm4@a8.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (798, 'Jeana', 'Hackley', '1980-09-04', 'jhackleym5@ucsd.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (799, 'Budd', 'Klulik', '1957-02-17', 'bklulikm6@youtu.be');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (800, 'Luise', 'Corley', '1951-06-22', 'lcorleym7@unc.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (801, 'Sisely', 'Willgoose', '1975-11-25', 'swillgoosem8@epa.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (802, 'Curran', 'Rivard', '1983-02-26', 'crivardm9@cam.ac.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (803, 'Albina', 'Goodisson', '1984-07-11', 'agoodissonma@51.la');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (804, 'Gris', 'Pattesall', '1988-07-26', 'gpattesallmb@npr.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (805, 'Madelin', 'Baskeyfield', '1972-07-31', 'mbaskeyfieldmc@sfgate.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (806, 'Mari', 'Mitro', '2000-05-01', 'mmitromd@t.co');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (807, 'Hartwell', 'McKennan', '1962-06-09', 'hmckennanme@washingtonpost.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (808, 'Hermann', 'Mannix', '1976-10-20', 'hmannixmf@ted.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (809, 'Durante', 'Rothon', '1976-06-11', 'drothonmg@phoca.cz');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (810, 'Teodorico', 'O'' Ronan', '1957-08-02', 'toronanmh@house.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (811, 'Rowe', 'Quilty', '1959-05-14', 'rquiltymi@accuweather.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (812, 'Lotta', 'Elsbury', '1991-01-23', 'lelsburymj@nih.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (813, 'Stormy', 'Gerrelt', '1982-01-29', 'sgerreltmk@wp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (814, 'Jacobo', 'Jenman', '1990-03-10', 'jjenmanml@psu.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (815, 'Dane', 'Arnell', '1994-12-06', 'darnellmm@lycos.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (816, 'Wyatan', 'Bomb', '1984-12-07', 'wbombmn@dmoz.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (817, 'Ines', 'Chattell', '1956-04-18', 'ichattellmo@pbs.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (818, 'Windy', 'Drohan', '1990-05-28', 'wdrohanmp@fotki.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (819, 'Helenka', 'Passey', '1979-09-28', 'hpasseymq@businesswire.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (820, 'Breena', 'Brandle', '1965-01-05', 'bbrandlemr@bbc.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (821, 'Dolli', 'Burrage', '1973-05-20', 'dburragems@technorati.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (822, 'Luz', 'Rycroft', '1996-10-09', 'lrycroftmt@oracle.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (823, 'Ramona', 'Blanckley', '2001-05-10', 'rblanckleymu@altervista.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (824, 'Lorrie', 'Cawsby', '1953-01-09', 'lcawsbymv@army.mil');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (825, 'Cleon', 'Chadburn', '1998-10-04', 'cchadburnmw@craigslist.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (826, 'Veda', 'Hollyland', '1998-12-29', 'vhollylandmx@redcross.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (827, 'Hillel', 'Ruseworth', '1952-11-15', 'hruseworthmy@123-reg.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (828, 'Sam', 'Devons', '1953-02-13', 'sdevonsmz@cam.ac.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (829, 'Seka', 'Pratley', '1992-01-05', 'spratleyn0@redcross.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (830, 'Kameko', 'Stead', '1990-05-30', 'ksteadn1@wordpress.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (831, 'Gery', 'McSparran', '1983-03-15', 'gmcsparrann2@nytimes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (832, 'Tudor', 'Hairon', '1993-12-01', 'thaironn3@livejournal.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (833, 'Denney', 'Linny', '1981-03-19', 'dlinnyn4@europa.eu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (834, 'Hercule', 'Brideau', '1978-02-26', 'hbrideaun5@usgs.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (835, 'Anjela', 'Baldassi', '1971-03-12', 'abaldassin6@census.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (836, 'Ludvig', 'Ingilson', '1993-06-08', 'lingilsonn7@netvibes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (837, 'Loydie', 'Midden', '1951-08-27', 'lmiddenn8@plala.or.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (838, 'Stafani', 'Isenor', '1970-03-17', 'sisenorn9@people.com.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (839, 'Stevana', 'Shackell', '1990-03-04', 'sshackellna@unesco.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (840, 'Bertha', 'Maurice', '2000-10-03', 'bmauricenb@last.fm');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (841, 'Noak', 'Maymond', '1964-05-08', 'nmaymondnc@over-blog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (842, 'Margarete', 'Hickin', '1983-07-14', 'mhickinnd@addtoany.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (843, 'Clari', 'Spoerl', '1973-10-12', 'cspoerlne@oaic.gov.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (844, 'Benyamin', 'Egan', '1960-11-16', 'begannf@histats.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (845, 'Armando', 'Paskerful', '1997-12-25', 'apaskerfulng@narod.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (846, 'Kevina', 'Kloss', '1963-09-25', 'kklossnh@whitehouse.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (847, 'Mathilde', 'Burkinshaw', '2003-05-10', 'mburkinshawni@wikipedia.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (848, 'Vyky', 'Meddick', '1978-12-08', 'vmeddicknj@so-net.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (849, 'Rochell', 'Pargiter', '1951-10-23', 'rpargiternk@nps.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (850, 'Deana', 'Bould', '1951-07-01', 'dbouldnl@delicious.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (851, 'Brit', 'Churms', '2001-01-16', 'bchurmsnm@xing.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (852, 'Erek', 'Elliot', '1989-01-15', 'eelliotnn@bbb.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (853, 'Sean', 'Gammack', '1987-01-21', 'sgammackno@instagram.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (854, 'Willis', 'Hodinton', '1960-12-06', 'whodintonnp@hatena.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (855, 'Ashley', 'Houtbie', '1980-08-29', 'ahoutbienq@mysql.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (856, 'Pearl', 'Cromblehome', '1988-08-26', 'pcromblehomenr@independent.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (857, 'Janessa', 'Camidge', '1963-01-03', 'jcamidgens@psu.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (858, 'Franciskus', 'Baus', '1998-10-22', 'fbausnt@goo.ne.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (859, 'Gabi', 'Rosi', '1991-02-14', 'grosinu@mit.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (860, 'Joellyn', 'Losseljong', '1986-04-20', 'jlosseljongnv@last.fm');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (861, 'Gillie', 'Legerwood', '1969-12-29', 'glegerwoodnw@java.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (862, 'Kristal', 'Bencher', '1971-08-31', 'kbenchernx@tripadvisor.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (863, 'Matias', 'Shackelton', '1982-05-01', 'mshackeltonny@tamu.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (864, 'Erhart', 'Edmonstone', '1993-01-25', 'eedmonstonenz@dailymail.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (865, 'Roby', 'Garnar', '1952-10-17', 'rgarnaro0@quantcast.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (866, 'Mose', 'Sugden', '1969-02-24', 'msugdeno1@skyrock.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (867, 'Sloan', 'Ogelsby', '1963-05-17', 'sogelsbyo2@webs.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (868, 'Stuart', 'Readwood', '1966-03-09', 'sreadwoodo3@wp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (869, 'Demetrius', 'Deverall', '1962-10-26', 'ddeverallo4@smugmug.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (870, 'Anastasia', 'Colquyte', '1996-02-26', 'acolquyteo5@mlb.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (871, 'Norene', 'Ryle', '1971-05-25', 'nryleo6@mysql.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (872, 'Bailie', 'Backshaw', '1997-01-15', 'bbackshawo7@webmd.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (873, 'Harlan', 'Skarin', '1993-02-15', 'hskarino8@purevolume.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (874, 'Mirilla', 'Kingzeth', '1994-06-14', 'mkingzetho9@nature.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (875, 'Zeke', 'Vernham', '1988-03-13', 'zvernhamoa@twitpic.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (876, 'Antonella', 'Broseman', '1952-03-16', 'abrosemanob@freewebs.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (877, 'Samuele', 'Giamuzzo', '1958-03-11', 'sgiamuzzooc@webmd.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (878, 'Ariel', 'Gentzsch', '1984-05-10', 'agentzschod@marriott.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (879, 'Lois', 'Stile', '1978-03-17', 'lstileoe@umn.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (880, 'Robbie', 'Frankum', '1972-03-29', 'rfrankumof@mac.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (881, 'Harlene', 'Sidsaff', '1997-03-24', 'hsidsaffog@mapquest.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (882, 'Kimberlyn', 'Boncore', '2003-06-01', 'kboncoreoh@businessweek.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (883, 'Onfre', 'Ffoulkes', '1997-03-17', 'offoulkesoi@nhs.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (884, 'Mack', 'Moody', '1956-12-19', 'mmoodyoj@theguardian.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (885, 'Fax', 'Linkleter', '1979-01-08', 'flinkleterok@fc2.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (886, 'Gilemette', 'McArd', '1959-09-28', 'gmcardol@vimeo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (887, 'Pammie', 'Tomas', '1980-06-29', 'ptomasom@icq.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (888, 'Fran', 'Greengrass', '1995-09-06', 'fgreengrasson@devhub.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (889, 'Trueman', 'Comelli', '1964-10-15', 'tcomellioo@zdnet.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (890, 'Artemas', 'McCole', '1964-10-04', 'amccoleop@blogger.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (891, 'Padget', 'Mattheis', '1967-03-22', 'pmattheisoq@illinois.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (892, 'Lura', 'Seawright', '1982-05-05', 'lseawrightor@wired.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (893, 'Mirabel', 'Forlong', '1959-07-16', 'mforlongos@prnewswire.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (894, 'Catlee', 'Duerden', '1987-04-04', 'cduerdenot@utexas.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (895, 'Ruthann', 'Mochan', '1954-04-17', 'rmochanou@privacy.gov.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (896, 'Corrie', 'Prendiville', '1970-05-30', 'cprendivilleov@ask.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (897, 'Adore', 'Robilliard', '1962-01-16', 'arobilliardow@squarespace.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (898, 'Carmine', 'Farren', '1998-09-20', 'cfarrenox@wordpress.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (899, 'Feodora', 'Tokley', '1963-12-05', 'ftokleyoy@clickbank.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (900, 'Quinlan', 'Birdwhistell', '1951-09-18', 'qbirdwhistelloz@illinois.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (901, 'Isobel', 'Grancher', '1968-10-31', 'igrancherp0@vkontakte.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (902, 'Aylmar', 'Lune', '1980-03-21', 'alunep1@wiley.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (903, 'Rene', 'Feathers', '1955-04-29', 'rfeathersp2@nature.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (904, 'Druci', 'De Bruyn', '1957-11-03', 'ddebruynp3@cyberchimps.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (905, 'Broddie', 'Dabel', '2002-08-28', 'bdabelp4@cbsnews.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (906, 'Dora', 'Cuerdall', '1956-01-20', 'dcuerdallp5@ftc.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (907, 'Daile', 'Libbie', '1997-12-07', 'dlibbiep6@istockphoto.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (908, 'Rinaldo', 'Pauler', '1999-12-25', 'rpaulerp7@xrea.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (909, 'Nance', 'Brougham', '1981-05-24', 'nbroughamp8@surveymonkey.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (910, 'Hill', 'Blaksley', '1964-09-02', 'hblaksleyp9@tripadvisor.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (911, 'Garvin', 'Felix', '1994-08-14', 'gfelixpa@ycombinator.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (912, 'Verne', 'Wardhaugh', '1988-05-20', 'vwardhaughpb@miibeian.gov.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (913, 'Torin', 'Sunock', '1997-03-08', 'tsunockpc@google.es');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (914, 'Shayne', 'MacMeeking', '1985-01-04', 'smacmeekingpd@goodreads.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (915, 'Ethelbert', 'Swalough', '1969-03-27', 'eswaloughpe@is.gd');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (916, 'Germayne', 'Dounbare', '2004-07-06', 'gdounbarepf@cloudflare.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (917, 'Vinson', 'Duval', '1951-11-23', 'vduvalpg@wired.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (918, 'Waiter', 'Cornejo', '1999-04-16', 'wcornejoph@psu.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (919, 'Bentley', 'Clemens', '1958-03-17', 'bclemenspi@reddit.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (920, 'Royce', 'Ridings', '1990-07-06', 'rridingspj@loc.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (921, 'Coletta', 'English', '1980-07-11', 'cenglishpk@moonfruit.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (922, 'Waylan', 'Batter', '1989-01-09', 'wbatterpl@huffingtonpost.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (923, 'Maryl', 'Scothorne', '1953-04-27', 'mscothornepm@devhub.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (924, 'Pablo', 'Macer', '1997-02-26', 'pmacerpn@trellian.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (925, 'Tootsie', 'Boeter', '1970-01-08', 'tboeterpo@cpanel.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (926, 'Gary', 'Gawthrop', '1999-03-17', 'ggawthroppp@netscape.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (927, 'Lissa', 'Simison', '1958-12-02', 'lsimisonpq@nationalgeographic.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (928, 'Taryn', 'Madigan', '1976-12-11', 'tmadiganpr@123-reg.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (929, 'Olimpia', 'Skillett', '1983-06-10', 'oskillettps@scientificamerican.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (930, 'Tawnya', 'Lingfoot', '1950-07-25', 'tlingfootpt@house.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (931, 'Conan', 'Gwinnett', '1989-10-13', 'cgwinnettpu@pagesperso-orange.fr');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (932, 'Consolata', 'Deabill', '1999-10-31', 'cdeabillpv@amazon.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (933, 'Callie', 'Drought', '1966-05-10', 'cdroughtpw@time.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (934, 'Leilah', 'Connow', '1975-04-29', 'lconnowpx@diigo.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (935, 'Erek', 'Belliard', '1985-03-17', 'ebelliardpy@naver.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (936, 'Justina', 'Sarath', '1959-10-09', 'jsarathpz@qq.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (937, 'Jamaal', 'De Zamudio', '1963-05-11', 'jdezamudioq0@networksolutions.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (938, 'Lu', 'Astill', '1999-08-13', 'lastillq1@hp.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (939, 'Melvyn', 'Ingry', '1990-12-07', 'mingryq2@list-manage.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (940, 'Sibley', 'Walls', '1951-08-08', 'swallsq3@cam.ac.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (941, 'Kate', 'Lemin', '1990-09-17', 'kleminq4@homestead.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (942, 'Jolie', 'Larchier', '1961-05-15', 'jlarchierq5@theatlantic.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (943, 'Dilly', 'Simenon', '1988-05-01', 'dsimenonq6@narod.ru');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (944, 'Vic', 'Stonnell', '1967-03-12', 'vstonnellq7@seattletimes.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (945, 'Blakeley', 'Newarte', '1951-02-03', 'bnewarteq8@netscape.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (946, 'Alexandros', 'Reape', '1986-02-05', 'areapeq9@nps.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (947, 'Marylinda', 'Wailes', '1991-10-14', 'mwailesqa@fema.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (948, 'Vaclav', 'Sherston', '1957-05-14', 'vsherstonqb@baidu.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (949, 'Leonard', 'Eayres', '1993-07-22', 'leayresqc@msn.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (950, 'Kaia', 'Kybbye', '1979-06-04', 'kkybbyeqd@t.co');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (951, 'Anastasie', 'Lindman', '2003-11-28', 'alindmanqe@bbc.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (952, 'Birgitta', 'Ellwell', '2004-01-12', 'bellwellqf@rediff.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (953, 'Hermione', 'Rubroe', '1986-01-09', 'hrubroeqg@ox.ac.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (954, 'Zora', 'Jenson', '1976-02-29', 'zjensonqh@usda.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (955, 'Gil', 'MacPhaden', '1974-11-21', 'gmacphadenqi@apple.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (956, 'Kory', 'Wadworth', '1962-06-27', 'kwadworthqj@imageshack.us');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (957, 'Craig', 'Simonnot', '1993-03-25', 'csimonnotqk@howstuffworks.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (958, 'Vera', 'Wortman', '1986-01-06', 'vwortmanql@163.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (959, 'Kelly', 'Bernhardi', '1971-06-06', 'kbernhardiqm@mozilla.org');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (960, 'Dominica', 'McCritchie', '1960-11-25', 'dmccritchieqn@fastcompany.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (961, 'Maia', 'Wilcott', '2002-05-09', 'mwilcottqo@multiply.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (962, 'Jasun', 'Bonaire', '1994-05-13', 'jbonaireqp@dailymail.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (963, 'Carol', 'Waterhouse', '1956-11-19', 'cwaterhouseqq@imdb.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (964, 'Kelsi', 'Pill', '1993-06-28', 'kpillqr@bloomberg.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (965, 'Reginald', 'Vest', '1969-10-28', 'rvestqs@google.cn');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (966, 'Barbra', 'Herries', '1979-02-25', 'bherriesqt@shop-pro.jp');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (967, 'Gothart', 'Barbour', '2000-02-12', 'gbarbourqu@sciencedirect.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (968, 'Lynett', 'Braunlein', '1997-10-30', 'lbraunleinqv@reference.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (969, 'Christina', 'Petrovic', '2000-12-30', 'cpetrovicqw@google.com.au');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (970, 'Elinor', 'Trinkwon', '1955-10-08', 'etrinkwonqx@blinklist.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (971, 'Muffin', 'Skip', '1970-06-30', 'mskipqy@economist.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (972, 'Merrily', 'Slucock', '1997-05-10', 'mslucockqz@icio.us');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (973, 'Salaidh', 'Lyles', '1962-12-16', 'slylesr0@usa.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (974, 'Madison', 'Matis', '1957-05-14', 'mmatisr1@marketwatch.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (975, 'Amara', 'Ambrosini', '2000-01-16', 'aambrosinir2@nasa.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (976, 'Merissa', 'Bagenal', '1964-01-26', 'mbagenalr3@mozilla.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (977, 'Betti', 'Gaddas', '2000-01-12', 'bgaddasr4@ed.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (978, 'Nonnah', 'Bredgeland', '1968-03-24', 'nbredgelandr5@hc360.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (979, 'Shay', 'Maitland', '1983-11-20', 'smaitlandr6@canalblog.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (980, 'Tatiana', 'Henstone', '1973-11-16', 'thenstoner7@jalbum.net');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (981, 'Irving', 'Anthonsen', '1996-06-16', 'ianthonsenr8@friendfeed.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (982, 'Siegfried', 'Dobrowolski', '1975-09-21', 'sdobrowolskir9@alibaba.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (983, 'Dorey', 'Bromage', '1969-06-29', 'dbromagera@imgur.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (984, 'Erhart', 'Shinton', '1952-07-16', 'eshintonrb@mapy.cz');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (985, 'Katrinka', 'Boultwood', '1969-08-28', 'kboultwoodrc@engadget.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (986, 'Avrom', 'Cripin', '1978-04-28', 'acripinrd@posterous.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (987, 'Kevin', 'Wimpeney', '1965-11-24', 'kwimpeneyre@goodreads.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (988, 'Ame', 'Nellis', '1999-12-27', 'anellisrf@tamu.edu');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (989, 'Lefty', 'Kabsch', '1992-09-23', 'lkabschrg@paginegialle.it');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (990, 'Fina', 'Leinster', '1963-04-21', 'fleinsterrh@ycombinator.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (991, 'Selle', 'Smallpeice', '1950-08-16', 'ssmallpeiceri@ebay.co.uk');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (992, 'Lionello', 'Sparkwill', '1960-01-06', 'lsparkwillrj@ftc.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (993, 'Fidelia', 'Deniseau', '1990-09-12', 'fdeniseaurk@tinyurl.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (994, 'Amalea', 'Farrah', '1977-04-21', 'afarrahrl@accuweather.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (995, 'Fin', 'Dullard', '1954-03-30', 'fdullardrm@scientificamerican.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (996, 'Genia', 'Urion', '1961-04-01', 'gurionrn@fema.gov');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (997, 'Esteban', 'Spon', '1950-04-22', 'esponro@omniture.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (998, 'Ophelia', 'Faiers', '1974-01-22', 'ofaiersrp@disqus.com');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (999, 'Elsinore', 'Walshe', '1985-07-18', 'ewalsherq@google.pl');
insert into Participants (ParticipantID, FirstName, LastName, BirthDate, Email) values (1000, 'Cahra', 'Vogel', '1957-12-19', 'cvogelrr@dailymotion.com');
SET IDENTITY_INSERT Participants OFF
insert into Students (ParticipantID, CardID, ExpirationDate) values (741, 125245, '2018-08-12');
insert into Students (ParticipantID, CardID, ExpirationDate) values (465, 814984, '2021-10-26');
insert into Students (ParticipantID, CardID, ExpirationDate) values (525, 318180, '2018-06-26');
insert into Students (ParticipantID, CardID, ExpirationDate) values (85, 287861, '2021-05-11');
insert into Students (ParticipantID, CardID, ExpirationDate) values (831, 762039, '2022-07-10');
insert into Students (ParticipantID, CardID, ExpirationDate) values (881, 491555, '2024-09-27');
insert into Students (ParticipantID, CardID, ExpirationDate) values (260, 559262, '2025-12-18');
insert into Students (ParticipantID, CardID, ExpirationDate) values (492, 445145, '2021-07-01');
insert into Students (ParticipantID, CardID, ExpirationDate) values (820, 191827, '2025-10-20');
insert into Students (ParticipantID, CardID, ExpirationDate) values (220, 930467, '2025-08-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (1000, 311121, '2020-04-04');
insert into Students (ParticipantID, CardID, ExpirationDate) values (84, 285123, '2025-12-23');
insert into Students (ParticipantID, CardID, ExpirationDate) values (945, 648808, '2020-04-22');
insert into Students (ParticipantID, CardID, ExpirationDate) values (239, 908963, '2021-08-29');
insert into Students (ParticipantID, CardID, ExpirationDate) values (723, 902518, '2019-09-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (43, 724292, '2019-05-13');
insert into Students (ParticipantID, CardID, ExpirationDate) values (442, 950352, '2020-12-27');
insert into Students (ParticipantID, CardID, ExpirationDate) values (726, 550823, '2024-11-07');
insert into Students (ParticipantID, CardID, ExpirationDate) values (349, 993361, '2022-11-24');
insert into Students (ParticipantID, CardID, ExpirationDate) values (507, 922229, '2020-09-22');
insert into Students (ParticipantID, CardID, ExpirationDate) values (559, 936566, '2024-06-14');
insert into Students (ParticipantID, CardID, ExpirationDate) values (8, 788329, '2022-09-14');
insert into Students (ParticipantID, CardID, ExpirationDate) values (553, 153995, '2025-05-05');
insert into Students (ParticipantID, CardID, ExpirationDate) values (844, 391862, '2024-01-28');
insert into Students (ParticipantID, CardID, ExpirationDate) values (781, 242046, '2022-09-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (229, 963477, '2020-02-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (673, 640406, '2021-12-01');
insert into Students (ParticipantID, CardID, ExpirationDate) values (783, 415208, '2022-02-23');
insert into Students (ParticipantID, CardID, ExpirationDate) values (932, 103646, '2018-01-31');
insert into Students (ParticipantID, CardID, ExpirationDate) values (187, 139726, '2021-06-24');
insert into Students (ParticipantID, CardID, ExpirationDate) values (764, 414518, '2020-09-12');
insert into Students (ParticipantID, CardID, ExpirationDate) values (837, 266119, '2021-08-30');
insert into Students (ParticipantID, CardID, ExpirationDate) values (585, 530761, '2019-05-20');
insert into Students (ParticipantID, CardID, ExpirationDate) values (283, 492776, '2019-11-01');
insert into Students (ParticipantID, CardID, ExpirationDate) values (245, 368158, '2018-07-30');
insert into Students (ParticipantID, CardID, ExpirationDate) values (548, 509640, '2022-11-19');
insert into Students (ParticipantID, CardID, ExpirationDate) values (169, 395715, '2025-01-18');
insert into Students (ParticipantID, CardID, ExpirationDate) values (31, 220522, '2023-05-17');
insert into Students (ParticipantID, CardID, ExpirationDate) values (240, 496966, '2020-12-14');
insert into Students (ParticipantID, CardID, ExpirationDate) values (35, 336417, '2023-07-11');
insert into Students (ParticipantID, CardID, ExpirationDate) values (419, 161509, '2020-11-30');
insert into Students (ParticipantID, CardID, ExpirationDate) values (274, 107603, '2021-04-20');
insert into Students (ParticipantID, CardID, ExpirationDate) values (916, 973310, '2021-05-09');
insert into Students (ParticipantID, CardID, ExpirationDate) values (623, 404088, '2024-11-12');
insert into Students (ParticipantID, CardID, ExpirationDate) values (467, 614150, '2020-08-18');
insert into Students (ParticipantID, CardID, ExpirationDate) values (15, 432088, '2020-01-03');
insert into Students (ParticipantID, CardID, ExpirationDate) values (113, 278372, '2021-11-07');
insert into Students (ParticipantID, CardID, ExpirationDate) values (994, 366712, '2019-09-03');
insert into Students (ParticipantID, CardID, ExpirationDate) values (597, 957288, '2023-12-01');
insert into Students (ParticipantID, CardID, ExpirationDate) values (42, 623040, '2018-12-09');
insert into Students (ParticipantID, CardID, ExpirationDate) values (324, 722725, '2020-06-26');
insert into Students (ParticipantID, CardID, ExpirationDate) values (327, 624371, '2025-01-22');
insert into Students (ParticipantID, CardID, ExpirationDate) values (500, 493046, '2019-10-29');
insert into Students (ParticipantID, CardID, ExpirationDate) values (244, 720194, '2025-09-30');
insert into Students (ParticipantID, CardID, ExpirationDate) values (869, 700227, '2020-09-24');
insert into Students (ParticipantID, CardID, ExpirationDate) values (298, 424932, '2022-08-16');
insert into Students (ParticipantID, CardID, ExpirationDate) values (481, 153940, '2021-09-01');
insert into Students (ParticipantID, CardID, ExpirationDate) values (431, 700110, '2021-07-14');
insert into Students (ParticipantID, CardID, ExpirationDate) values (905, 836401, '2021-04-01');
insert into Students (ParticipantID, CardID, ExpirationDate) values (497, 168967, '2025-07-28');
insert into Students (ParticipantID, CardID, ExpirationDate) values (86, 221507, '2020-10-04');
insert into Students (ParticipantID, CardID, ExpirationDate) values (490, 282869, '2025-02-04');
insert into Students (ParticipantID, CardID, ExpirationDate) values (657, 772385, '2022-06-03');
insert into Students (ParticipantID, CardID, ExpirationDate) values (631, 578570, '2020-09-23');
insert into Students (ParticipantID, CardID, ExpirationDate) values (351, 516515, '2024-12-05');
insert into Students (ParticipantID, CardID, ExpirationDate) values (31, 356188, '2024-02-06');
insert into Students (ParticipantID, CardID, ExpirationDate) values (999, 425511, '2020-07-11');
insert into Students (ParticipantID, CardID, ExpirationDate) values (124, 830492, '2020-01-02');
insert into Students (ParticipantID, CardID, ExpirationDate) values (958, 198631, '2021-07-04');
insert into Students (ParticipantID, CardID, ExpirationDate) values (981, 190350, '2022-08-31');
insert into Students (ParticipantID, CardID, ExpirationDate) values (511, 116632, '2023-08-09');
insert into Students (ParticipantID, CardID, ExpirationDate) values (197, 855787, '2021-05-22');
insert into Students (ParticipantID, CardID, ExpirationDate) values (230, 879504, '2024-11-21');
insert into Students (ParticipantID, CardID, ExpirationDate) values (961, 795992, '2019-05-15');
insert into Students (ParticipantID, CardID, ExpirationDate) values (571, 692595, '2024-11-06');
insert into Students (ParticipantID, CardID, ExpirationDate) values (732, 632230, '2020-02-18');
insert into Students (ParticipantID, CardID, ExpirationDate) values (388, 731627, '2020-05-02');
insert into Students (ParticipantID, CardID, ExpirationDate) values (944, 833730, '2025-06-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (874, 865115, '2018-04-12');
insert into Students (ParticipantID, CardID, ExpirationDate) values (337, 386935, '2023-11-10');
insert into Students (ParticipantID, CardID, ExpirationDate) values (703, 633740, '2023-10-18');
insert into Students (ParticipantID, CardID, ExpirationDate) values (522, 452386, '2023-10-30');
insert into Students (ParticipantID, CardID, ExpirationDate) values (370, 871665, '2019-01-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (858, 482100, '2023-08-15');
insert into Students (ParticipantID, CardID, ExpirationDate) values (695, 964417, '2023-01-29');
insert into Students (ParticipantID, CardID, ExpirationDate) values (933, 535504, '2020-07-11');
insert into Students (ParticipantID, CardID, ExpirationDate) values (278, 686893, '2021-10-30');
insert into Students (ParticipantID, CardID, ExpirationDate) values (616, 388614, '2023-01-30');
insert into Students (ParticipantID, CardID, ExpirationDate) values (249, 951322, '2019-05-28');
insert into Students (ParticipantID, CardID, ExpirationDate) values (103, 526178, '2020-02-28');
insert into Students (ParticipantID, CardID, ExpirationDate) values (812, 765751, '2024-10-11');
insert into Students (ParticipantID, CardID, ExpirationDate) values (290, 215519, '2023-04-19');
insert into Students (ParticipantID, CardID, ExpirationDate) values (417, 401291, '2021-01-07');
insert into Students (ParticipantID, CardID, ExpirationDate) values (610, 990014, '2025-09-13');
insert into Students (ParticipantID, CardID, ExpirationDate) values (706, 859021, '2025-06-26');
insert into Students (ParticipantID, CardID, ExpirationDate) values (44, 902701, '2021-05-22');
insert into Students (ParticipantID, CardID, ExpirationDate) values (926, 852925, '2024-08-12');
insert into Students (ParticipantID, CardID, ExpirationDate) values (162, 976666, '2022-03-05');
insert into Students (ParticipantID, CardID, ExpirationDate) values (827, 825661, '2023-12-06');
insert into Students (ParticipantID, CardID, ExpirationDate) values (639, 272985, '2019-11-29');
insert into Students (ParticipantID, CardID, ExpirationDate) values (864, 634873, '2018-01-14');
insert into Students (ParticipantID, CardID, ExpirationDate) values (575, 305112, '2022-08-15');
insert into Students (ParticipantID, CardID, ExpirationDate) values (626, 734724, '2018-08-03');
insert into Students (ParticipantID, CardID, ExpirationDate) values (891, 584273, '2022-06-28');
insert into Students (ParticipantID, CardID, ExpirationDate) values (161, 262544, '2021-12-31');
insert into Students (ParticipantID, CardID, ExpirationDate) values (94, 766945, '2021-06-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (901, 272521, '2025-07-13');
insert into Students (ParticipantID, CardID, ExpirationDate) values (997, 611278, '2023-09-17');
insert into Students (ParticipantID, CardID, ExpirationDate) values (66, 936233, '2022-12-16');
insert into Students (ParticipantID, CardID, ExpirationDate) values (759, 984461, '2020-11-04');
insert into Students (ParticipantID, CardID, ExpirationDate) values (71, 404381, '2019-12-20');
insert into Students (ParticipantID, CardID, ExpirationDate) values (835, 907662, '2023-03-07');
insert into Students (ParticipantID, CardID, ExpirationDate) values (173, 642843, '2025-08-17');
insert into Students (ParticipantID, CardID, ExpirationDate) values (28, 363039, '2024-05-11');
insert into Students (ParticipantID, CardID, ExpirationDate) values (72, 605518, '2019-02-13');
insert into Students (ParticipantID, CardID, ExpirationDate) values (88, 881424, '2024-07-18');
insert into Students (ParticipantID, CardID, ExpirationDate) values (17, 547461, '2019-04-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (458, 235165, '2019-07-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (975, 213501, '2022-08-27');
insert into Students (ParticipantID, CardID, ExpirationDate) values (118, 945928, '2024-07-01');
insert into Students (ParticipantID, CardID, ExpirationDate) values (45, 225008, '2025-08-22');
insert into Students (ParticipantID, CardID, ExpirationDate) values (946, 975081, '2023-11-27');
insert into Students (ParticipantID, CardID, ExpirationDate) values (152, 117297, '2021-10-17');
insert into Students (ParticipantID, CardID, ExpirationDate) values (588, 777391, '2024-06-22');
insert into Students (ParticipantID, CardID, ExpirationDate) values (765, 311567, '2021-03-14');
insert into Students (ParticipantID, CardID, ExpirationDate) values (425, 579155, '2023-06-09');
insert into Students (ParticipantID, CardID, ExpirationDate) values (982, 271483, '2021-04-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (11, 630470, '2018-08-14');
insert into Students (ParticipantID, CardID, ExpirationDate) values (140, 418887, '2024-01-06');
insert into Students (ParticipantID, CardID, ExpirationDate) values (747, 860118, '2018-07-12');
insert into Students (ParticipantID, CardID, ExpirationDate) values (898, 489683, '2024-12-13');
insert into Students (ParticipantID, CardID, ExpirationDate) values (923, 995285, '2023-07-18');
insert into Students (ParticipantID, CardID, ExpirationDate) values (791, 447468, '2025-10-28');
insert into Students (ParticipantID, CardID, ExpirationDate) values (415, 875471, '2020-08-10');
insert into Students (ParticipantID, CardID, ExpirationDate) values (849, 828842, '2025-09-23');
insert into Students (ParticipantID, CardID, ExpirationDate) values (725, 563999, '2022-07-21');
insert into Students (ParticipantID, CardID, ExpirationDate) values (310, 418413, '2025-11-27');
insert into Students (ParticipantID, CardID, ExpirationDate) values (947, 372426, '2023-04-25');
insert into Students (ParticipantID, CardID, ExpirationDate) values (57, 461256, '2025-12-29');
insert into Students (ParticipantID, CardID, ExpirationDate) values (295, 962542, '2018-02-12');
insert into Students (ParticipantID, CardID, ExpirationDate) values (432, 386181, '2020-06-23');
insert into Students (ParticipantID, CardID, ExpirationDate) values (685, 194926, '2023-07-18');
insert into Students (ParticipantID, CardID, ExpirationDate) values (262, 336889, '2018-09-02');
insert into Students (ParticipantID, CardID, ExpirationDate) values (386, 534068, '2021-11-28');
insert into Students (ParticipantID, CardID, ExpirationDate) values (461, 534839, '2019-04-29');
insert into Students (ParticipantID, CardID, ExpirationDate) values (247, 116058, '2019-05-15');
insert into Students (ParticipantID, CardID, ExpirationDate) values (178, 831847, '2021-09-22');
insert into Students (ParticipantID, CardID, ExpirationDate) values (65, 489987, '2019-08-25');
insert into Students (ParticipantID, CardID, ExpirationDate) values (439, 203787, '2021-01-08');
insert into Students (ParticipantID, CardID, ExpirationDate) values (882, 737233, '2018-09-15');
insert into Students (ParticipantID, CardID, ExpirationDate) values (670, 826821, '2018-03-12');
insert into Students (ParticipantID, CardID, ExpirationDate) values (833, 436891, '2019-03-03');
insert into Students (ParticipantID, CardID, ExpirationDate) values (554, 966619, '2020-10-29');
insert into Students (ParticipantID, CardID, ExpirationDate) values (671, 394699, '2025-01-13');
insert into Students (ParticipantID, CardID, ExpirationDate) values (672, 536216, '2023-05-16');
insert into Students (ParticipantID, CardID, ExpirationDate) values (110, 373770, '2019-01-11');
insert into Students (ParticipantID, CardID, ExpirationDate) values (606, 231020, '2023-12-30');
insert into Students (ParticipantID, CardID, ExpirationDate) values (449, 653004, '2025-01-24');
insert into Students (ParticipantID, CardID, ExpirationDate) values (642, 624365, '2023-01-21');
insert into Students (ParticipantID, CardID, ExpirationDate) values (22, 926669, '2022-03-27');
insert into Students (ParticipantID, CardID, ExpirationDate) values (248, 591200, '2025-01-24');
insert into Students (ParticipantID, CardID, ExpirationDate) values (132, 208285, '2021-09-28');
insert into Students (ParticipantID, CardID, ExpirationDate) values (839, 536330, '2025-02-20');
insert into Students (ParticipantID, CardID, ExpirationDate) values (146, 847527, '2021-03-24');
insert into Students (ParticipantID, CardID, ExpirationDate) values (382, 837025, '2020-01-28');
insert into Students (ParticipantID, CardID, ExpirationDate) values (770, 796164, '2019-03-07');
insert into Students (ParticipantID, CardID, ExpirationDate) values (979, 331053, '2018-11-15');
insert into Students (ParticipantID, CardID, ExpirationDate) values (730, 176224, '2023-08-27');
insert into Students (ParticipantID, CardID, ExpirationDate) values (865, 668205, '2019-11-19');
insert into Students (ParticipantID, CardID, ExpirationDate) values (998, 681460, '2024-08-03');
insert into Students (ParticipantID, CardID, ExpirationDate) values (79, 832188, '2023-02-18');
insert into Students (ParticipantID, CardID, ExpirationDate) values (700, 799908, '2025-04-17');
insert into Students (ParticipantID, CardID, ExpirationDate) values (936, 355494, '2022-06-22');
insert into Students (ParticipantID, CardID, ExpirationDate) values (563, 896229, '2021-10-01');
insert into Students (ParticipantID, CardID, ExpirationDate) values (501, 296505, '2021-02-05');
insert into Students (ParticipantID, CardID, ExpirationDate) values (825, 152786, '2019-08-20');
insert into Students (ParticipantID, CardID, ExpirationDate) values (986, 881036, '2025-09-04');
insert into Students (ParticipantID, CardID, ExpirationDate) values (40, 967290, '2025-03-26');
insert into Students (ParticipantID, CardID, ExpirationDate) values (379, 125496, '2020-07-27');
insert into Students (ParticipantID, CardID, ExpirationDate) values (937, 843399, '2019-12-04');
insert into Students (ParticipantID, CardID, ExpirationDate) values (593, 822915, '2024-02-09');
insert into Students (ParticipantID, CardID, ExpirationDate) values (758, 108580, '2019-04-07');
insert into Students (ParticipantID, CardID, ExpirationDate) values (556, 982667, '2024-12-13');
insert into Students (ParticipantID, CardID, ExpirationDate) values (607, 188829, '2021-03-15');
SET IDENTITY_INSERT Employees ON
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (1, 'Cate', 'Denzilow', '97 Sutherland Junction', 'Taiyangling', '975875869');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (2, 'Tate', 'Alster', '63227 Hudson Avenue', 'Dallas', '915249080');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (3, 'Hobie', 'Whellans', '46120 Morrow Court', 'Limbi', '836037955');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (4, 'Harriott', 'Whaplington', '15318 Mariners Cove Alley', 'Yanac', '914030487');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (5, 'Conn', 'Ketley', '37233 Almo Pass', 'Pagersari', '820139117');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (6, 'Willabella', 'Dewi', '5 Anniversary Crossing', 'Rzeszów', '941229031');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (7, 'Georgie', 'Figgures', '92639 High Crossing Street', 'Jingang', '920775758');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (8, 'Athena', 'Junifer', '73838 Rusk Circle', 'Princeville', '939342309');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (9, 'Veronica', 'Bulpitt', '684 Goodland Street', 'Embalse', '997074698');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (10, 'Giffer', 'Odcroft', '64 Division Hill', 'Silikatnyy', '593715272');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (11, 'Jefferson', 'Roo', '19975 Cody Hill', 'Modis', '760723707');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (12, 'Welsh', 'Meachen', '2 Superior Park', 'Huntington', '942941779');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (13, 'Dasi', 'Davern', '582 Hanson Road', 'Regimin', '503920492');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (14, 'Brose', 'Spellworth', '7335 Reindahl Parkway', 'Lyon', '749493868');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (15, 'Carny', 'Petric', '60 Kipling Trail', 'Tunjë', '825929426');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (16, 'Joshua', 'Ziemens', '865 Graceland Point', 'Mīāndoāb', '718781757');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (17, 'Marjorie', 'Ennals', '2 Shoshone Alley', 'Osa', '568948749');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (18, 'North', 'Batsford', '096 4th Center', 'Berezanka', '520733076');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (19, 'Michael', 'Soldan', '8068 Burning Wood Avenue', 'Fukuchiyama', '672261424');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (20, 'Mariya', 'Hulmes', '25180 Loeprich Park', 'Pomabamba', '748945158');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (21, 'Colby', 'Abbots', '50 Porter Parkway', 'Qilin', '805672309');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (22, 'Gordon', 'Cloughton', '40 Oxford Junction', 'Chunyang', '549060284');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (23, 'Rianon', 'Minico', '52 Annamark Drive', 'Huangcun', '838520887');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (24, 'Murdock', 'Westphal', '42 Golf Course Junction', 'Concordia', '953949264');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (25, 'Papageno', 'Challice', '659 Colorado Park', 'Dordrecht', '892282849');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (26, 'Erminie', 'Elvidge', '0596 Veith Street', 'Quezaltepeque', '881415135');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (27, 'Sibelle', 'Dorran', '2199 Pearson Plaza', 'Partizan', '527474849');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (28, 'Madeleine', 'Ribchester', '43866 Utah Terrace', 'Ervedosa do Douro', '913633247');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (29, 'Averill', 'Bainton', '7 Russell Point', 'Sergach', '940834893');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (30, 'Trixy', 'Kollaschek', '46 Almo Alley', 'Perrelos', '926235305');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (31, 'Cortie', 'Gidley', '7 Doe Crossing Pass', 'Xinbao', '962735290');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (32, 'Bevin', 'Pressland', '643 Holmberg Center', 'Dengfeng', '881160651');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (33, 'Lucille', 'Kumaar', '465 Corben Alley', 'Qiganjidie', '775112497');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (34, 'Paulette', 'Ramsbottom', '023 Dryden Lane', 'Mercedes', '950166154');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (35, 'Rosy', 'Woolatt', '792 Summerview Court', 'Coronda', '574433665');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (36, 'Rockie', 'Kleisel', '71436 Paget Terrace', 'Slobodka', '917947786');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (37, 'Annamaria', 'Jowling', '188 Kenwood Trail', 'Pecna', '826862316');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (38, 'Isahella', 'Sears', '23 Lawn Crossing', 'El Paso', '852799470');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (39, 'Sascha', 'Standrin', '53697 Grim Street', 'Buliran', '812950089');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (40, 'Angel', 'Jenman', '74 Milwaukee Place', 'Chengzihe', '922711745');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (41, 'Jarrod', 'Resun', '2 Talmadge Road', 'El Tejocote', '934910176');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (42, 'Meagan', 'Le Maitre', '892 Jackson Center', 'Krasnogvardeyets', '924334323');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (43, 'Clair', 'Zanazzi', '4710 Brentwood Avenue', 'Malitbog', '623305626');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (44, 'Marnia', 'Mettetal', '1906 Iowa Junction', 'Wārāh', '664314801');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (45, 'Finlay', 'Vitall', '1 Sullivan Plaza', 'Lípa', '951553158');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (46, 'Clementia', 'Grgic', '6 Moulton Plaza', 'Rrasa e Sipërme', '891691525');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (47, 'Garv', 'Peplow', '3761 Havey Junction', 'Federal', '971657493');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (48, 'Gennifer', 'Breen', '459 Leroy Road', 'Iganga', '943710886');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (49, 'Freda', 'Lambrook', '0080 Michigan Place', 'Pavlivka', '718245715');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (50, 'Car', 'Rowan', '39 Lakewood Avenue', 'Oslo', '831819118');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (51, 'Artus', 'Carne', '517 Walton Alley', 'Janja', '876566164');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (52, 'Sherrie', 'Dargan', '658 Longview Trail', 'Saint-Quentin-en-Yvelines', '904747328');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (53, 'Xaviera', 'Spridgeon', '9645 Jenifer Avenue', 'Kondinskoye', '953416533');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (54, 'Allyce', 'Courcey', '44 Mallory Drive', 'Gorang', '843586111');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (55, 'Janella', 'Benoi', '3051 Pankratz Place', 'Železná Ruda', '585330578');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (56, 'Maridel', 'Twomey', '18 Hanover Junction', 'Puračić', '877291709');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (57, 'Ichabod', 'Boler', '25648 Daystar Pass', 'Noyemberyan', '737515024');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (58, 'Madlen', 'Sinnocke', '35 Twin Pines Drive', 'Guofu', '764670331');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (59, 'Earlie', 'Allard', '798 Pennsylvania Junction', 'Boshan', '994219505');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (60, 'Nathalia', 'Sherred', '1133 Kingsford Way', 'Qingsong', '999703148');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (61, 'Edik', 'Rijkeseis', '63767 Surrey Lane', 'Kiambu', '876299843');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (62, 'Guillemette', 'Legister', '36 Tennessee Junction', 'Obsza', '783386592');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (63, 'Emmye', 'Olifaunt', '94655 Manufacturers Park', 'Vũng Tàu', '912249850');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (64, 'Carree', 'Rootham', '960 Sommers Street', 'Piekoszów', '630832193');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (65, 'Weider', 'Hall-Gough', '5 Banding Alley', 'Guanajuato', '819132987');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (66, 'Darbee', 'Held', '218 Springs Way', 'Neftçala', '803762384');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (67, 'Dominick', 'Orrill', '3 Armistice Circle', 'Baume-les-Dames', '941315126');
insert into Employees (EmployeeID, FirstName, LastName, Address, City, Phone) values (68, 'Dorene', 'Armand', '6830 Sullivan Plaza', 'Mlandizi', '862928148');
SET IDENTITY_INSERT Employees OFF
ALTER TABLE Conferences DISABLE TRIGGER ForbidToSpecifyConferencesFromThePast
EXEC AddConference @ConferenceName ='Pasta la Vista', @StartDate ='2019-01-14', @DaysAmount =7, @ConferenceType ='Multilingual', @BuildingID =36, @OrganizerID =4, @CustomerID =2
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 148, @Date = '2019-01-14', @ConferenceID = 1
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 146, @Date = '2019-01-15', @ConferenceID = 1
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 59, @Date = '2019-01-16', @ConferenceID = 1
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 197, @Date = '2019-01-17', @ConferenceID = 1
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 133, @Date = '2019-01-18', @ConferenceID = 1
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 107, @Date = '2019-01-19', @ConferenceID = 1
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 181, @Date = '2019-01-20', @ConferenceID = 1
EXEC AddConference @ConferenceName ='Psychothon', @StartDate ='2018-03-19', @DaysAmount =6, @ConferenceType ='Entertainment', @BuildingID =37, @OrganizerID =36, @CustomerID =33
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 139, @Date = '2018-03-19', @ConferenceID = 2
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 165, @Date = '2018-03-20', @ConferenceID = 2
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 99, @Date = '2018-03-21', @ConferenceID = 2
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 154, @Date = '2018-03-22', @ConferenceID = 2
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 129, @Date = '2018-03-23', @ConferenceID = 2
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 52, @Date = '2018-03-24', @ConferenceID = 2
EXEC AddConference @ConferenceName ='Howl Movement', @StartDate ='2017-10-07', @DaysAmount =6, @ConferenceType ='Media', @BuildingID =5, @OrganizerID =21, @CustomerID =46
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 73, @Date = '2017-10-07', @ConferenceID = 3
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 158, @Date = '2017-10-08', @ConferenceID = 3
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 115, @Date = '2017-10-09', @ConferenceID = 3
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 197, @Date = '2017-10-10', @ConferenceID = 3
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 125, @Date = '2017-10-11', @ConferenceID = 3
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 89, @Date = '2017-10-12', @ConferenceID = 3
EXEC AddConference @ConferenceName ='Vow Vagner', @StartDate ='2018-06-05', @DaysAmount =3, @ConferenceType ='Entertainment', @BuildingID =26, @OrganizerID =13, @CustomerID =13
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 158, @Date = '2018-06-05', @ConferenceID = 4
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 171, @Date = '2018-06-06', @ConferenceID = 4
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 131, @Date = '2018-06-07', @ConferenceID = 4
EXEC AddConference @ConferenceName ='Dude Raunch', @StartDate ='2016-09-05', @DaysAmount =6, @ConferenceType ='Business', @BuildingID =21, @OrganizerID =23, @CustomerID =65
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 109, @Date = '2016-09-05', @ConferenceID = 5
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 192, @Date = '2016-09-06', @ConferenceID = 5
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 51, @Date = '2016-09-07', @ConferenceID = 5
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 181, @Date = '2016-09-08', @ConferenceID = 5
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 170, @Date = '2016-09-09', @ConferenceID = 5
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 81, @Date = '2016-09-10', @ConferenceID = 5
EXEC AddConference @ConferenceName ='Dramantra', @StartDate ='2018-07-17', @DaysAmount =5, @ConferenceType ='Multilingual', @BuildingID =42, @OrganizerID =45, @CustomerID =33
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 121, @Date = '2018-07-17', @ConferenceID = 6
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 43, @Date = '2018-07-18', @ConferenceID = 6
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 169, @Date = '2018-07-19', @ConferenceID = 6
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 135, @Date = '2018-07-20', @ConferenceID = 6
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 138, @Date = '2018-07-21', @ConferenceID = 6
EXEC AddConference @ConferenceName ='Indian Summer', @StartDate ='2018-01-18', @DaysAmount =4, @ConferenceType ='Scientific', @BuildingID =42, @OrganizerID =29, @CustomerID =12
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 117, @Date = '2018-01-18', @ConferenceID = 7
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 77, @Date = '2018-01-19', @ConferenceID = 7
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 57, @Date = '2018-01-20', @ConferenceID = 7
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 171, @Date = '2018-01-21', @ConferenceID = 7
EXEC AddConference @ConferenceName ='Far Away Feast', @StartDate ='2016-09-04', @DaysAmount =4, @ConferenceType ='Business', @BuildingID =41, @OrganizerID =1, @CustomerID =23
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 157, @Date = '2016-09-04', @ConferenceID = 8
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 98, @Date = '2016-09-05', @ConferenceID = 8
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 42, @Date = '2016-09-06', @ConferenceID = 8
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 175, @Date = '2016-09-07', @ConferenceID = 8
EXEC AddConference @ConferenceName ='Ritual Wave', @StartDate ='2017-02-09', @DaysAmount =4, @ConferenceType ='Multilingual', @BuildingID =36, @OrganizerID =32, @CustomerID =31
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 91, @Date = '2017-02-09', @ConferenceID = 9
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 122, @Date = '2017-02-10', @ConferenceID = 9
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 104, @Date = '2017-02-11', @ConferenceID = 9
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 77, @Date = '2017-02-12', @ConferenceID = 9
EXEC AddConference @ConferenceName ='Dance Vibrations', @StartDate ='2016-07-08', @DaysAmount =5, @ConferenceType ='Scientific', @BuildingID =5, @OrganizerID =27, @CustomerID =54
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 94, @Date = '2016-07-08', @ConferenceID = 10
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 155, @Date = '2016-07-09', @ConferenceID = 10
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 89, @Date = '2016-07-10', @ConferenceID = 10
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 170, @Date = '2016-07-11', @ConferenceID = 10
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 126, @Date = '2016-07-12', @ConferenceID = 10
EXEC AddConference @ConferenceName ='Basking Bingo', @StartDate ='2017-09-17', @DaysAmount =3, @ConferenceType ='Multilingual', @BuildingID =43, @OrganizerID =49, @CustomerID =56
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 161, @Date = '2017-09-17', @ConferenceID = 11
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 200, @Date = '2017-09-18', @ConferenceID = 11
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 40, @Date = '2017-09-19', @ConferenceID = 11
EXEC AddConference @ConferenceName ='Objectify Your Future', @StartDate ='2021-03-01', @DaysAmount =4, @ConferenceType ='Entertainment', @BuildingID =15, @OrganizerID =38, @CustomerID =39
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 199, @Date = '2021-03-01', @ConferenceID = 12
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 140, @Date = '2021-03-02', @ConferenceID = 12
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 148, @Date = '2021-03-03', @ConferenceID = 12
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 57, @Date = '2021-03-04', @ConferenceID = 12
EXEC AddConference @ConferenceName ='Smart Ask', @StartDate ='2017-03-04', @DaysAmount =6, @ConferenceType ='Multilingual', @BuildingID =49, @OrganizerID =24, @CustomerID =28
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 35, @Date = '2017-03-04', @ConferenceID = 13
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 62, @Date = '2017-03-05', @ConferenceID = 13
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 155, @Date = '2017-03-06', @ConferenceID = 13
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 172, @Date = '2017-03-07', @ConferenceID = 13
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 158, @Date = '2017-03-08', @ConferenceID = 13
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 102, @Date = '2017-03-09', @ConferenceID = 13
EXEC AddConference @ConferenceName ='Survival of the Fattest', @StartDate ='2020-11-15', @DaysAmount =4, @ConferenceType ='Media', @BuildingID =25, @OrganizerID =28, @CustomerID =19
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 67, @Date = '2020-11-15', @ConferenceID = 14
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 72, @Date = '2020-11-16', @ConferenceID = 14
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 79, @Date = '2020-11-17', @ConferenceID = 14
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 87, @Date = '2020-11-18', @ConferenceID = 14
EXEC AddConference @ConferenceName ='Soma Night', @StartDate ='2021-04-19', @DaysAmount =5, @ConferenceType ='Business', @BuildingID =14, @OrganizerID =50, @CustomerID =61
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 80, @Date = '2021-04-19', @ConferenceID = 15
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 123, @Date = '2021-04-20', @ConferenceID = 15
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 36, @Date = '2021-04-21', @ConferenceID = 15
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 130, @Date = '2021-04-22', @ConferenceID = 15
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 76, @Date = '2021-04-23', @ConferenceID = 15
EXEC AddConference @ConferenceName ='Mississippi Moments', @StartDate ='2020-06-19', @DaysAmount =5, @ConferenceType ='Scientific', @BuildingID =4, @OrganizerID =25, @CustomerID =25
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 191, @Date = '2020-06-19', @ConferenceID = 16
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 115, @Date = '2020-06-20', @ConferenceID = 16
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 120, @Date = '2020-06-21', @ConferenceID = 16
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 60, @Date = '2020-06-22', @ConferenceID = 16
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 55, @Date = '2020-06-23', @ConferenceID = 16
EXEC AddConference @ConferenceName ='Pipe Dreams', @StartDate ='2020-10-01', @DaysAmount =7, @ConferenceType ='Business', @BuildingID =38, @OrganizerID =7, @CustomerID =55
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 146, @Date = '2020-10-01', @ConferenceID = 17
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 143, @Date = '2020-10-02', @ConferenceID = 17
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 81, @Date = '2020-10-03', @ConferenceID = 17
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 77, @Date = '2020-10-04', @ConferenceID = 17
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 33, @Date = '2020-10-05', @ConferenceID = 17
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 40, @Date = '2020-10-06', @ConferenceID = 17
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 58, @Date = '2020-10-07', @ConferenceID = 17
EXEC AddConference @ConferenceName ='Sans Charo', @StartDate ='2017-04-17', @DaysAmount =4, @ConferenceType ='Multilingual', @BuildingID =50, @OrganizerID =40, @CustomerID =61
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 66, @Date = '2017-04-17', @ConferenceID = 18
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 168, @Date = '2017-04-18', @ConferenceID = 18
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 68, @Date = '2017-04-19', @ConferenceID = 18
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 151, @Date = '2017-04-20', @ConferenceID = 18
EXEC AddConference @ConferenceName ='Of Corsica', @StartDate ='2016-01-19', @DaysAmount =3, @ConferenceType ='Media', @BuildingID =41, @OrganizerID =41, @CustomerID =31
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 35, @Date = '2016-01-19', @ConferenceID = 19
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 108, @Date = '2016-01-20', @ConferenceID = 19
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 149, @Date = '2016-01-21', @ConferenceID = 19
EXEC AddConference @ConferenceName ='Hit the Good Books', @StartDate ='2021-02-15', @DaysAmount =3, @ConferenceType ='Media', @BuildingID =28, @OrganizerID =20, @CustomerID =63
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 178, @Date = '2021-02-15', @ConferenceID = 20
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 171, @Date = '2021-02-16', @ConferenceID = 20
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 80, @Date = '2021-02-17', @ConferenceID = 20
EXEC AddConference @ConferenceName ='Digital Planet', @StartDate ='2017-09-04', @DaysAmount =4, @ConferenceType ='Media', @BuildingID =37, @OrganizerID =37, @CustomerID =38
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 79, @Date = '2017-09-04', @ConferenceID = 21
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 64, @Date = '2017-09-05', @ConferenceID = 21
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 193, @Date = '2017-09-06', @ConferenceID = 21
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 68, @Date = '2017-09-07', @ConferenceID = 21
EXEC AddConference @ConferenceName ='Wet the People', @StartDate ='2017-06-08', @DaysAmount =3, @ConferenceType ='Media', @BuildingID =6, @OrganizerID =15, @CustomerID =25
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 30, @Date = '2017-06-08', @ConferenceID = 22
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 184, @Date = '2017-06-09', @ConferenceID = 22
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 70, @Date = '2017-06-10', @ConferenceID = 22
EXEC AddConference @ConferenceName ='Quantifying Larry', @StartDate ='2020-12-04', @DaysAmount =7, @ConferenceType ='Multilingual', @BuildingID =49, @OrganizerID =42, @CustomerID =68
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 184, @Date = '2020-12-04', @ConferenceID = 23
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 116, @Date = '2020-12-05', @ConferenceID = 23
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 73, @Date = '2020-12-06', @ConferenceID = 23
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 144, @Date = '2020-12-07', @ConferenceID = 23
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 198, @Date = '2020-12-08', @ConferenceID = 23
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 42, @Date = '2020-12-09', @ConferenceID = 23
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 89, @Date = '2020-12-10', @ConferenceID = 23
EXEC AddConference @ConferenceName ='Smokin� the Data', @StartDate ='2017-03-13', @DaysAmount =7, @ConferenceType ='Scientific', @BuildingID =31, @OrganizerID =41, @CustomerID =70
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 35, @Date = '2017-03-13', @ConferenceID = 24
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 88, @Date = '2017-03-14', @ConferenceID = 24
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 69, @Date = '2017-03-15', @ConferenceID = 24
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 185, @Date = '2017-03-16', @ConferenceID = 24
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 170, @Date = '2017-03-17', @ConferenceID = 24
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 99, @Date = '2017-03-18', @ConferenceID = 24
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 61, @Date = '2017-03-19', @ConferenceID = 24
EXEC AddConference @ConferenceName ='Forty Five Kids, Hot Dogs and Spaghetti', @StartDate ='2017-11-11', @DaysAmount =5, @ConferenceType ='Scientific', @BuildingID =48, @OrganizerID =14, @CustomerID =66
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 104, @Date = '2017-11-11', @ConferenceID = 25
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 39, @Date = '2017-11-12', @ConferenceID = 25
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 150, @Date = '2017-11-13', @ConferenceID = 25
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 45, @Date = '2017-11-14', @ConferenceID = 25
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 150, @Date = '2017-11-15', @ConferenceID = 25
EXEC AddConference @ConferenceName ='OpenDoor', @StartDate ='2017-04-13', @DaysAmount =6, @ConferenceType ='Media', @BuildingID =13, @OrganizerID =17, @CustomerID =24
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 197, @Date = '2017-04-13', @ConferenceID = 26
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 32, @Date = '2017-04-14', @ConferenceID = 26
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 119, @Date = '2017-04-15', @ConferenceID = 26
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 86, @Date = '2017-04-16', @ConferenceID = 26
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 110, @Date = '2017-04-17', @ConferenceID = 26
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 31, @Date = '2017-04-18', @ConferenceID = 26
EXEC AddConference @ConferenceName ='Dawn of the Dead Festival', @StartDate ='2017-06-14', @DaysAmount =3, @ConferenceType ='Business', @BuildingID =45, @OrganizerID =23, @CustomerID =16
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 194, @Date = '2017-06-14', @ConferenceID = 27
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 70, @Date = '2017-06-15', @ConferenceID = 27
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 183, @Date = '2017-06-16', @ConferenceID = 27
EXEC AddConference @ConferenceName ='Belch Blanket Babylon', @StartDate ='2020-11-19', @DaysAmount =5, @ConferenceType ='Entertainment', @BuildingID =41, @OrganizerID =5, @CustomerID =33
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 192, @Date = '2020-11-19', @ConferenceID = 28
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 125, @Date = '2020-11-20', @ConferenceID = 28
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 169, @Date = '2020-11-21', @ConferenceID = 28
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 200, @Date = '2020-11-22', @ConferenceID = 28
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 191, @Date = '2020-11-23', @ConferenceID = 28
EXEC AddConference @ConferenceName ='Karma Farm', @StartDate ='2017-10-07', @DaysAmount =5, @ConferenceType ='Media', @BuildingID =27, @OrganizerID =31, @CustomerID =36
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 103, @Date = '2017-10-07', @ConferenceID = 29
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 147, @Date = '2017-10-08', @ConferenceID = 29
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 75, @Date = '2017-10-09', @ConferenceID = 29
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 149, @Date = '2017-10-10', @ConferenceID = 29
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 108, @Date = '2017-10-11', @ConferenceID = 29
EXEC AddConference @ConferenceName ='Gretels and Goths', @StartDate ='2021-02-05', @DaysAmount =5, @ConferenceType ='Scientific', @BuildingID =23, @OrganizerID =38, @CustomerID =67
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 195, @Date = '2021-02-05', @ConferenceID = 30
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 94, @Date = '2021-02-06', @ConferenceID = 30
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 168, @Date = '2021-02-07', @ConferenceID = 30
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 171, @Date = '2021-02-08', @ConferenceID = 30
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 39, @Date = '2021-02-09', @ConferenceID = 30
EXEC AddConference @ConferenceName ='29 Psalms for 29 Palms', @StartDate ='2018-08-18', @DaysAmount =7, @ConferenceType ='Multilingual', @BuildingID =38, @OrganizerID =15, @CustomerID =20
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 173, @Date = '2018-08-18', @ConferenceID = 31
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 168, @Date = '2018-08-19', @ConferenceID = 31
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 102, @Date = '2018-08-20', @ConferenceID = 31
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 85, @Date = '2018-08-21', @ConferenceID = 31
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 56, @Date = '2018-08-22', @ConferenceID = 31
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 94, @Date = '2018-08-23', @ConferenceID = 31
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 163, @Date = '2018-08-24', @ConferenceID = 31
EXEC AddConference @ConferenceName ='Jesus Jive', @StartDate ='2021-02-08', @DaysAmount =7, @ConferenceType ='Multilingual', @BuildingID =34, @OrganizerID =43, @CustomerID =8
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 180, @Date = '2021-02-08', @ConferenceID = 32
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 108, @Date = '2021-02-09', @ConferenceID = 32
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 140, @Date = '2021-02-10', @ConferenceID = 32
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 44, @Date = '2021-02-11', @ConferenceID = 32
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 162, @Date = '2021-02-12', @ConferenceID = 32
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 170, @Date = '2021-02-13', @ConferenceID = 32
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 99, @Date = '2021-02-14', @ConferenceID = 32
EXEC AddConference @ConferenceName ='Ready Fortune Teller', @StartDate ='2016-01-09', @DaysAmount =3, @ConferenceType ='Multilingual', @BuildingID =33, @OrganizerID =19, @CustomerID =67
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 156, @Date = '2016-01-09', @ConferenceID = 33
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 39, @Date = '2016-01-10', @ConferenceID = 33
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 81, @Date = '2016-01-11', @ConferenceID = 33
EXEC AddConference @ConferenceName ='The Bakery Rave', @StartDate ='2021-10-19', @DaysAmount =7, @ConferenceType ='Media', @BuildingID =12, @OrganizerID =19, @CustomerID =16
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 125, @Date = '2021-10-19', @ConferenceID = 34
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 138, @Date = '2021-10-20', @ConferenceID = 34
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 41, @Date = '2021-10-21', @ConferenceID = 34
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 172, @Date = '2021-10-22', @ConferenceID = 34
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 37, @Date = '2021-10-23', @ConferenceID = 34
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 96, @Date = '2021-10-24', @ConferenceID = 34
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 79, @Date = '2021-10-25', @ConferenceID = 34
EXEC AddConference @ConferenceName ='Demonstration Sunday', @StartDate ='2020-02-06', @DaysAmount =3, @ConferenceType ='Multilingual', @BuildingID =7, @OrganizerID =28, @CustomerID =61
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 158, @Date = '2020-02-06', @ConferenceID = 35
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 92, @Date = '2020-02-07', @ConferenceID = 35
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 39, @Date = '2020-02-08', @ConferenceID = 35
EXEC AddConference @ConferenceName ='CircusRodeo', @StartDate ='2016-03-02', @DaysAmount =5, @ConferenceType ='Entertainment', @BuildingID =33, @OrganizerID =8, @CustomerID =60
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 103, @Date = '2016-03-02', @ConferenceID = 36
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 58, @Date = '2016-03-03', @ConferenceID = 36
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 163, @Date = '2016-03-04', @ConferenceID = 36
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 86, @Date = '2016-03-05', @ConferenceID = 36
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 112, @Date = '2016-03-06', @ConferenceID = 36
EXEC AddConference @ConferenceName ='Basking Bingo', @StartDate ='2016-11-03', @DaysAmount =5, @ConferenceType ='Scientific', @BuildingID =50, @OrganizerID =1, @CustomerID =16
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 173, @Date = '2016-11-03', @ConferenceID = 37
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 53, @Date = '2016-11-04', @ConferenceID = 37
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 83, @Date = '2016-11-05', @ConferenceID = 37
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 135, @Date = '2016-11-06', @ConferenceID = 37
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 170, @Date = '2016-11-07', @ConferenceID = 37
EXEC AddConference @ConferenceName ='Indian Summer', @StartDate ='2019-04-19', @DaysAmount =4, @ConferenceType ='Entertainment', @BuildingID =22, @OrganizerID =32, @CustomerID =41
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 141, @Date = '2019-04-19', @ConferenceID = 38
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 74, @Date = '2019-04-20', @ConferenceID = 38
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 76, @Date = '2019-04-21', @ConferenceID = 38
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 160, @Date = '2019-04-22', @ConferenceID = 38
EXEC AddConference @ConferenceName ='Sequin', @StartDate ='2021-08-19', @DaysAmount =4, @ConferenceType ='Multilingual', @BuildingID =25, @OrganizerID =40, @CustomerID =32
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 114, @Date = '2021-08-19', @ConferenceID = 39
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 67, @Date = '2021-08-20', @ConferenceID = 39
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 120, @Date = '2021-08-21', @ConferenceID = 39
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 112, @Date = '2021-08-22', @ConferenceID = 39
EXEC AddConference @ConferenceName ='The Point of Known Return', @StartDate ='2018-07-15', @DaysAmount =5, @ConferenceType ='Media', @BuildingID =18, @OrganizerID =13, @CustomerID =22
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 78, @Date = '2018-07-15', @ConferenceID = 40
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 38, @Date = '2018-07-16', @ConferenceID = 40
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 131, @Date = '2018-07-17', @ConferenceID = 40
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 60, @Date = '2018-07-18', @ConferenceID = 40
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 37, @Date = '2018-07-19', @ConferenceID = 40
EXEC AddConference @ConferenceName ='Burn It On!', @StartDate ='2021-05-07', @DaysAmount =5, @ConferenceType ='Scientific', @BuildingID =15, @OrganizerID =38, @CustomerID =41
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 106, @Date = '2021-05-07', @ConferenceID = 41
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 96, @Date = '2021-05-08', @ConferenceID = 41
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 113, @Date = '2021-05-09', @ConferenceID = 41
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 193, @Date = '2021-05-10', @ConferenceID = 41
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 147, @Date = '2021-05-11', @ConferenceID = 41
EXEC AddConference @ConferenceName ='Ice Cream Asocial', @StartDate ='2021-08-11', @DaysAmount =6, @ConferenceType ='Multilingual', @BuildingID =5, @OrganizerID =3, @CustomerID =3
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 31, @Date = '2021-08-11', @ConferenceID = 42
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 111, @Date = '2021-08-12', @ConferenceID = 42
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 89, @Date = '2021-08-13', @ConferenceID = 42
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 145, @Date = '2021-08-14', @ConferenceID = 42
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 194, @Date = '2021-08-15', @ConferenceID = 42
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 200, @Date = '2021-08-16', @ConferenceID = 42
EXEC AddConference @ConferenceName ='Cheering Larry', @StartDate ='2016-12-04', @DaysAmount =5, @ConferenceType ='Scientific', @BuildingID =32, @OrganizerID =30, @CustomerID =38
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 116, @Date = '2016-12-04', @ConferenceID = 43
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 62, @Date = '2016-12-05', @ConferenceID = 43
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 93, @Date = '2016-12-06', @ConferenceID = 43
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 190, @Date = '2016-12-07', @ConferenceID = 43
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 100, @Date = '2016-12-08', @ConferenceID = 43
EXEC AddConference @ConferenceName ='Wet the People', @StartDate ='2016-08-11', @DaysAmount =6, @ConferenceType ='Media', @BuildingID =28, @OrganizerID =26, @CustomerID =33
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 189, @Date = '2016-08-11', @ConferenceID = 44
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 60, @Date = '2016-08-12', @ConferenceID = 44
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 52, @Date = '2016-08-13', @ConferenceID = 44
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 193, @Date = '2016-08-14', @ConferenceID = 44
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 76, @Date = '2016-08-15', @ConferenceID = 44
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 159, @Date = '2016-08-16', @ConferenceID = 44
EXEC AddConference @ConferenceName ='Circuitship', @StartDate ='2016-04-16', @DaysAmount =4, @ConferenceType ='Business', @BuildingID =11, @OrganizerID =37, @CustomerID =48
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 178, @Date = '2016-04-16', @ConferenceID = 45
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 165, @Date = '2016-04-17', @ConferenceID = 45
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 185, @Date = '2016-04-18', @ConferenceID = 45
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 123, @Date = '2016-04-19', @ConferenceID = 45
EXEC AddConference @ConferenceName ='Technoasis', @StartDate ='2017-07-20', @DaysAmount =3, @ConferenceType ='Business', @BuildingID =36, @OrganizerID =17, @CustomerID =35
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 198, @Date = '2017-07-20', @ConferenceID = 46
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 47, @Date = '2017-07-21', @ConferenceID = 46
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 166, @Date = '2017-07-22', @ConferenceID = 46
EXEC AddConference @ConferenceName ='Nude Attitude', @StartDate ='2020-04-17', @DaysAmount =7, @ConferenceType ='Business', @BuildingID =25, @OrganizerID =15, @CustomerID =51
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 140, @Date = '2020-04-17', @ConferenceID = 47
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 36, @Date = '2020-04-18', @ConferenceID = 47
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 117, @Date = '2020-04-19', @ConferenceID = 47
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 103, @Date = '2020-04-20', @ConferenceID = 47
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 68, @Date = '2020-04-21', @ConferenceID = 47
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 127, @Date = '2020-04-22', @ConferenceID = 47
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 124, @Date = '2020-04-23', @ConferenceID = 47
EXEC AddConference @ConferenceName ='Of Mice and Mein', @StartDate ='2019-01-11', @DaysAmount =3, @ConferenceType ='Entertainment', @BuildingID =12, @OrganizerID =3, @CustomerID =60
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 59, @Date = '2019-01-11', @ConferenceID = 48
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 68, @Date = '2019-01-12', @ConferenceID = 48
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 115, @Date = '2019-01-13', @ConferenceID = 48
EXEC AddConference @ConferenceName ='Aesthetic Bug Gloss', @StartDate ='2016-11-04', @DaysAmount =7, @ConferenceType ='Media', @BuildingID =19, @OrganizerID =48, @CustomerID =20
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 195, @Date = '2016-11-04', @ConferenceID = 49
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 157, @Date = '2016-11-05', @ConferenceID = 49
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 91, @Date = '2016-11-06', @ConferenceID = 49
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 115, @Date = '2016-11-07', @ConferenceID = 49
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 53, @Date = '2016-11-08', @ConferenceID = 49
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 194, @Date = '2016-11-09', @ConferenceID = 49
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 127, @Date = '2016-11-10', @ConferenceID = 49
EXEC AddConference @ConferenceName ='Demonstration Sunday', @StartDate ='2020-11-08', @DaysAmount =7, @ConferenceType ='Entertainment', @BuildingID =34, @OrganizerID =35, @CustomerID =66
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 173, @Date = '2020-11-08', @ConferenceID = 50
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 93, @Date = '2020-11-09', @ConferenceID = 50
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 106, @Date = '2020-11-10', @ConferenceID = 50
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 183, @Date = '2020-11-11', @ConferenceID = 50
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 158, @Date = '2020-11-12', @ConferenceID = 50
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 128, @Date = '2020-11-13', @ConferenceID = 50
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 161, @Date = '2020-11-14', @ConferenceID = 50
EXEC AddConference @ConferenceName ='Pick up the Peaces', @StartDate ='2019-01-11', @DaysAmount =7, @ConferenceType ='Media', @BuildingID =41, @OrganizerID =11, @CustomerID =33
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 132, @Date = '2019-01-11', @ConferenceID = 51
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 127, @Date = '2019-01-12', @ConferenceID = 51
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 50, @Date = '2019-01-13', @ConferenceID = 51
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 184, @Date = '2019-01-14', @ConferenceID = 51
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 101, @Date = '2019-01-15', @ConferenceID = 51
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 105, @Date = '2019-01-16', @ConferenceID = 51
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 101, @Date = '2019-01-17', @ConferenceID = 51
EXEC AddConference @ConferenceName ='Snow Lights', @StartDate ='2020-10-17', @DaysAmount =6, @ConferenceType ='Scientific', @BuildingID =45, @OrganizerID =17, @CustomerID =40
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 170, @Date = '2020-10-17', @ConferenceID = 52
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 114, @Date = '2020-10-18', @ConferenceID = 52
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 140, @Date = '2020-10-19', @ConferenceID = 52
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 139, @Date = '2020-10-20', @ConferenceID = 52
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 156, @Date = '2020-10-21', @ConferenceID = 52
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 87, @Date = '2020-10-22', @ConferenceID = 52
EXEC AddConference @ConferenceName ='Stride for Life', @StartDate ='2020-03-12', @DaysAmount =5, @ConferenceType ='Media', @BuildingID =11, @OrganizerID =21, @CustomerID =41
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 44, @Date = '2020-03-12', @ConferenceID = 53
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 181, @Date = '2020-03-13', @ConferenceID = 53
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 44, @Date = '2020-03-14', @ConferenceID = 53
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 164, @Date = '2020-03-15', @ConferenceID = 53
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 175, @Date = '2020-03-16', @ConferenceID = 53
EXEC AddConference @ConferenceName ='Tornado Picnic', @StartDate ='2019-02-08', @DaysAmount =4, @ConferenceType ='Scientific', @BuildingID =3, @OrganizerID =28, @CustomerID =45
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 45, @Date = '2019-02-08', @ConferenceID = 54
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 149, @Date = '2019-02-09', @ConferenceID = 54
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 35, @Date = '2019-02-10', @ConferenceID = 54
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 150, @Date = '2019-02-11', @ConferenceID = 54
EXEC AddConference @ConferenceName ='Bora Bora Boar Hunt', @StartDate ='2019-05-20', @DaysAmount =3, @ConferenceType ='Multilingual', @BuildingID =4, @OrganizerID =32, @CustomerID =16
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 171, @Date = '2019-05-20', @ConferenceID = 55
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 117, @Date = '2019-05-21', @ConferenceID = 55
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 49, @Date = '2019-05-22', @ConferenceID = 55
EXEC AddConference @ConferenceName ='Wise and in the Way', @StartDate ='2018-02-14', @DaysAmount =3, @ConferenceType ='Business', @BuildingID =1, @OrganizerID =38, @CustomerID =48
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 198, @Date = '2018-02-14', @ConferenceID = 56
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 50, @Date = '2018-02-15', @ConferenceID = 56
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 184, @Date = '2018-02-16', @ConferenceID = 56
EXEC AddConference @ConferenceName ='Halloween Howl', @StartDate ='2019-07-08', @DaysAmount =7, @ConferenceType ='Multilingual', @BuildingID =35, @OrganizerID =10, @CustomerID =21
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 61, @Date = '2019-07-08', @ConferenceID = 57
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 83, @Date = '2019-07-09', @ConferenceID = 57
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 57, @Date = '2019-07-10', @ConferenceID = 57
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 46, @Date = '2019-07-11', @ConferenceID = 57
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 133, @Date = '2019-07-12', @ConferenceID = 57
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 75, @Date = '2019-07-13', @ConferenceID = 57
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 57, @Date = '2019-07-14', @ConferenceID = 57
EXEC AddConference @ConferenceName ='Act Out Your Age', @StartDate ='2020-05-05', @DaysAmount =4, @ConferenceType ='Entertainment', @BuildingID =46, @OrganizerID =29, @CustomerID =46
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 101, @Date = '2020-05-05', @ConferenceID = 58
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 56, @Date = '2020-05-06', @ConferenceID = 58
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 83, @Date = '2020-05-07', @ConferenceID = 58
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 71, @Date = '2020-05-08', @ConferenceID = 58
EXEC AddConference @ConferenceName ='The Bakery Rave', @StartDate ='2017-04-03', @DaysAmount =6, @ConferenceType ='Business', @BuildingID =16, @OrganizerID =24, @CustomerID =33
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 195, @Date = '2017-04-03', @ConferenceID = 59
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 140, @Date = '2017-04-04', @ConferenceID = 59
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 149, @Date = '2017-04-05', @ConferenceID = 59
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 82, @Date = '2017-04-06', @ConferenceID = 59
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 197, @Date = '2017-04-07', @ConferenceID = 59
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 52, @Date = '2017-04-08', @ConferenceID = 59
EXEC AddConference @ConferenceName ='Introducing the Inducing', @StartDate ='2017-12-01', @DaysAmount =5, @ConferenceType ='Media', @BuildingID =34, @OrganizerID =18, @CustomerID =54
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 99, @Date = '2017-12-01', @ConferenceID = 60
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 185, @Date = '2017-12-02', @ConferenceID = 60
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 146, @Date = '2017-12-03', @ConferenceID = 60
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 123, @Date = '2017-12-04', @ConferenceID = 60
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 83, @Date = '2017-12-05', @ConferenceID = 60
EXEC AddConference @ConferenceName ='Tunapocalypse', @StartDate ='2016-06-04', @DaysAmount =6, @ConferenceType ='Scientific', @BuildingID =18, @OrganizerID =21, @CustomerID =46
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 153, @Date = '2016-06-04', @ConferenceID = 61
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 73, @Date = '2016-06-05', @ConferenceID = 61
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 84, @Date = '2016-06-06', @ConferenceID = 61
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 40, @Date = '2016-06-07', @ConferenceID = 61
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 197, @Date = '2016-06-08', @ConferenceID = 61
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 131, @Date = '2016-06-09', @ConferenceID = 61
EXEC AddConference @ConferenceName ='Retro Plum', @StartDate ='2018-06-16', @DaysAmount =4, @ConferenceType ='Entertainment', @BuildingID =21, @OrganizerID =5, @CustomerID =19
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 171, @Date = '2018-06-16', @ConferenceID = 62
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 30, @Date = '2018-06-17', @ConferenceID = 62
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 107, @Date = '2018-06-18', @ConferenceID = 62
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 126, @Date = '2018-06-19', @ConferenceID = 62
EXEC AddConference @ConferenceName ='Deep Blue Scene', @StartDate ='2020-01-08', @DaysAmount =6, @ConferenceType ='Multilingual', @BuildingID =1, @OrganizerID =36, @CustomerID =56
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 182, @Date = '2020-01-08', @ConferenceID = 63
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 83, @Date = '2020-01-09', @ConferenceID = 63
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 58, @Date = '2020-01-10', @ConferenceID = 63
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 49, @Date = '2020-01-11', @ConferenceID = 63
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 49, @Date = '2020-01-12', @ConferenceID = 63
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 65, @Date = '2020-01-13', @ConferenceID = 63
EXEC AddConference @ConferenceName ='Project God', @StartDate ='2021-03-04', @DaysAmount =6, @ConferenceType ='Multilingual', @BuildingID =16, @OrganizerID =16, @CustomerID =10
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 152, @Date = '2021-03-04', @ConferenceID = 64
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 145, @Date = '2021-03-05', @ConferenceID = 64
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 144, @Date = '2021-03-06', @ConferenceID = 64
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 92, @Date = '2021-03-07', @ConferenceID = 64
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 130, @Date = '2021-03-08', @ConferenceID = 64
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 159, @Date = '2021-03-09', @ConferenceID = 64
EXEC AddConference @ConferenceName ='Pride Aside', @StartDate ='2018-08-19', @DaysAmount =7, @ConferenceType ='Entertainment', @BuildingID =19, @OrganizerID =50, @CustomerID =34
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 124, @Date = '2018-08-19', @ConferenceID = 65
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 43, @Date = '2018-08-20', @ConferenceID = 65
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 56, @Date = '2018-08-21', @ConferenceID = 65
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 198, @Date = '2018-08-22', @ConferenceID = 65
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 33, @Date = '2018-08-23', @ConferenceID = 65
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 154, @Date = '2018-08-24', @ConferenceID = 65
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 152, @Date = '2018-08-25', @ConferenceID = 65
EXEC AddConference @ConferenceName ='Coffeebration', @StartDate ='2019-09-17', @DaysAmount =6, @ConferenceType ='Scientific', @BuildingID =49, @OrganizerID =2, @CustomerID =26
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 181, @Date = '2019-09-17', @ConferenceID = 66
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 85, @Date = '2019-09-18', @ConferenceID = 66
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 160, @Date = '2019-09-19', @ConferenceID = 66
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 43, @Date = '2019-09-20', @ConferenceID = 66
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 49, @Date = '2019-09-21', @ConferenceID = 66
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 163, @Date = '2019-09-22', @ConferenceID = 66
EXEC AddConference @ConferenceName ='Book Trials', @StartDate ='2021-09-08', @DaysAmount =7, @ConferenceType ='Scientific', @BuildingID =11, @OrganizerID =43, @CustomerID =23
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 200, @Date = '2021-09-08', @ConferenceID = 67
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 158, @Date = '2021-09-09', @ConferenceID = 67
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 42, @Date = '2021-09-10', @ConferenceID = 67
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 40, @Date = '2021-09-11', @ConferenceID = 67
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 199, @Date = '2021-09-12', @ConferenceID = 67
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 84, @Date = '2021-09-13', @ConferenceID = 67
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 140, @Date = '2021-09-14', @ConferenceID = 67
EXEC AddConference @ConferenceName ='Apocalypso', @StartDate ='2018-06-15', @DaysAmount =7, @ConferenceType ='Scientific', @BuildingID =40, @OrganizerID =27, @CustomerID =30
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 157, @Date = '2018-06-15', @ConferenceID = 68
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 186, @Date = '2018-06-16', @ConferenceID = 68
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 189, @Date = '2018-06-17', @ConferenceID = 68
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 118, @Date = '2018-06-18', @ConferenceID = 68
	EXEC AddConferenceDay @DayNumber = 5, @ParticipantLimit = 191, @Date = '2018-06-19', @ConferenceID = 68
	EXEC AddConferenceDay @DayNumber = 6, @ParticipantLimit = 58, @Date = '2018-06-20', @ConferenceID = 68
	EXEC AddConferenceDay @DayNumber = 7, @ParticipantLimit = 190, @Date = '2018-06-21', @ConferenceID = 68
EXEC AddConference @ConferenceName ='Coffee RoundUp', @StartDate ='2021-07-08', @DaysAmount =4, @ConferenceType ='Scientific', @BuildingID =13, @OrganizerID =9, @CustomerID =62
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 125, @Date = '2021-07-08', @ConferenceID = 69
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 196, @Date = '2021-07-09', @ConferenceID = 69
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 41, @Date = '2021-07-10', @ConferenceID = 69
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 181, @Date = '2021-07-11', @ConferenceID = 69
EXEC AddConference @ConferenceName ='So So Toboso', @StartDate ='2016-09-18', @DaysAmount =4, @ConferenceType ='Multilingual', @BuildingID =3, @OrganizerID =43, @CustomerID =45
	EXEC AddConferenceDay @DayNumber = 1, @ParticipantLimit = 135, @Date = '2016-09-18', @ConferenceID = 70
	EXEC AddConferenceDay @DayNumber = 2, @ParticipantLimit = 131, @Date = '2016-09-19', @ConferenceID = 70
	EXEC AddConferenceDay @DayNumber = 3, @ParticipantLimit = 177, @Date = '2016-09-20', @ConferenceID = 70
	EXEC AddConferenceDay @DayNumber = 4, @ParticipantLimit = 154, @Date = '2016-09-21', @ConferenceID = 70
ALTER TABLE Conferences ENABLE TRIGGER ForbidToSpecifyConferencesFromThePast
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 1
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 1
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 1
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 1
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 2
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 2
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 2
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 3
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 3
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 3
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 4
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 4
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 4
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 5
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 5
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 5
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 6
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 6
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 6
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 7
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 7
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 7
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 8
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 8
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 8
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 8
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 9
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 9
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 9
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 9
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 10
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 10
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 10
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 11
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 11
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 11
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 11
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 12
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 12
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 12
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 13
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 13
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 13
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 13
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 14
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 14
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 14
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 14
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 15
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 15
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 15
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 15
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 16
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 16
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 16
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 16
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 17
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 17
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 17
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 17
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 18
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 18
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 18
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 19
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 19
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 19
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 20
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 20
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 20
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 20
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 21
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 21
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 21
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 22
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 22
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 22
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 23
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 23
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 23
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 24
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 24
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 24
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 24
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 25
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 25
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 25
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 25
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 26
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 26
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 26
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 27
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 27
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 27
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 27
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 28
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 28
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 28
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 29
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 29
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 29
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 30
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 30
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 30
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 31
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 31
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 31
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 31
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 32
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 32
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 32
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 33
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 33
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 33
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 33
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 34
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 34
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 34
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 35
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 35
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 35
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 36
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 36
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 36
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 37
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 37
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 37
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 38
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 38
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 38
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 38
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 39
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 39
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 39
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 40
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 40
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 40
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 41
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 41
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 41
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 42
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 42
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 42
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 43
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 43
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 43
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 44
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 44
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 44
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 45
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 45
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 45
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 46
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 46
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 46
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 47
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 47
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 47
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 47
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 48
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 48
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 48
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 49
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 49
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 49
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 49
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 50
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 50
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 50
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 50
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 51
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 51
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 51
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 52
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 52
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 52
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 52
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 53
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 53
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 53
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 54
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 54
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 54
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 55
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 55
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 55
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 55
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 56
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 56
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 56
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 56
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 57
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 57
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 57
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 57
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 58
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 58
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 58
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 59
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 59
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 59
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 59
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 60
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 60
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 60
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 61
EXEC AssignPartnerToConference @PartnerID = 4, @ConferenceID = 61
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 61
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 61
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 62
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 62
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 62
EXEC AssignPartnerToConference @PartnerID = 1, @ConferenceID = 63
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 63
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 63
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 64
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 64
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 64
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 64
EXEC AssignPartnerToConference @PartnerID = 8, @ConferenceID = 65
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 65
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 65
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 66
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 66
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 66
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 67
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 67
EXEC AssignPartnerToConference @PartnerID = 10, @ConferenceID = 67
EXEC AssignPartnerToConference @PartnerID = 2, @ConferenceID = 68
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 68
EXEC AssignPartnerToConference @PartnerID = 7, @ConferenceID = 68
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 68
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 69
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 69
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 69
EXEC AssignPartnerToConference @PartnerID = 9, @ConferenceID = 69
EXEC AssignPartnerToConference @PartnerID = 5, @ConferenceID = 70
EXEC AssignPartnerToConference @PartnerID = 3, @ConferenceID = 70
EXEC AssignPartnerToConference @PartnerID = 6, @ConferenceID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 1
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 1
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 1
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 1
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 1
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 2
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 2
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 2
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 2
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 2
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 2
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 3
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 3
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 3
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 3
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 3
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 3
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 3
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 4
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 4
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 4
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 4
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 4
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 4
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 4
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 4
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 5
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 6
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 6
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 6
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 6
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 7
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 7
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 7
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 7
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 7
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 8
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 8
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 8
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 8
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 8
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 9
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 9
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 9
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 9
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 9
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 9
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 9
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 9
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 9
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 10
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 10
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 10
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 10
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 10
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 10
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 10
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 10
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 10
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 11
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 11
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 11
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 11
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 11
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 11
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 11
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 11
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 11
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 12
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 12
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 12
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 12
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 12
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 13
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 13
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 13
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 13
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 13
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 13
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 13
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 13
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 14
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 14
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 14
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 14
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 14
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 15
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 15
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 15
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 15
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 15
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 15
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 15
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 15
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 15
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 16
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 16
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 16
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 16
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 16
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 16
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 16
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 16
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 17
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 17
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 17
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 17
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 18
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 18
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 18
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 18
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 18
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 18
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 18
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 18
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 18
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 19
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 19
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 19
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 19
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 19
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 19
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 20
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 20
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 20
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 20
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 20
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 20
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 20
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 20
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 20
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 21
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 21
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 21
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 21
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 21
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 21
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 21
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 22
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 22
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 22
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 22
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 22
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 22
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 22
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 23
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 23
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 23
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 23
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 23
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 24
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 24
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 24
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 24
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 24
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 25
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 26
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 27
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 27
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 27
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 27
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 27
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 27
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 27
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 27
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 28
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 28
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 28
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 28
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 28
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 28
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 28
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 29
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 29
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 29
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 29
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 29
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 30
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 30
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 30
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 30
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 30
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 30
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 31
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 31
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 31
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 31
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 31
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 32
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 32
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 32
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 32
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 32
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 33
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 33
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 33
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 33
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 34
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 35
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 35
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 35
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 35
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 35
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 36
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 37
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 37
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 37
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 37
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 37
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 38
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 38
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 38
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 38
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 38
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 38
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 38
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 38
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 39
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 39
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 39
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 39
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 40
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 40
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 40
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 40
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 40
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 40
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 40
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 40
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 41
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 41
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 41
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 41
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 41
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 41
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 42
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 42
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 42
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 42
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 42
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 42
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 43
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 43
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 43
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 43
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 43
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 43
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 43
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 44
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 44
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 44
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 44
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 44
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 44
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 44
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 44
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 44
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 45
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 45
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 45
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 45
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 46
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 47
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 48
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 48
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 48
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 48
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 48
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 48
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 48
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 49
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 49
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 49
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 49
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 49
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 49
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 49
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 49
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 49
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 50
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 50
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 50
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 50
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 50
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 50
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 50
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 51
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 51
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 51
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 51
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 51
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 51
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 52
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 52
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 52
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 52
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 52
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 52
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 52
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 53
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 53
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 53
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 53
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 53
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 53
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 53
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 53
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 53
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 54
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 54
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 54
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 54
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 54
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 54
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 54
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 54
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 55
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 55
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 55
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 55
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 55
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 55
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 55
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 55
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 55
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 56
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 56
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 56
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 56
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 56
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 57
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 57
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 57
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 57
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 58
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 58
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 58
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 58
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 58
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 58
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 59
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 59
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 59
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 59
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 60
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 61
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 61
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 61
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 61
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 61
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 61
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 61
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 61
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 62
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 62
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 62
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 62
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 63
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 63
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 63
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 63
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 63
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 63
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 63
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 64
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 64
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 64
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 64
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 65
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 65
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 65
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 65
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 65
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 66
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 66
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 66
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 66
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 67
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 67
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 67
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 67
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 68
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 68
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 68
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 68
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 69
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 69
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 69
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 69
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 69
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 69
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 69
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 69
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 70
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 71
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 71
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 71
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 71
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 71
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 72
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 73
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 74
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 74
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 74
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 74
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 74
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 74
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 74
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 74
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 75
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 75
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 75
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 75
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 75
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 76
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 76
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 76
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 76
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 76
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 76
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 77
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 77
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 77
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 77
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 77
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 77
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 77
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 78
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 78
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 78
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 78
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 78
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 78
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 78
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 78
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 79
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 79
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 79
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 79
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 80
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 81
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 81
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 81
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 81
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 82
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 82
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 82
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 82
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 82
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 83
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 83
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 83
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 83
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 83
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 83
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 83
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 84
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 84
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 84
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 84
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 84
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 84
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 84
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 84
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 84
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 85
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 85
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 85
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 85
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 85
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 85
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 85
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 86
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 86
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 86
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 86
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 86
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 86
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 86
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 87
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 88
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 88
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 88
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 88
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 88
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 88
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 89
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 89
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 89
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 89
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 89
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 89
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 89
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 89
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 89
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 90
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 90
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 90
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 90
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 91
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 91
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 91
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 91
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 91
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 91
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 91
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 92
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 93
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 93
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 93
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 93
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 93
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 94
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 94
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 94
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 94
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 94
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 94
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 94
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 95
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 95
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 95
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 95
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 95
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 95
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 96
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 96
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 96
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 96
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 97
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 97
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 97
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 97
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 98
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 98
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 98
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 98
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 99
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 99
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 99
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 99
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 99
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 99
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 99
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 100
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 100
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 100
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 100
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 100
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 101
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 101
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 101
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 101
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 101
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 101
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 101
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 101
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 101
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 102
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 102
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 102
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 102
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 103
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 103
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 103
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 103
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 103
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 103
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 103
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 103
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 104
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 104
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 104
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 104
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 104
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 105
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 105
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 105
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 105
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 105
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 105
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 105
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 106
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 106
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 106
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 106
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 106
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 106
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 106
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 107
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 108
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 108
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 108
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 108
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 108
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 108
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 109
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 110
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 110
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 110
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 110
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 110
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 111
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 111
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 111
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 111
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 111
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 111
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 111
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 112
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 113
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 113
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 113
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 113
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 113
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 114
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 114
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 114
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 114
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 114
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 115
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 115
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 115
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 115
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 115
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 116
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 117
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 117
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 117
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 117
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 117
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 117
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 117
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 117
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 117
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 118
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 118
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 118
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 118
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 119
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 119
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 119
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 119
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 119
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 119
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 120
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 120
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 120
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 120
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 120
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 121
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 121
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 121
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 121
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 121
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 121
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 122
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 123
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 123
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 123
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 123
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 123
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 123
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 123
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 123
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 124
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 125
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 125
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 125
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 125
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 125
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 125
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 126
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 126
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 126
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 126
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 126
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 126
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 126
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 126
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 126
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 127
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 127
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 127
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 127
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 127
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 127
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 127
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 127
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 128
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 129
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 129
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 129
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 129
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 129
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 130
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 131
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 131
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 131
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 131
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 131
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 131
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 131
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 131
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 131
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 132
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 132
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 132
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 132
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 132
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 132
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 132
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 133
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 133
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 133
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 133
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 133
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 133
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 133
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 134
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 134
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 134
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 134
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 135
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 135
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 135
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 135
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 135
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 135
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 135
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 136
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 136
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 136
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 136
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 137
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 137
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 137
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 137
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 138
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 138
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 138
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 138
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 138
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 138
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 139
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 139
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 139
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 139
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 139
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 140
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 140
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 140
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 140
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 141
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 141
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 141
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 141
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 141
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 141
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 141
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 142
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 142
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 142
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 142
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 142
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 142
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 142
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 142
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 142
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 143
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 143
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 143
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 143
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 144
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 144
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 144
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 144
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 144
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 144
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 144
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 144
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 145
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 145
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 145
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 145
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 145
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 145
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 145
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 145
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 145
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 146
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 146
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 146
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 146
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 146
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 147
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 147
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 147
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 147
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 147
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 147
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 147
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 148
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 148
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 148
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 148
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 148
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 149
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 149
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 149
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 149
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 149
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 149
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 149
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 150
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 150
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 150
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 150
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 151
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 151
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 151
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 151
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 151
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 152
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 152
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 152
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 152
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 152
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 152
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 152
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 152
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 153
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 153
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 153
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 153
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 153
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 153
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 153
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 153
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 154
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 154
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 154
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 154
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 154
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 154
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 154
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 155
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 156
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 156
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 156
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 156
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 156
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 156
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 156
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 156
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 156
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 157
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 157
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 157
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 157
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 157
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 157
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 157
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 157
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 158
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 158
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 158
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 158
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 158
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 158
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 159
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 159
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 159
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 159
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 160
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 160
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 160
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 160
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 160
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 160
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 160
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 160
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 160
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 161
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 161
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 161
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 161
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 161
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 161
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 162
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 162
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 162
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 162
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 163
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 163
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 163
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 163
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 163
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 163
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 163
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 163
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 164
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 164
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 164
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 164
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 164
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 165
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 165
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 165
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 165
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 165
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 166
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 166
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 166
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 166
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 166
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 166
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 166
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 166
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 166
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 167
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 168
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 168
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 168
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 168
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 168
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 169
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 169
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 169
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 169
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 169
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 169
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 169
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 169
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 169
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 170
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 170
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 170
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 170
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 170
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 170
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 170
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 170
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 171
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 171
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 171
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 171
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 171
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 171
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 171
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 172
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 172
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 172
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 172
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 172
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 172
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 173
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 173
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 173
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 173
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 173
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 173
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 173
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 174
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 174
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 174
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 174
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 174
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 174
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 175
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 176
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 176
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 176
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 176
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 176
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 176
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 176
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 177
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 177
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 177
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 177
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 177
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 177
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 178
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 178
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 178
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 178
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 179
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 179
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 179
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 179
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 179
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 179
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 180
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 180
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 180
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 180
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 180
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 180
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 180
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 180
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 180
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 181
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 181
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 181
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 181
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 181
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 181
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 181
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 181
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 181
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 182
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 182
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 182
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 182
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 182
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 182
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 182
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 182
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 183
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 183
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 183
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 183
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 183
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 183
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 183
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 184
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 184
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 184
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 184
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 184
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 184
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 184
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 184
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 184
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 185
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 185
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 185
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 185
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 185
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 185
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 186
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 186
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 186
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 186
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 186
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 187
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 187
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 187
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 187
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 187
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 187
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 188
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 188
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 188
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 188
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 188
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 188
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 188
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 188
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 189
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 189
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 189
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 189
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 189
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 190
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 190
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 190
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 190
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 191
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 191
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 191
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 191
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 191
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 191
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 191
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 192
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 192
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 192
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 192
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 192
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 192
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 193
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 193
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 193
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 193
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 193
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 193
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 193
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 194
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 194
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 194
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 194
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 194
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 194
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 194
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 194
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 195
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 196
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 196
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 196
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 196
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 197
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 198
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 199
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 199
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 199
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 199
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 199
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 199
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 200
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 200
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 200
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 200
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 201
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 202
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 202
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 202
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 202
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 202
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 203
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 204
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 204
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 204
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 204
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 204
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 205
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 205
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 205
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 205
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 205
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 206
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 206
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 206
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 206
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 206
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 206
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 206
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 206
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 206
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 207
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 207
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 207
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 207
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 207
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 207
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 207
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 208
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 208
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 208
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 208
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 209
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 209
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 209
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 209
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 209
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 209
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 209
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 209
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 210
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 210
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 210
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 210
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 210
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 210
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 210
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 210
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 210
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 211
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 211
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 211
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 211
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 211
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 212
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 212
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 212
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 212
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 212
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 212
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 212
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 212
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 213
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 214
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 214
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 214
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 214
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 214
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 214
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 215
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 215
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 215
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 215
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 215
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 215
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 215
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 215
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 216
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 216
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 216
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 216
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 216
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 216
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 216
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 217
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 217
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 217
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 217
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 218
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 218
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 218
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 218
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 218
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 218
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 219
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 220
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 220
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 220
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 220
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 220
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 220
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 221
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 222
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 222
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 222
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 222
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 222
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 222
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 222
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 222
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 222
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 223
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 223
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 223
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 223
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 223
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 223
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 223
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 223
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 224
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 224
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 224
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 224
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 224
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 224
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 224
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 224
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 225
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 225
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 225
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 225
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 225
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 225
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 225
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 225
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 225
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 226
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 226
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 226
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 226
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 226
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 226
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 226
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 226
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 227
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 228
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 228
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 228
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 228
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 228
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 228
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 229
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 229
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 229
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 229
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 229
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 229
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 230
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 230
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 230
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 230
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 230
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 230
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 230
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 230
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 230
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 231
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 231
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 231
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 231
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 231
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 231
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 231
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 231
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 231
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 232
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 233
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 233
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 233
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 233
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 233
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 233
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 233
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 233
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 233
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 234
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 234
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 234
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 234
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 235
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 235
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 235
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 235
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 235
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 236
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 236
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 236
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 236
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 236
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 236
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 236
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 236
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 236
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 237
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 237
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 237
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 237
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 238
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 238
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 238
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 238
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 239
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 239
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 239
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 239
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 239
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 240
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 240
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 240
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 240
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 240
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 240
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 240
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 240
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 240
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 241
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 241
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 241
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 241
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 241
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 241
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 242
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 242
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 242
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 242
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 242
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 242
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 242
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 242
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 243
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 243
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 243
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 243
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 243
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 243
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 243
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 243
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 244
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 245
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 245
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 245
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 245
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 246
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 247
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 247
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 247
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 247
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 247
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 247
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 247
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 247
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 248
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 248
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 248
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 248
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 248
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 248
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 248
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 249
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 249
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 249
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 249
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 249
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 249
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 249
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 249
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 249
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 250
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 250
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 251
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 251
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 251
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 251
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 252
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 252
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 252
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 252
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 253
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 253
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 253
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 253
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 253
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 254
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 254
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 254
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 254
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 254
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 254
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 254
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 255
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 255
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 255
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 255
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 255
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 256
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 256
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 256
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 256
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 256
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 256
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 256
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 257
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 257
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 257
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 257
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 257
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 258
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 258
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 258
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 258
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 258
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 258
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 258
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 259
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 259
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 259
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 259
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 259
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 260
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 260
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 260
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 260
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 260
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 261
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 261
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 261
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 261
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 261
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 261
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 261
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 262
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 263
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 263
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 263
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 263
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 263
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 263
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 263
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 263
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 263
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 264
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 264
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 264
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 264
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 264
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 265
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 265
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 265
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 265
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 265
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 265
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 265
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 265
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 265
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 266
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 266
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 266
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 266
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 267
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 267
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 267
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 267
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 267
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 267
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 267
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 267
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 267
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 268
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 268
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 268
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 268
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 268
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 268
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 269
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 269
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 269
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 269
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 269
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 269
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 269
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 269
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 270
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 270
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 270
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 270
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 270
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 270
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 270
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 270
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 270
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 271
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 271
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 271
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 271
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 271
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 271
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 272
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 272
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 272
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 272
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 273
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 273
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 273
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 273
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 273
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 273
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 273
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 273
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 273
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 274
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 274
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 274
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 274
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 274
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 274
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 274
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 274
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 275
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 275
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 275
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 275
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 275
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 275
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 275
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 275
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 276
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 276
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 276
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 276
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 276
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 276
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 276
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 276
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 276
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 277
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 277
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 277
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 277
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 277
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 277
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 277
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 277
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 277
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 278
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 278
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 278
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 278
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 278
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 278
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 278
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 279
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 279
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 279
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 279
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 279
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 279
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 280
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 281
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 281
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 281
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 281
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 281
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 281
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 281
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 281
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 281
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 282
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 283
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 283
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 283
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 283
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 284
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 284
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 284
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 284
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 284
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 284
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 284
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 284
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 285
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 285
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 285
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 285
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 285
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 285
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 285
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 286
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 287
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 287
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 287
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 287
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 287
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 287
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 288
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 288
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 288
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 288
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 288
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 288
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 288
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 288
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 289
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 290
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 290
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 290
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 290
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 290
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 290
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 290
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 290
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 291
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 291
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 291
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 291
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 291
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 291
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 291
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 291
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 292
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 292
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 292
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 292
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 292
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 292
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 292
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 292
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 293
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 293
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 293
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 293
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 293
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 293
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 293
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 293
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 294
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 294
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 294
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 294
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 294
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 294
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 295
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 295
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 295
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 295
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 295
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 295
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 295
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 295
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 296
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 296
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 296
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 296
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 296
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 296
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 296
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 296
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 297
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 297
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 297
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 297
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 297
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 297
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 297
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 297
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 297
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 298
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 298
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 298
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 298
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 298
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 298
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 298
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 299
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 299
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 299
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 299
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 299
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 299
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 299
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 300
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 300
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 300
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 300
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 300
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 301
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 302
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 302
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 302
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 302
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 302
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 303
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 303
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 303
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 303
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 304
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 304
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 304
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 304
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 305
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 305
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 305
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 305
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 306
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 307
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 308
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 308
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 308
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 308
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 309
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 309
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 309
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 309
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 309
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 309
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 310
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 310
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 310
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 310
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 310
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 311
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 311
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 311
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 311
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 311
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 311
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 311
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 311
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 311
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 312
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 312
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 312
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 312
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 312
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 313
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 313
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 313
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 313
EXEC AssignEmployeeToConferenceDay @EmployeeID = 8, @ConferenceDayID = 313
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 313
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 313
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 313
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 313
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 314
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 314
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 314
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 314
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 314
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 314
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 314
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 314
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 314
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 315
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 316
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 316
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 316
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 316
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 316
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 316
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 316
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 317
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 318
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 318
EXEC AssignEmployeeToConferenceDay @EmployeeID = 14, @ConferenceDayID = 318
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 318
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 318
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 318
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 318
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 319
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 320
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 320
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 320
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 320
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 320
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 320
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 321
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 321
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 321
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 321
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 321
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 321
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 321
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 322
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 322
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 322
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 323
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 323
EXEC AssignEmployeeToConferenceDay @EmployeeID = 41, @ConferenceDayID = 323
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 324
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 324
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 324
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 324
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 325
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 325
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 325
EXEC AssignEmployeeToConferenceDay @EmployeeID = 63, @ConferenceDayID = 325
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 325
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 325
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 325
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 326
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 326
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 326
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 326
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 327
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 327
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 327
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 327
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 328
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 328
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 328
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 328
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 329
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 329
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 329
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 329
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 329
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 330
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 330
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 330
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 330
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 331
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 331
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 331
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 331
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 331
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 331
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 331
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 332
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 332
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 332
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 332
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 332
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 332
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 332
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 333
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 333
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 333
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 333
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 333
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 334
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 334
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 334
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 334
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 334
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 335
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 335
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 335
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 335
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 335
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 335
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 335
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 336
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 336
EXEC AssignEmployeeToConferenceDay @EmployeeID = 16, @ConferenceDayID = 336
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 336
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 336
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 336
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 336
EXEC AssignEmployeeToConferenceDay @EmployeeID = 29, @ConferenceDayID = 337
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 337
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 337
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 337
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 338
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 338
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 338
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 338
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 338
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 338
EXEC AssignEmployeeToConferenceDay @EmployeeID = 22, @ConferenceDayID = 338
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 338
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 338
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 339
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 339
EXEC AssignEmployeeToConferenceDay @EmployeeID = 40, @ConferenceDayID = 339
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 339
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 339
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 339
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 339
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 339
EXEC AssignEmployeeToConferenceDay @EmployeeID = 53, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 4, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 52, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 48, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 62, @ConferenceDayID = 340
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 341
EXEC AssignEmployeeToConferenceDay @EmployeeID = 37, @ConferenceDayID = 341
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 341
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 341
EXEC AssignEmployeeToConferenceDay @EmployeeID = 56, @ConferenceDayID = 341
EXEC AssignEmployeeToConferenceDay @EmployeeID = 31, @ConferenceDayID = 341
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 341
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 341
EXEC AssignEmployeeToConferenceDay @EmployeeID = 21, @ConferenceDayID = 342
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 342
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 342
EXEC AssignEmployeeToConferenceDay @EmployeeID = 42, @ConferenceDayID = 342
EXEC AssignEmployeeToConferenceDay @EmployeeID = 61, @ConferenceDayID = 343
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 343
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 343
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 343
EXEC AssignEmployeeToConferenceDay @EmployeeID = 35, @ConferenceDayID = 343
EXEC AssignEmployeeToConferenceDay @EmployeeID = 66, @ConferenceDayID = 343
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 343
EXEC AssignEmployeeToConferenceDay @EmployeeID = 13, @ConferenceDayID = 344
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 344
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 344
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 344
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 344
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 344
EXEC AssignEmployeeToConferenceDay @EmployeeID = 9, @ConferenceDayID = 344
EXEC AssignEmployeeToConferenceDay @EmployeeID = 45, @ConferenceDayID = 344
EXEC AssignEmployeeToConferenceDay @EmployeeID = 19, @ConferenceDayID = 344
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 39, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 11, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 24, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 7, @ConferenceDayID = 345
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 346
EXEC AssignEmployeeToConferenceDay @EmployeeID = 2, @ConferenceDayID = 346
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 346
EXEC AssignEmployeeToConferenceDay @EmployeeID = 64, @ConferenceDayID = 346
EXEC AssignEmployeeToConferenceDay @EmployeeID = 49, @ConferenceDayID = 346
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 347
EXEC AssignEmployeeToConferenceDay @EmployeeID = 33, @ConferenceDayID = 347
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 347
EXEC AssignEmployeeToConferenceDay @EmployeeID = 27, @ConferenceDayID = 347
EXEC AssignEmployeeToConferenceDay @EmployeeID = 10, @ConferenceDayID = 347
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 348
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 348
EXEC AssignEmployeeToConferenceDay @EmployeeID = 60, @ConferenceDayID = 348
EXEC AssignEmployeeToConferenceDay @EmployeeID = 26, @ConferenceDayID = 348
EXEC AssignEmployeeToConferenceDay @EmployeeID = 54, @ConferenceDayID = 348
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 348
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 348
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 349
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 349
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 349
EXEC AssignEmployeeToConferenceDay @EmployeeID = 36, @ConferenceDayID = 349
EXEC AssignEmployeeToConferenceDay @EmployeeID = 68, @ConferenceDayID = 349
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 349
EXEC AssignEmployeeToConferenceDay @EmployeeID = 43, @ConferenceDayID = 349
EXEC AssignEmployeeToConferenceDay @EmployeeID = 30, @ConferenceDayID = 350
EXEC AssignEmployeeToConferenceDay @EmployeeID = 20, @ConferenceDayID = 350
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 350
EXEC AssignEmployeeToConferenceDay @EmployeeID = 44, @ConferenceDayID = 350
EXEC AssignEmployeeToConferenceDay @EmployeeID = 17, @ConferenceDayID = 351
EXEC AssignEmployeeToConferenceDay @EmployeeID = 47, @ConferenceDayID = 351
EXEC AssignEmployeeToConferenceDay @EmployeeID = 28, @ConferenceDayID = 351
EXEC AssignEmployeeToConferenceDay @EmployeeID = 25, @ConferenceDayID = 351
EXEC AssignEmployeeToConferenceDay @EmployeeID = 12, @ConferenceDayID = 351
EXEC AssignEmployeeToConferenceDay @EmployeeID = 32, @ConferenceDayID = 351
EXEC AssignEmployeeToConferenceDay @EmployeeID = 50, @ConferenceDayID = 351
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 352
EXEC AssignEmployeeToConferenceDay @EmployeeID = 58, @ConferenceDayID = 352
EXEC AssignEmployeeToConferenceDay @EmployeeID = 59, @ConferenceDayID = 352
EXEC AssignEmployeeToConferenceDay @EmployeeID = 15, @ConferenceDayID = 352
EXEC AssignEmployeeToConferenceDay @EmployeeID = 1, @ConferenceDayID = 353
EXEC AssignEmployeeToConferenceDay @EmployeeID = 18, @ConferenceDayID = 353
EXEC AssignEmployeeToConferenceDay @EmployeeID = 34, @ConferenceDayID = 353
EXEC AssignEmployeeToConferenceDay @EmployeeID = 23, @ConferenceDayID = 353
EXEC AssignEmployeeToConferenceDay @EmployeeID = 57, @ConferenceDayID = 354
EXEC AssignEmployeeToConferenceDay @EmployeeID = 46, @ConferenceDayID = 354
EXEC AssignEmployeeToConferenceDay @EmployeeID = 55, @ConferenceDayID = 354
EXEC AssignEmployeeToConferenceDay @EmployeeID = 6, @ConferenceDayID = 354
EXEC AssignEmployeeToConferenceDay @EmployeeID = 67, @ConferenceDayID = 354
EXEC AssignEmployeeToConferenceDay @EmployeeID = 51, @ConferenceDayID = 354
EXEC AssignEmployeeToConferenceDay @EmployeeID = 38, @ConferenceDayID = 354
EXEC AssignEmployeeToConferenceDay @EmployeeID = 5, @ConferenceDayID = 354
EXEC AssignEmployeeToConferenceDay @EmployeeID = 3, @ConferenceDayID = 354
EXEC AssignEmployeeToConferenceDay @EmployeeID = 65, @ConferenceDayID = 354
EXEC AddPriceInfo @ConferenceDayID = 1, @InitialDate = '2018-03-27', @Price = 11940, @StudentDiscount = 0.478
EXEC AddPriceInfo @ConferenceDayID = 1, @InitialDate = '2018-11-14', @Price = 14925.0, @StudentDiscount = 0.478
EXEC AddPriceInfo @ConferenceDayID = 1, @InitialDate = '2018-12-14', @Price = 20895.0, @StudentDiscount = 0.478
EXEC AddPriceInfo @ConferenceDayID = 2, @InitialDate = '2018-05-23', @Price = 11880, @StudentDiscount = 0.229
EXEC AddPriceInfo @ConferenceDayID = 2, @InitialDate = '2018-11-15', @Price = 14850.0, @StudentDiscount = 0.229
EXEC AddPriceInfo @ConferenceDayID = 2, @InitialDate = '2018-12-15', @Price = 20790.0, @StudentDiscount = 0.229
EXEC AddPriceInfo @ConferenceDayID = 3, @InitialDate = '2018-05-20', @Price = 5220, @StudentDiscount = 0.288
EXEC AddPriceInfo @ConferenceDayID = 3, @InitialDate = '2018-11-16', @Price = 6525.0, @StudentDiscount = 0.288
EXEC AddPriceInfo @ConferenceDayID = 3, @InitialDate = '2018-12-16', @Price = 9135.0, @StudentDiscount = 0.288
EXEC AddPriceInfo @ConferenceDayID = 4, @InitialDate = '2018-03-10', @Price = 15860, @StudentDiscount = 0.024
EXEC AddPriceInfo @ConferenceDayID = 4, @InitialDate = '2018-11-17', @Price = 19825.0, @StudentDiscount = 0.024
EXEC AddPriceInfo @ConferenceDayID = 4, @InitialDate = '2018-12-17', @Price = 27755.0, @StudentDiscount = 0.024
EXEC AddPriceInfo @ConferenceDayID = 5, @InitialDate = '2018-04-21', @Price = 10840, @StudentDiscount = 0.316
EXEC AddPriceInfo @ConferenceDayID = 5, @InitialDate = '2018-11-18', @Price = 13550.0, @StudentDiscount = 0.316
EXEC AddPriceInfo @ConferenceDayID = 5, @InitialDate = '2018-12-18', @Price = 18970.0, @StudentDiscount = 0.316
EXEC AddPriceInfo @ConferenceDayID = 6, @InitialDate = '2018-06-16', @Price = 9010, @StudentDiscount = 0.150
EXEC AddPriceInfo @ConferenceDayID = 6, @InitialDate = '2018-11-19', @Price = 11262.5, @StudentDiscount = 0.150
EXEC AddPriceInfo @ConferenceDayID = 6, @InitialDate = '2018-12-19', @Price = 15767.5, @StudentDiscount = 0.150
EXEC AddPriceInfo @ConferenceDayID = 7, @InitialDate = '2018-04-17', @Price = 14530, @StudentDiscount = 0.344
EXEC AddPriceInfo @ConferenceDayID = 7, @InitialDate = '2018-11-20', @Price = 18162.5, @StudentDiscount = 0.344
EXEC AddPriceInfo @ConferenceDayID = 7, @InitialDate = '2018-12-20', @Price = 25427.5, @StudentDiscount = 0.344
EXEC AddPriceInfo @ConferenceDayID = 8, @InitialDate = '2017-05-14', @Price = 11320, @StudentDiscount = 0.176
EXEC AddPriceInfo @ConferenceDayID = 8, @InitialDate = '2018-01-19', @Price = 14150.0, @StudentDiscount = 0.176
EXEC AddPriceInfo @ConferenceDayID = 8, @InitialDate = '2018-02-19', @Price = 19810.0, @StudentDiscount = 0.176
EXEC AddPriceInfo @ConferenceDayID = 9, @InitialDate = '2017-08-27', @Price = 13500, @StudentDiscount = 0.152
EXEC AddPriceInfo @ConferenceDayID = 9, @InitialDate = '2018-01-20', @Price = 16875.0, @StudentDiscount = 0.152
EXEC AddPriceInfo @ConferenceDayID = 9, @InitialDate = '2018-02-20', @Price = 23625.0, @StudentDiscount = 0.152
EXEC AddPriceInfo @ConferenceDayID = 10, @InitialDate = '2017-08-19', @Price = 7970, @StudentDiscount = 0.272
EXEC AddPriceInfo @ConferenceDayID = 10, @InitialDate = '2018-01-21', @Price = 9962.5, @StudentDiscount = 0.272
EXEC AddPriceInfo @ConferenceDayID = 10, @InitialDate = '2018-02-21', @Price = 13947.5, @StudentDiscount = 0.272
EXEC AddPriceInfo @ConferenceDayID = 11, @InitialDate = '2017-08-07', @Price = 12670, @StudentDiscount = 0.492
EXEC AddPriceInfo @ConferenceDayID = 11, @InitialDate = '2018-01-22', @Price = 15837.5, @StudentDiscount = 0.492
EXEC AddPriceInfo @ConferenceDayID = 11, @InitialDate = '2018-02-22', @Price = 22172.5, @StudentDiscount = 0.492
EXEC AddPriceInfo @ConferenceDayID = 12, @InitialDate = '2017-08-24', @Price = 10320, @StudentDiscount = 0.410
EXEC AddPriceInfo @ConferenceDayID = 12, @InitialDate = '2018-01-23', @Price = 12900.0, @StudentDiscount = 0.410
EXEC AddPriceInfo @ConferenceDayID = 12, @InitialDate = '2018-02-23', @Price = 18060.0, @StudentDiscount = 0.410
EXEC AddPriceInfo @ConferenceDayID = 13, @InitialDate = '2017-09-12', @Price = 4310, @StudentDiscount = 0.069
EXEC AddPriceInfo @ConferenceDayID = 13, @InitialDate = '2018-01-24', @Price = 5387.5, @StudentDiscount = 0.069
EXEC AddPriceInfo @ConferenceDayID = 13, @InitialDate = '2018-02-24', @Price = 7542.5, @StudentDiscount = 0.069
EXEC AddPriceInfo @ConferenceDayID = 14, @InitialDate = '2017-01-23', @Price = 5940, @StudentDiscount = 0.370
EXEC AddPriceInfo @ConferenceDayID = 14, @InitialDate = '2017-08-07', @Price = 7425.0, @StudentDiscount = 0.370
EXEC AddPriceInfo @ConferenceDayID = 14, @InitialDate = '2017-09-07', @Price = 10395.0, @StudentDiscount = 0.370
EXEC AddPriceInfo @ConferenceDayID = 15, @InitialDate = '2016-12-20', @Price = 12690, @StudentDiscount = 0.259
EXEC AddPriceInfo @ConferenceDayID = 15, @InitialDate = '2017-08-08', @Price = 15862.5, @StudentDiscount = 0.259
EXEC AddPriceInfo @ConferenceDayID = 15, @InitialDate = '2017-09-08', @Price = 22207.5, @StudentDiscount = 0.259
EXEC AddPriceInfo @ConferenceDayID = 16, @InitialDate = '2017-02-22', @Price = 9550, @StudentDiscount = 0.403
EXEC AddPriceInfo @ConferenceDayID = 16, @InitialDate = '2017-08-09', @Price = 11937.5, @StudentDiscount = 0.403
EXEC AddPriceInfo @ConferenceDayID = 16, @InitialDate = '2017-09-09', @Price = 16712.5, @StudentDiscount = 0.403
EXEC AddPriceInfo @ConferenceDayID = 17, @InitialDate = '2016-12-17', @Price = 16160, @StudentDiscount = 0.051
EXEC AddPriceInfo @ConferenceDayID = 17, @InitialDate = '2017-08-10', @Price = 20200.0, @StudentDiscount = 0.051
EXEC AddPriceInfo @ConferenceDayID = 17, @InitialDate = '2017-09-10', @Price = 28280.0, @StudentDiscount = 0.051
EXEC AddPriceInfo @ConferenceDayID = 18, @InitialDate = '2017-03-08', @Price = 10000, @StudentDiscount = 0.477
EXEC AddPriceInfo @ConferenceDayID = 18, @InitialDate = '2017-08-11', @Price = 12500.0, @StudentDiscount = 0.477
EXEC AddPriceInfo @ConferenceDayID = 18, @InitialDate = '2017-09-11', @Price = 17500.0, @StudentDiscount = 0.477
EXEC AddPriceInfo @ConferenceDayID = 19, @InitialDate = '2017-02-26', @Price = 7170, @StudentDiscount = 0.214
EXEC AddPriceInfo @ConferenceDayID = 19, @InitialDate = '2017-08-12', @Price = 8962.5, @StudentDiscount = 0.214
EXEC AddPriceInfo @ConferenceDayID = 19, @InitialDate = '2017-09-12', @Price = 12547.5, @StudentDiscount = 0.214
EXEC AddPriceInfo @ConferenceDayID = 20, @InitialDate = '2017-12-15', @Price = 13090, @StudentDiscount = 0.002
EXEC AddPriceInfo @ConferenceDayID = 20, @InitialDate = '2018-04-05', @Price = 16362.5, @StudentDiscount = 0.002
EXEC AddPriceInfo @ConferenceDayID = 20, @InitialDate = '2018-05-05', @Price = 22907.5, @StudentDiscount = 0.002
EXEC AddPriceInfo @ConferenceDayID = 21, @InitialDate = '2017-08-13', @Price = 14030, @StudentDiscount = 0.134
EXEC AddPriceInfo @ConferenceDayID = 21, @InitialDate = '2018-04-06', @Price = 17537.5, @StudentDiscount = 0.134
EXEC AddPriceInfo @ConferenceDayID = 21, @InitialDate = '2018-05-06', @Price = 24552.5, @StudentDiscount = 0.134
EXEC AddPriceInfo @ConferenceDayID = 22, @InitialDate = '2017-10-19', @Price = 10830, @StudentDiscount = 0.075
EXEC AddPriceInfo @ConferenceDayID = 22, @InitialDate = '2018-04-07', @Price = 13537.5, @StudentDiscount = 0.075
EXEC AddPriceInfo @ConferenceDayID = 22, @InitialDate = '2018-05-07', @Price = 18952.5, @StudentDiscount = 0.075
EXEC AddPriceInfo @ConferenceDayID = 23, @InitialDate = '2016-01-21', @Price = 8920, @StudentDiscount = 0.425
EXEC AddPriceInfo @ConferenceDayID = 23, @InitialDate = '2016-07-05', @Price = 11150.0, @StudentDiscount = 0.425
EXEC AddPriceInfo @ConferenceDayID = 23, @InitialDate = '2016-08-05', @Price = 15610.0, @StudentDiscount = 0.425
EXEC AddPriceInfo @ConferenceDayID = 24, @InitialDate = '2016-01-16', @Price = 15410, @StudentDiscount = 0.290
EXEC AddPriceInfo @ConferenceDayID = 24, @InitialDate = '2016-07-06', @Price = 19262.5, @StudentDiscount = 0.290
EXEC AddPriceInfo @ConferenceDayID = 24, @InitialDate = '2016-08-06', @Price = 26967.5, @StudentDiscount = 0.290
EXEC AddPriceInfo @ConferenceDayID = 25, @InitialDate = '2016-03-17', @Price = 4180, @StudentDiscount = 0.025
EXEC AddPriceInfo @ConferenceDayID = 25, @InitialDate = '2016-07-07', @Price = 5225.0, @StudentDiscount = 0.025
EXEC AddPriceInfo @ConferenceDayID = 25, @InitialDate = '2016-08-07', @Price = 7315.0, @StudentDiscount = 0.025
EXEC AddPriceInfo @ConferenceDayID = 26, @InitialDate = '2016-02-10', @Price = 14730, @StudentDiscount = 0.344
EXEC AddPriceInfo @ConferenceDayID = 26, @InitialDate = '2016-07-08', @Price = 18412.5, @StudentDiscount = 0.344
EXEC AddPriceInfo @ConferenceDayID = 26, @InitialDate = '2016-08-08', @Price = 25777.5, @StudentDiscount = 0.344
EXEC AddPriceInfo @ConferenceDayID = 27, @InitialDate = '2016-03-12', @Price = 14100, @StudentDiscount = 0.320
EXEC AddPriceInfo @ConferenceDayID = 27, @InitialDate = '2016-07-09', @Price = 17625.0, @StudentDiscount = 0.320
EXEC AddPriceInfo @ConferenceDayID = 27, @InitialDate = '2016-08-09', @Price = 24675.0, @StudentDiscount = 0.320
EXEC AddPriceInfo @ConferenceDayID = 28, @InitialDate = '2016-02-10', @Price = 6830, @StudentDiscount = 0.458
EXEC AddPriceInfo @ConferenceDayID = 28, @InitialDate = '2016-07-10', @Price = 8537.5, @StudentDiscount = 0.458
EXEC AddPriceInfo @ConferenceDayID = 28, @InitialDate = '2016-08-10', @Price = 11952.5, @StudentDiscount = 0.458
EXEC AddPriceInfo @ConferenceDayID = 29, @InitialDate = '2017-11-26', @Price = 9680, @StudentDiscount = 0.407
EXEC AddPriceInfo @ConferenceDayID = 29, @InitialDate = '2018-05-17', @Price = 12100.0, @StudentDiscount = 0.407
EXEC AddPriceInfo @ConferenceDayID = 29, @InitialDate = '2018-06-17', @Price = 16940.0, @StudentDiscount = 0.407
EXEC AddPriceInfo @ConferenceDayID = 30, @InitialDate = '2017-09-26', @Price = 3590, @StudentDiscount = 0.441
EXEC AddPriceInfo @ConferenceDayID = 30, @InitialDate = '2018-05-18', @Price = 4487.5, @StudentDiscount = 0.441
EXEC AddPriceInfo @ConferenceDayID = 30, @InitialDate = '2018-06-18', @Price = 6282.5, @StudentDiscount = 0.441
EXEC AddPriceInfo @ConferenceDayID = 31, @InitialDate = '2017-10-22', @Price = 13820, @StudentDiscount = 0.219
EXEC AddPriceInfo @ConferenceDayID = 31, @InitialDate = '2018-05-19', @Price = 17275.0, @StudentDiscount = 0.219
EXEC AddPriceInfo @ConferenceDayID = 31, @InitialDate = '2018-06-19', @Price = 24185.0, @StudentDiscount = 0.219
EXEC AddPriceInfo @ConferenceDayID = 32, @InitialDate = '2017-10-26', @Price = 10950, @StudentDiscount = 0.108
EXEC AddPriceInfo @ConferenceDayID = 32, @InitialDate = '2018-05-20', @Price = 13687.5, @StudentDiscount = 0.108
EXEC AddPriceInfo @ConferenceDayID = 32, @InitialDate = '2018-06-20', @Price = 19162.5, @StudentDiscount = 0.108
EXEC AddPriceInfo @ConferenceDayID = 33, @InitialDate = '2017-12-20', @Price = 11340, @StudentDiscount = 0.227
EXEC AddPriceInfo @ConferenceDayID = 33, @InitialDate = '2018-05-21', @Price = 14175.0, @StudentDiscount = 0.227
EXEC AddPriceInfo @ConferenceDayID = 33, @InitialDate = '2018-06-21', @Price = 19845.0, @StudentDiscount = 0.227
EXEC AddPriceInfo @ConferenceDayID = 34, @InitialDate = '2017-03-25', @Price = 9460, @StudentDiscount = 0.168
EXEC AddPriceInfo @ConferenceDayID = 34, @InitialDate = '2017-11-18', @Price = 11825.0, @StudentDiscount = 0.168
EXEC AddPriceInfo @ConferenceDayID = 34, @InitialDate = '2017-12-18', @Price = 16555.0, @StudentDiscount = 0.168
EXEC AddPriceInfo @ConferenceDayID = 35, @InitialDate = '2017-03-10', @Price = 6210, @StudentDiscount = 0.139
EXEC AddPriceInfo @ConferenceDayID = 35, @InitialDate = '2017-11-19', @Price = 7762.5, @StudentDiscount = 0.139
EXEC AddPriceInfo @ConferenceDayID = 35, @InitialDate = '2017-12-19', @Price = 10867.5, @StudentDiscount = 0.139
EXEC AddPriceInfo @ConferenceDayID = 36, @InitialDate = '2017-03-09', @Price = 4560, @StudentDiscount = 0.425
EXEC AddPriceInfo @ConferenceDayID = 36, @InitialDate = '2017-11-20', @Price = 5700.0, @StudentDiscount = 0.425
EXEC AddPriceInfo @ConferenceDayID = 36, @InitialDate = '2017-12-20', @Price = 7980.0, @StudentDiscount = 0.425
EXEC AddPriceInfo @ConferenceDayID = 37, @InitialDate = '2017-05-21', @Price = 13830, @StudentDiscount = 0.455
EXEC AddPriceInfo @ConferenceDayID = 37, @InitialDate = '2017-11-21', @Price = 17287.5, @StudentDiscount = 0.455
EXEC AddPriceInfo @ConferenceDayID = 37, @InitialDate = '2017-12-21', @Price = 24202.5, @StudentDiscount = 0.455
EXEC AddPriceInfo @ConferenceDayID = 38, @InitialDate = '2016-02-07', @Price = 12560, @StudentDiscount = 0.109
EXEC AddPriceInfo @ConferenceDayID = 38, @InitialDate = '2016-07-04', @Price = 15700.0, @StudentDiscount = 0.109
EXEC AddPriceInfo @ConferenceDayID = 38, @InitialDate = '2016-08-04', @Price = 21980.0, @StudentDiscount = 0.109
EXEC AddPriceInfo @ConferenceDayID = 39, @InitialDate = '2016-03-26', @Price = 8040, @StudentDiscount = 0.022
EXEC AddPriceInfo @ConferenceDayID = 39, @InitialDate = '2016-07-05', @Price = 10050.0, @StudentDiscount = 0.022
EXEC AddPriceInfo @ConferenceDayID = 39, @InitialDate = '2016-08-05', @Price = 14070.0, @StudentDiscount = 0.022
EXEC AddPriceInfo @ConferenceDayID = 40, @InitialDate = '2015-12-03', @Price = 3460, @StudentDiscount = 0.211
EXEC AddPriceInfo @ConferenceDayID = 40, @InitialDate = '2016-07-06', @Price = 4325.0, @StudentDiscount = 0.211
EXEC AddPriceInfo @ConferenceDayID = 40, @InitialDate = '2016-08-06', @Price = 6055.0, @StudentDiscount = 0.211
EXEC AddPriceInfo @ConferenceDayID = 41, @InitialDate = '2016-03-19', @Price = 14050, @StudentDiscount = 0.037
EXEC AddPriceInfo @ConferenceDayID = 41, @InitialDate = '2016-07-07', @Price = 17562.5, @StudentDiscount = 0.037
EXEC AddPriceInfo @ConferenceDayID = 41, @InitialDate = '2016-08-07', @Price = 24587.5, @StudentDiscount = 0.037
EXEC AddPriceInfo @ConferenceDayID = 42, @InitialDate = '2016-06-05', @Price = 7480, @StudentDiscount = 0.090
EXEC AddPriceInfo @ConferenceDayID = 42, @InitialDate = '2016-12-09', @Price = 9350.0, @StudentDiscount = 0.090
EXEC AddPriceInfo @ConferenceDayID = 42, @InitialDate = '2017-01-09', @Price = 13090.0, @StudentDiscount = 0.090
EXEC AddPriceInfo @ConferenceDayID = 43, @InitialDate = '2016-04-12', @Price = 9760, @StudentDiscount = 0.062
EXEC AddPriceInfo @ConferenceDayID = 43, @InitialDate = '2016-12-10', @Price = 12200.0, @StudentDiscount = 0.062
EXEC AddPriceInfo @ConferenceDayID = 43, @InitialDate = '2017-01-10', @Price = 17080.0, @StudentDiscount = 0.062
EXEC AddPriceInfo @ConferenceDayID = 44, @InitialDate = '2016-04-20', @Price = 8570, @StudentDiscount = 0.270
EXEC AddPriceInfo @ConferenceDayID = 44, @InitialDate = '2016-12-11', @Price = 10712.5, @StudentDiscount = 0.270
EXEC AddPriceInfo @ConferenceDayID = 44, @InitialDate = '2017-01-11', @Price = 14997.5, @StudentDiscount = 0.270
EXEC AddPriceInfo @ConferenceDayID = 45, @InitialDate = '2016-05-22', @Price = 6310, @StudentDiscount = 0.498
EXEC AddPriceInfo @ConferenceDayID = 45, @InitialDate = '2016-12-12', @Price = 7887.5, @StudentDiscount = 0.498
EXEC AddPriceInfo @ConferenceDayID = 45, @InitialDate = '2017-01-12', @Price = 11042.5, @StudentDiscount = 0.498
EXEC AddPriceInfo @ConferenceDayID = 46, @InitialDate = '2015-10-05', @Price = 8020, @StudentDiscount = 0.329
EXEC AddPriceInfo @ConferenceDayID = 46, @InitialDate = '2016-05-08', @Price = 10025.0, @StudentDiscount = 0.329
EXEC AddPriceInfo @ConferenceDayID = 46, @InitialDate = '2016-06-08', @Price = 14035.0, @StudentDiscount = 0.329
EXEC AddPriceInfo @ConferenceDayID = 47, @InitialDate = '2015-09-27', @Price = 12800, @StudentDiscount = 0.466
EXEC AddPriceInfo @ConferenceDayID = 47, @InitialDate = '2016-05-09', @Price = 16000.0, @StudentDiscount = 0.466
EXEC AddPriceInfo @ConferenceDayID = 47, @InitialDate = '2016-06-09', @Price = 22400.0, @StudentDiscount = 0.466
EXEC AddPriceInfo @ConferenceDayID = 48, @InitialDate = '2015-09-12', @Price = 7470, @StudentDiscount = 0.154
EXEC AddPriceInfo @ConferenceDayID = 48, @InitialDate = '2016-05-10', @Price = 9337.5, @StudentDiscount = 0.154
EXEC AddPriceInfo @ConferenceDayID = 48, @InitialDate = '2016-06-10', @Price = 13072.5, @StudentDiscount = 0.154
EXEC AddPriceInfo @ConferenceDayID = 49, @InitialDate = '2015-11-11', @Price = 14000, @StudentDiscount = 0.274
EXEC AddPriceInfo @ConferenceDayID = 49, @InitialDate = '2016-05-11', @Price = 17500.0, @StudentDiscount = 0.274
EXEC AddPriceInfo @ConferenceDayID = 49, @InitialDate = '2016-06-11', @Price = 24500.0, @StudentDiscount = 0.274
EXEC AddPriceInfo @ConferenceDayID = 50, @InitialDate = '2015-11-12', @Price = 10130, @StudentDiscount = 0.378
EXEC AddPriceInfo @ConferenceDayID = 50, @InitialDate = '2016-05-12', @Price = 12662.5, @StudentDiscount = 0.378
EXEC AddPriceInfo @ConferenceDayID = 50, @InitialDate = '2016-06-12', @Price = 17727.5, @StudentDiscount = 0.378
EXEC AddPriceInfo @ConferenceDayID = 51, @InitialDate = '2017-01-25', @Price = 12980, @StudentDiscount = 0.409
EXEC AddPriceInfo @ConferenceDayID = 51, @InitialDate = '2017-07-17', @Price = 16225.0, @StudentDiscount = 0.409
EXEC AddPriceInfo @ConferenceDayID = 51, @InitialDate = '2017-08-17', @Price = 22715.0, @StudentDiscount = 0.409
EXEC AddPriceInfo @ConferenceDayID = 52, @InitialDate = '2017-03-25', @Price = 16250, @StudentDiscount = 0.185
EXEC AddPriceInfo @ConferenceDayID = 52, @InitialDate = '2017-07-18', @Price = 20312.5, @StudentDiscount = 0.185
EXEC AddPriceInfo @ConferenceDayID = 52, @InitialDate = '2017-08-18', @Price = 28437.5, @StudentDiscount = 0.185
EXEC AddPriceInfo @ConferenceDayID = 53, @InitialDate = '2017-01-14', @Price = 3300, @StudentDiscount = 0.288
EXEC AddPriceInfo @ConferenceDayID = 53, @InitialDate = '2017-07-19', @Price = 4125.0, @StudentDiscount = 0.288
EXEC AddPriceInfo @ConferenceDayID = 53, @InitialDate = '2017-08-19', @Price = 5775.0, @StudentDiscount = 0.288
EXEC AddPriceInfo @ConferenceDayID = 54, @InitialDate = '2020-07-15', @Price = 16270, @StudentDiscount = 0.284
EXEC AddPriceInfo @ConferenceDayID = 54, @InitialDate = '2021-01-01', @Price = 20337.5, @StudentDiscount = 0.284
EXEC AddPriceInfo @ConferenceDayID = 54, @InitialDate = '2021-02-01', @Price = 28472.5, @StudentDiscount = 0.284
EXEC AddPriceInfo @ConferenceDayID = 55, @InitialDate = '2020-09-02', @Price = 11600, @StudentDiscount = 0.143
EXEC AddPriceInfo @ConferenceDayID = 55, @InitialDate = '2021-01-02', @Price = 14500.0, @StudentDiscount = 0.143
EXEC AddPriceInfo @ConferenceDayID = 55, @InitialDate = '2021-02-02', @Price = 20300.0, @StudentDiscount = 0.143
EXEC AddPriceInfo @ConferenceDayID = 56, @InitialDate = '2020-08-24', @Price = 11940, @StudentDiscount = 0.373
EXEC AddPriceInfo @ConferenceDayID = 56, @InitialDate = '2021-01-03', @Price = 14925.0, @StudentDiscount = 0.373
EXEC AddPriceInfo @ConferenceDayID = 56, @InitialDate = '2021-02-03', @Price = 20895.0, @StudentDiscount = 0.373
EXEC AddPriceInfo @ConferenceDayID = 57, @InitialDate = '2020-08-13', @Price = 4710, @StudentDiscount = 0.351
EXEC AddPriceInfo @ConferenceDayID = 57, @InitialDate = '2021-01-04', @Price = 5887.5, @StudentDiscount = 0.351
EXEC AddPriceInfo @ConferenceDayID = 57, @InitialDate = '2021-02-04', @Price = 8242.5, @StudentDiscount = 0.351
EXEC AddPriceInfo @ConferenceDayID = 58, @InitialDate = '2016-08-17', @Price = 3300, @StudentDiscount = 0.080
EXEC AddPriceInfo @ConferenceDayID = 58, @InitialDate = '2017-01-04', @Price = 4125.0, @StudentDiscount = 0.080
EXEC AddPriceInfo @ConferenceDayID = 58, @InitialDate = '2017-02-04', @Price = 5775.0, @StudentDiscount = 0.080
EXEC AddPriceInfo @ConferenceDayID = 59, @InitialDate = '2016-06-28', @Price = 5010, @StudentDiscount = 0.000
EXEC AddPriceInfo @ConferenceDayID = 59, @InitialDate = '2017-01-05', @Price = 6262.5, @StudentDiscount = 0.000
EXEC AddPriceInfo @ConferenceDayID = 59, @InitialDate = '2017-02-05', @Price = 8767.5, @StudentDiscount = 0.000
EXEC AddPriceInfo @ConferenceDayID = 60, @InitialDate = '2016-06-10', @Price = 12450, @StudentDiscount = 0.044
EXEC AddPriceInfo @ConferenceDayID = 60, @InitialDate = '2017-01-06', @Price = 15562.5, @StudentDiscount = 0.044
EXEC AddPriceInfo @ConferenceDayID = 60, @InitialDate = '2017-02-06', @Price = 21787.5, @StudentDiscount = 0.044
EXEC AddPriceInfo @ConferenceDayID = 61, @InitialDate = '2016-08-02', @Price = 13860, @StudentDiscount = 0.312
EXEC AddPriceInfo @ConferenceDayID = 61, @InitialDate = '2017-01-07', @Price = 17325.0, @StudentDiscount = 0.312
EXEC AddPriceInfo @ConferenceDayID = 61, @InitialDate = '2017-02-07', @Price = 24255.0, @StudentDiscount = 0.312
EXEC AddPriceInfo @ConferenceDayID = 62, @InitialDate = '2016-06-07', @Price = 12940, @StudentDiscount = 0.409
EXEC AddPriceInfo @ConferenceDayID = 62, @InitialDate = '2017-01-08', @Price = 16175.0, @StudentDiscount = 0.409
EXEC AddPriceInfo @ConferenceDayID = 62, @InitialDate = '2017-02-08', @Price = 22645.0, @StudentDiscount = 0.409
EXEC AddPriceInfo @ConferenceDayID = 63, @InitialDate = '2016-06-07', @Price = 8260, @StudentDiscount = 0.146
EXEC AddPriceInfo @ConferenceDayID = 63, @InitialDate = '2017-01-09', @Price = 10325.0, @StudentDiscount = 0.146
EXEC AddPriceInfo @ConferenceDayID = 63, @InitialDate = '2017-02-09', @Price = 14455.0, @StudentDiscount = 0.146
EXEC AddPriceInfo @ConferenceDayID = 64, @InitialDate = '2020-04-02', @Price = 5510, @StudentDiscount = 0.398
EXEC AddPriceInfo @ConferenceDayID = 64, @InitialDate = '2020-09-15', @Price = 6887.5, @StudentDiscount = 0.398
EXEC AddPriceInfo @ConferenceDayID = 64, @InitialDate = '2020-10-15', @Price = 9642.5, @StudentDiscount = 0.398
EXEC AddPriceInfo @ConferenceDayID = 65, @InitialDate = '2020-05-26', @Price = 5810, @StudentDiscount = 0.131
EXEC AddPriceInfo @ConferenceDayID = 65, @InitialDate = '2020-09-16', @Price = 7262.5, @StudentDiscount = 0.131
EXEC AddPriceInfo @ConferenceDayID = 65, @InitialDate = '2020-10-16', @Price = 10167.5, @StudentDiscount = 0.131
EXEC AddPriceInfo @ConferenceDayID = 66, @InitialDate = '2020-02-16', @Price = 6470, @StudentDiscount = 0.193
EXEC AddPriceInfo @ConferenceDayID = 66, @InitialDate = '2020-09-17', @Price = 8087.5, @StudentDiscount = 0.193
EXEC AddPriceInfo @ConferenceDayID = 66, @InitialDate = '2020-10-17', @Price = 11322.5, @StudentDiscount = 0.193
EXEC AddPriceInfo @ConferenceDayID = 67, @InitialDate = '2020-05-11', @Price = 7360, @StudentDiscount = 0.306
EXEC AddPriceInfo @ConferenceDayID = 67, @InitialDate = '2020-09-18', @Price = 9200.0, @StudentDiscount = 0.306
EXEC AddPriceInfo @ConferenceDayID = 67, @InitialDate = '2020-10-18', @Price = 12880.0, @StudentDiscount = 0.306
EXEC AddPriceInfo @ConferenceDayID = 68, @InitialDate = '2020-10-01', @Price = 6750, @StudentDiscount = 0.335
EXEC AddPriceInfo @ConferenceDayID = 68, @InitialDate = '2021-02-19', @Price = 8437.5, @StudentDiscount = 0.335
EXEC AddPriceInfo @ConferenceDayID = 68, @InitialDate = '2021-03-19', @Price = 11812.5, @StudentDiscount = 0.335
EXEC AddPriceInfo @ConferenceDayID = 69, @InitialDate = '2020-08-21', @Price = 9990, @StudentDiscount = 0.460
EXEC AddPriceInfo @ConferenceDayID = 69, @InitialDate = '2021-02-20', @Price = 12487.5, @StudentDiscount = 0.460
EXEC AddPriceInfo @ConferenceDayID = 69, @InitialDate = '2021-03-20', @Price = 17482.5, @StudentDiscount = 0.460
EXEC AddPriceInfo @ConferenceDayID = 70, @InitialDate = '2020-10-05', @Price = 3030, @StudentDiscount = 0.366
EXEC AddPriceInfo @ConferenceDayID = 70, @InitialDate = '2021-02-21', @Price = 3787.5, @StudentDiscount = 0.366
EXEC AddPriceInfo @ConferenceDayID = 70, @InitialDate = '2021-03-21', @Price = 5302.5, @StudentDiscount = 0.366
EXEC AddPriceInfo @ConferenceDayID = 71, @InitialDate = '2020-06-11', @Price = 10800, @StudentDiscount = 0.202
EXEC AddPriceInfo @ConferenceDayID = 71, @InitialDate = '2021-02-22', @Price = 13500.0, @StudentDiscount = 0.202
EXEC AddPriceInfo @ConferenceDayID = 71, @InitialDate = '2021-03-22', @Price = 18900.0, @StudentDiscount = 0.202
EXEC AddPriceInfo @ConferenceDayID = 72, @InitialDate = '2020-10-03', @Price = 6080, @StudentDiscount = 0.009
EXEC AddPriceInfo @ConferenceDayID = 72, @InitialDate = '2021-02-23', @Price = 7600.0, @StudentDiscount = 0.009
EXEC AddPriceInfo @ConferenceDayID = 72, @InitialDate = '2021-03-23', @Price = 10640.0, @StudentDiscount = 0.009
EXEC AddPriceInfo @ConferenceDayID = 73, @InitialDate = '2019-09-27', @Price = 15680, @StudentDiscount = 0.003
EXEC AddPriceInfo @ConferenceDayID = 73, @InitialDate = '2020-04-19', @Price = 19600.0, @StudentDiscount = 0.003
EXEC AddPriceInfo @ConferenceDayID = 73, @InitialDate = '2020-05-19', @Price = 27440.0, @StudentDiscount = 0.003
EXEC AddPriceInfo @ConferenceDayID = 74, @InitialDate = '2019-09-23', @Price = 9200, @StudentDiscount = 0.081
EXEC AddPriceInfo @ConferenceDayID = 74, @InitialDate = '2020-04-20', @Price = 11500.0, @StudentDiscount = 0.081
EXEC AddPriceInfo @ConferenceDayID = 74, @InitialDate = '2020-05-20', @Price = 16100.0, @StudentDiscount = 0.081
EXEC AddPriceInfo @ConferenceDayID = 75, @InitialDate = '2019-12-21', @Price = 9900, @StudentDiscount = 0.090
EXEC AddPriceInfo @ConferenceDayID = 75, @InitialDate = '2020-04-21', @Price = 12375.0, @StudentDiscount = 0.090
EXEC AddPriceInfo @ConferenceDayID = 75, @InitialDate = '2020-05-21', @Price = 17325.0, @StudentDiscount = 0.090
EXEC AddPriceInfo @ConferenceDayID = 76, @InitialDate = '2019-10-15', @Price = 4900, @StudentDiscount = 0.185
EXEC AddPriceInfo @ConferenceDayID = 76, @InitialDate = '2020-04-22', @Price = 6125.0, @StudentDiscount = 0.185
EXEC AddPriceInfo @ConferenceDayID = 76, @InitialDate = '2020-05-22', @Price = 8575.0, @StudentDiscount = 0.185
EXEC AddPriceInfo @ConferenceDayID = 77, @InitialDate = '2019-10-11', @Price = 4900, @StudentDiscount = 0.264
EXEC AddPriceInfo @ConferenceDayID = 77, @InitialDate = '2020-04-23', @Price = 6125.0, @StudentDiscount = 0.264
EXEC AddPriceInfo @ConferenceDayID = 77, @InitialDate = '2020-05-23', @Price = 8575.0, @StudentDiscount = 0.264
EXEC AddPriceInfo @ConferenceDayID = 78, @InitialDate = '2020-03-09', @Price = 12130, @StudentDiscount = 0.009
EXEC AddPriceInfo @ConferenceDayID = 78, @InitialDate = '2020-08-01', @Price = 15162.5, @StudentDiscount = 0.009
EXEC AddPriceInfo @ConferenceDayID = 78, @InitialDate = '2020-09-01', @Price = 21227.5, @StudentDiscount = 0.009
EXEC AddPriceInfo @ConferenceDayID = 79, @InitialDate = '2020-03-17', @Price = 11790, @StudentDiscount = 0.034
EXEC AddPriceInfo @ConferenceDayID = 79, @InitialDate = '2020-08-02', @Price = 14737.5, @StudentDiscount = 0.034
EXEC AddPriceInfo @ConferenceDayID = 79, @InitialDate = '2020-09-02', @Price = 20632.5, @StudentDiscount = 0.034
EXEC AddPriceInfo @ConferenceDayID = 80, @InitialDate = '2020-02-20', @Price = 6980, @StudentDiscount = 0.104
EXEC AddPriceInfo @ConferenceDayID = 80, @InitialDate = '2020-08-03', @Price = 8725.0, @StudentDiscount = 0.104
EXEC AddPriceInfo @ConferenceDayID = 80, @InitialDate = '2020-09-03', @Price = 12215.0, @StudentDiscount = 0.104
EXEC AddPriceInfo @ConferenceDayID = 81, @InitialDate = '2020-02-26', @Price = 6410, @StudentDiscount = 0.096
EXEC AddPriceInfo @ConferenceDayID = 81, @InitialDate = '2020-08-04', @Price = 8012.5, @StudentDiscount = 0.096
EXEC AddPriceInfo @ConferenceDayID = 81, @InitialDate = '2020-09-04', @Price = 11217.5, @StudentDiscount = 0.096
EXEC AddPriceInfo @ConferenceDayID = 82, @InitialDate = '2020-01-25', @Price = 2640, @StudentDiscount = 0.198
EXEC AddPriceInfo @ConferenceDayID = 82, @InitialDate = '2020-08-05', @Price = 3300.0, @StudentDiscount = 0.198
EXEC AddPriceInfo @ConferenceDayID = 82, @InitialDate = '2020-09-05', @Price = 4620.0, @StudentDiscount = 0.198
EXEC AddPriceInfo @ConferenceDayID = 83, @InitialDate = '2020-04-20', @Price = 3550, @StudentDiscount = 0.330
EXEC AddPriceInfo @ConferenceDayID = 83, @InitialDate = '2020-08-06', @Price = 4437.5, @StudentDiscount = 0.330
EXEC AddPriceInfo @ConferenceDayID = 83, @InitialDate = '2020-09-06', @Price = 6212.5, @StudentDiscount = 0.330
EXEC AddPriceInfo @ConferenceDayID = 84, @InitialDate = '2019-12-06', @Price = 4640, @StudentDiscount = 0.130
EXEC AddPriceInfo @ConferenceDayID = 84, @InitialDate = '2020-08-07', @Price = 5800.0, @StudentDiscount = 0.130
EXEC AddPriceInfo @ConferenceDayID = 84, @InitialDate = '2020-09-07', @Price = 8120.0, @StudentDiscount = 0.130
EXEC AddPriceInfo @ConferenceDayID = 85, @InitialDate = '2016-08-28', @Price = 5280, @StudentDiscount = 0.353
EXEC AddPriceInfo @ConferenceDayID = 85, @InitialDate = '2017-02-17', @Price = 6600.0, @StudentDiscount = 0.353
EXEC AddPriceInfo @ConferenceDayID = 85, @InitialDate = '2017-03-17', @Price = 9240.0, @StudentDiscount = 0.353
EXEC AddPriceInfo @ConferenceDayID = 86, @InitialDate = '2016-08-23', @Price = 13790, @StudentDiscount = 0.015
EXEC AddPriceInfo @ConferenceDayID = 86, @InitialDate = '2017-02-18', @Price = 17237.5, @StudentDiscount = 0.015
EXEC AddPriceInfo @ConferenceDayID = 86, @InitialDate = '2017-03-18', @Price = 24132.5, @StudentDiscount = 0.015
EXEC AddPriceInfo @ConferenceDayID = 87, @InitialDate = '2016-08-01', @Price = 5640, @StudentDiscount = 0.321
EXEC AddPriceInfo @ConferenceDayID = 87, @InitialDate = '2017-02-19', @Price = 7050.0, @StudentDiscount = 0.321
EXEC AddPriceInfo @ConferenceDayID = 87, @InitialDate = '2017-03-19', @Price = 9870.0, @StudentDiscount = 0.321
EXEC AddPriceInfo @ConferenceDayID = 88, @InitialDate = '2016-09-03', @Price = 12430, @StudentDiscount = 0.138
EXEC AddPriceInfo @ConferenceDayID = 88, @InitialDate = '2017-02-20', @Price = 15537.5, @StudentDiscount = 0.138
EXEC AddPriceInfo @ConferenceDayID = 88, @InitialDate = '2017-03-20', @Price = 21752.5, @StudentDiscount = 0.138
EXEC AddPriceInfo @ConferenceDayID = 89, @InitialDate = '2015-03-21', @Price = 3100, @StudentDiscount = 0.210
EXEC AddPriceInfo @ConferenceDayID = 89, @InitialDate = '2015-11-19', @Price = 3875.0, @StudentDiscount = 0.210
EXEC AddPriceInfo @ConferenceDayID = 89, @InitialDate = '2015-12-19', @Price = 5425.0, @StudentDiscount = 0.210
EXEC AddPriceInfo @ConferenceDayID = 90, @InitialDate = '2015-07-04', @Price = 8690, @StudentDiscount = 0.433
EXEC AddPriceInfo @ConferenceDayID = 90, @InitialDate = '2015-11-20', @Price = 10862.5, @StudentDiscount = 0.433
EXEC AddPriceInfo @ConferenceDayID = 90, @InitialDate = '2015-12-20', @Price = 15207.5, @StudentDiscount = 0.433
EXEC AddPriceInfo @ConferenceDayID = 91, @InitialDate = '2015-04-17', @Price = 11970, @StudentDiscount = 0.362
EXEC AddPriceInfo @ConferenceDayID = 91, @InitialDate = '2015-11-21', @Price = 14962.5, @StudentDiscount = 0.362
EXEC AddPriceInfo @ConferenceDayID = 91, @InitialDate = '2015-12-21', @Price = 20947.5, @StudentDiscount = 0.362
EXEC AddPriceInfo @ConferenceDayID = 92, @InitialDate = '2020-08-26', @Price = 14390, @StudentDiscount = 0.150
EXEC AddPriceInfo @ConferenceDayID = 92, @InitialDate = '2020-12-15', @Price = 17987.5, @StudentDiscount = 0.150
EXEC AddPriceInfo @ConferenceDayID = 92, @InitialDate = '2021-01-15', @Price = 25182.5, @StudentDiscount = 0.150
EXEC AddPriceInfo @ConferenceDayID = 93, @InitialDate = '2020-05-25', @Price = 13830, @StudentDiscount = 0.488
EXEC AddPriceInfo @ConferenceDayID = 93, @InitialDate = '2020-12-16', @Price = 17287.5, @StudentDiscount = 0.488
EXEC AddPriceInfo @ConferenceDayID = 93, @InitialDate = '2021-01-16', @Price = 24202.5, @StudentDiscount = 0.488
EXEC AddPriceInfo @ConferenceDayID = 94, @InitialDate = '2020-04-20', @Price = 6550, @StudentDiscount = 0.125
EXEC AddPriceInfo @ConferenceDayID = 94, @InitialDate = '2020-12-17', @Price = 8187.5, @StudentDiscount = 0.125
EXEC AddPriceInfo @ConferenceDayID = 94, @InitialDate = '2021-01-17', @Price = 11462.5, @StudentDiscount = 0.125
EXEC AddPriceInfo @ConferenceDayID = 95, @InitialDate = '2017-02-04', @Price = 6520, @StudentDiscount = 0.328
EXEC AddPriceInfo @ConferenceDayID = 95, @InitialDate = '2017-07-04', @Price = 8150.0, @StudentDiscount = 0.328
EXEC AddPriceInfo @ConferenceDayID = 95, @InitialDate = '2017-08-04', @Price = 11410.0, @StudentDiscount = 0.328
EXEC AddPriceInfo @ConferenceDayID = 96, @InitialDate = '2016-11-15', @Price = 5420, @StudentDiscount = 0.164
EXEC AddPriceInfo @ConferenceDayID = 96, @InitialDate = '2017-07-05', @Price = 6775.0, @StudentDiscount = 0.164
EXEC AddPriceInfo @ConferenceDayID = 96, @InitialDate = '2017-08-05', @Price = 9485.0, @StudentDiscount = 0.164
EXEC AddPriceInfo @ConferenceDayID = 97, @InitialDate = '2017-03-23', @Price = 15490, @StudentDiscount = 0.062
EXEC AddPriceInfo @ConferenceDayID = 97, @InitialDate = '2017-07-06', @Price = 19362.5, @StudentDiscount = 0.062
EXEC AddPriceInfo @ConferenceDayID = 97, @InitialDate = '2017-08-06', @Price = 27107.5, @StudentDiscount = 0.062
EXEC AddPriceInfo @ConferenceDayID = 98, @InitialDate = '2017-03-27', @Price = 5490, @StudentDiscount = 0.129
EXEC AddPriceInfo @ConferenceDayID = 98, @InitialDate = '2017-07-07', @Price = 6862.5, @StudentDiscount = 0.129
EXEC AddPriceInfo @ConferenceDayID = 98, @InitialDate = '2017-08-07', @Price = 9607.5, @StudentDiscount = 0.129
EXEC AddPriceInfo @ConferenceDayID = 99, @InitialDate = '2016-11-08', @Price = 2450, @StudentDiscount = 0.029
EXEC AddPriceInfo @ConferenceDayID = 99, @InitialDate = '2017-04-08', @Price = 3062.5, @StudentDiscount = 0.029
EXEC AddPriceInfo @ConferenceDayID = 99, @InitialDate = '2017-05-08', @Price = 4287.5, @StudentDiscount = 0.029
EXEC AddPriceInfo @ConferenceDayID = 100, @InitialDate = '2016-12-02', @Price = 15220, @StudentDiscount = 0.153
EXEC AddPriceInfo @ConferenceDayID = 100, @InitialDate = '2017-04-09', @Price = 19025.0, @StudentDiscount = 0.153
EXEC AddPriceInfo @ConferenceDayID = 100, @InitialDate = '2017-05-09', @Price = 26635.0, @StudentDiscount = 0.153
EXEC AddPriceInfo @ConferenceDayID = 101, @InitialDate = '2016-12-13', @Price = 5600, @StudentDiscount = 0.436
EXEC AddPriceInfo @ConferenceDayID = 101, @InitialDate = '2017-04-10', @Price = 7000.0, @StudentDiscount = 0.436
EXEC AddPriceInfo @ConferenceDayID = 101, @InitialDate = '2017-05-10', @Price = 9800.0, @StudentDiscount = 0.436
EXEC AddPriceInfo @ConferenceDayID = 102, @InitialDate = '2020-06-01', @Price = 15070, @StudentDiscount = 0.007
EXEC AddPriceInfo @ConferenceDayID = 102, @InitialDate = '2020-10-04', @Price = 18837.5, @StudentDiscount = 0.007
EXEC AddPriceInfo @ConferenceDayID = 102, @InitialDate = '2020-11-04', @Price = 26372.5, @StudentDiscount = 0.007
EXEC AddPriceInfo @ConferenceDayID = 103, @InitialDate = '2020-03-17', @Price = 9330, @StudentDiscount = 0.046
EXEC AddPriceInfo @ConferenceDayID = 103, @InitialDate = '2020-10-05', @Price = 11662.5, @StudentDiscount = 0.046
EXEC AddPriceInfo @ConferenceDayID = 103, @InitialDate = '2020-11-05', @Price = 16327.5, @StudentDiscount = 0.046
EXEC AddPriceInfo @ConferenceDayID = 104, @InitialDate = '2020-06-15', @Price = 6090, @StudentDiscount = 0.037
EXEC AddPriceInfo @ConferenceDayID = 104, @InitialDate = '2020-10-06', @Price = 7612.5, @StudentDiscount = 0.037
EXEC AddPriceInfo @ConferenceDayID = 104, @InitialDate = '2020-11-06', @Price = 10657.5, @StudentDiscount = 0.037
EXEC AddPriceInfo @ConferenceDayID = 105, @InitialDate = '2020-02-24', @Price = 11720, @StudentDiscount = 0.150
EXEC AddPriceInfo @ConferenceDayID = 105, @InitialDate = '2020-10-07', @Price = 14650.0, @StudentDiscount = 0.150
EXEC AddPriceInfo @ConferenceDayID = 105, @InitialDate = '2020-11-07', @Price = 20510.0, @StudentDiscount = 0.150
EXEC AddPriceInfo @ConferenceDayID = 106, @InitialDate = '2020-02-02', @Price = 16340, @StudentDiscount = 0.018
EXEC AddPriceInfo @ConferenceDayID = 106, @InitialDate = '2020-10-08', @Price = 20425.0, @StudentDiscount = 0.018
EXEC AddPriceInfo @ConferenceDayID = 106, @InitialDate = '2020-11-08', @Price = 28595.0, @StudentDiscount = 0.018
EXEC AddPriceInfo @ConferenceDayID = 107, @InitialDate = '2020-02-10', @Price = 3610, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 107, @InitialDate = '2020-10-09', @Price = 4512.5, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 107, @InitialDate = '2020-11-09', @Price = 6317.5, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 108, @InitialDate = '2020-06-25', @Price = 7170, @StudentDiscount = 0.354
EXEC AddPriceInfo @ConferenceDayID = 108, @InitialDate = '2020-10-10', @Price = 8962.5, @StudentDiscount = 0.354
EXEC AddPriceInfo @ConferenceDayID = 108, @InitialDate = '2020-11-10', @Price = 12547.5, @StudentDiscount = 0.354
EXEC AddPriceInfo @ConferenceDayID = 109, @InitialDate = '2016-07-12', @Price = 3000, @StudentDiscount = 0.362
EXEC AddPriceInfo @ConferenceDayID = 109, @InitialDate = '2017-01-13', @Price = 3750.0, @StudentDiscount = 0.362
EXEC AddPriceInfo @ConferenceDayID = 109, @InitialDate = '2017-02-13', @Price = 5250.0, @StudentDiscount = 0.362
EXEC AddPriceInfo @ConferenceDayID = 110, @InitialDate = '2016-06-28', @Price = 7090, @StudentDiscount = 0.444
EXEC AddPriceInfo @ConferenceDayID = 110, @InitialDate = '2017-01-14', @Price = 8862.5, @StudentDiscount = 0.444
EXEC AddPriceInfo @ConferenceDayID = 110, @InitialDate = '2017-02-14', @Price = 12407.5, @StudentDiscount = 0.444
EXEC AddPriceInfo @ConferenceDayID = 111, @InitialDate = '2016-05-13', @Price = 5720, @StudentDiscount = 0.328
EXEC AddPriceInfo @ConferenceDayID = 111, @InitialDate = '2017-01-15', @Price = 7150.0, @StudentDiscount = 0.328
EXEC AddPriceInfo @ConferenceDayID = 111, @InitialDate = '2017-02-15', @Price = 10010.0, @StudentDiscount = 0.328
EXEC AddPriceInfo @ConferenceDayID = 112, @InitialDate = '2016-06-04', @Price = 15200, @StudentDiscount = 0.228
EXEC AddPriceInfo @ConferenceDayID = 112, @InitialDate = '2017-01-16', @Price = 19000.0, @StudentDiscount = 0.228
EXEC AddPriceInfo @ConferenceDayID = 112, @InitialDate = '2017-02-16', @Price = 26600.0, @StudentDiscount = 0.228
EXEC AddPriceInfo @ConferenceDayID = 113, @InitialDate = '2016-09-03', @Price = 13600, @StudentDiscount = 0.441
EXEC AddPriceInfo @ConferenceDayID = 113, @InitialDate = '2017-01-17', @Price = 17000.0, @StudentDiscount = 0.441
EXEC AddPriceInfo @ConferenceDayID = 113, @InitialDate = '2017-02-17', @Price = 23800.0, @StudentDiscount = 0.441
EXEC AddPriceInfo @ConferenceDayID = 114, @InitialDate = '2016-06-10', @Price = 8220, @StudentDiscount = 0.067
EXEC AddPriceInfo @ConferenceDayID = 114, @InitialDate = '2017-01-18', @Price = 10275.0, @StudentDiscount = 0.067
EXEC AddPriceInfo @ConferenceDayID = 114, @InitialDate = '2017-02-18', @Price = 14385.0, @StudentDiscount = 0.067
EXEC AddPriceInfo @ConferenceDayID = 115, @InitialDate = '2016-05-11', @Price = 5380, @StudentDiscount = 0.098
EXEC AddPriceInfo @ConferenceDayID = 115, @InitialDate = '2017-01-19', @Price = 6725.0, @StudentDiscount = 0.098
EXEC AddPriceInfo @ConferenceDayID = 115, @InitialDate = '2017-02-19', @Price = 9415.0, @StudentDiscount = 0.098
EXEC AddPriceInfo @ConferenceDayID = 116, @InitialDate = '2017-05-23', @Price = 8470, @StudentDiscount = 0.133
EXEC AddPriceInfo @ConferenceDayID = 116, @InitialDate = '2017-09-11', @Price = 10587.5, @StudentDiscount = 0.133
EXEC AddPriceInfo @ConferenceDayID = 116, @InitialDate = '2017-10-11', @Price = 14822.5, @StudentDiscount = 0.133
EXEC AddPriceInfo @ConferenceDayID = 117, @InitialDate = '2017-03-05', @Price = 3420, @StudentDiscount = 0.033
EXEC AddPriceInfo @ConferenceDayID = 117, @InitialDate = '2017-09-12', @Price = 4275.0, @StudentDiscount = 0.033
EXEC AddPriceInfo @ConferenceDayID = 117, @InitialDate = '2017-10-12', @Price = 5985.0, @StudentDiscount = 0.033
EXEC AddPriceInfo @ConferenceDayID = 118, @InitialDate = '2017-04-07', @Price = 12150, @StudentDiscount = 0.290
EXEC AddPriceInfo @ConferenceDayID = 118, @InitialDate = '2017-09-13', @Price = 15187.5, @StudentDiscount = 0.290
EXEC AddPriceInfo @ConferenceDayID = 118, @InitialDate = '2017-10-13', @Price = 21262.5, @StudentDiscount = 0.290
EXEC AddPriceInfo @ConferenceDayID = 119, @InitialDate = '2017-05-25', @Price = 4000, @StudentDiscount = 0.125
EXEC AddPriceInfo @ConferenceDayID = 119, @InitialDate = '2017-09-14', @Price = 5000.0, @StudentDiscount = 0.125
EXEC AddPriceInfo @ConferenceDayID = 119, @InitialDate = '2017-10-14', @Price = 7000.0, @StudentDiscount = 0.125
EXEC AddPriceInfo @ConferenceDayID = 120, @InitialDate = '2017-03-21', @Price = 12000, @StudentDiscount = 0.394
EXEC AddPriceInfo @ConferenceDayID = 120, @InitialDate = '2017-09-15', @Price = 15000.0, @StudentDiscount = 0.394
EXEC AddPriceInfo @ConferenceDayID = 120, @InitialDate = '2017-10-15', @Price = 21000.0, @StudentDiscount = 0.394
EXEC AddPriceInfo @ConferenceDayID = 121, @InitialDate = '2016-10-01', @Price = 16060, @StudentDiscount = 0.104
EXEC AddPriceInfo @ConferenceDayID = 121, @InitialDate = '2017-02-13', @Price = 20075.0, @StudentDiscount = 0.104
EXEC AddPriceInfo @ConferenceDayID = 121, @InitialDate = '2017-03-13', @Price = 28105.0, @StudentDiscount = 0.104
EXEC AddPriceInfo @ConferenceDayID = 122, @InitialDate = '2016-10-24', @Price = 2760, @StudentDiscount = 0.224
EXEC AddPriceInfo @ConferenceDayID = 122, @InitialDate = '2017-02-14', @Price = 3450.0, @StudentDiscount = 0.224
EXEC AddPriceInfo @ConferenceDayID = 122, @InitialDate = '2017-03-14', @Price = 4830.0, @StudentDiscount = 0.224
EXEC AddPriceInfo @ConferenceDayID = 123, @InitialDate = '2016-10-23', @Price = 9520, @StudentDiscount = 0.323
EXEC AddPriceInfo @ConferenceDayID = 123, @InitialDate = '2017-02-15', @Price = 11900.0, @StudentDiscount = 0.323
EXEC AddPriceInfo @ConferenceDayID = 123, @InitialDate = '2017-03-15', @Price = 16660.0, @StudentDiscount = 0.323
EXEC AddPriceInfo @ConferenceDayID = 124, @InitialDate = '2016-06-07', @Price = 7080, @StudentDiscount = 0.406
EXEC AddPriceInfo @ConferenceDayID = 124, @InitialDate = '2017-02-16', @Price = 8850.0, @StudentDiscount = 0.406
EXEC AddPriceInfo @ConferenceDayID = 124, @InitialDate = '2017-03-16', @Price = 12390.0, @StudentDiscount = 0.406
EXEC AddPriceInfo @ConferenceDayID = 125, @InitialDate = '2016-09-22', @Price = 8800, @StudentDiscount = 0.422
EXEC AddPriceInfo @ConferenceDayID = 125, @InitialDate = '2017-02-17', @Price = 11000.0, @StudentDiscount = 0.422
EXEC AddPriceInfo @ConferenceDayID = 125, @InitialDate = '2017-03-17', @Price = 15400.0, @StudentDiscount = 0.422
EXEC AddPriceInfo @ConferenceDayID = 126, @InitialDate = '2016-10-10', @Price = 2580, @StudentDiscount = 0.117
EXEC AddPriceInfo @ConferenceDayID = 126, @InitialDate = '2017-02-18', @Price = 3225.0, @StudentDiscount = 0.117
EXEC AddPriceInfo @ConferenceDayID = 126, @InitialDate = '2017-03-18', @Price = 4515.0, @StudentDiscount = 0.117
EXEC AddPriceInfo @ConferenceDayID = 127, @InitialDate = '2016-11-14', @Price = 15670, @StudentDiscount = 0.025
EXEC AddPriceInfo @ConferenceDayID = 127, @InitialDate = '2017-04-14', @Price = 19587.5, @StudentDiscount = 0.025
EXEC AddPriceInfo @ConferenceDayID = 127, @InitialDate = '2017-05-14', @Price = 27422.5, @StudentDiscount = 0.025
EXEC AddPriceInfo @ConferenceDayID = 128, @InitialDate = '2016-11-11', @Price = 5950, @StudentDiscount = 0.013
EXEC AddPriceInfo @ConferenceDayID = 128, @InitialDate = '2017-04-15', @Price = 7437.5, @StudentDiscount = 0.013
EXEC AddPriceInfo @ConferenceDayID = 128, @InitialDate = '2017-05-15', @Price = 10412.5, @StudentDiscount = 0.013
EXEC AddPriceInfo @ConferenceDayID = 129, @InitialDate = '2016-08-08', @Price = 15090, @StudentDiscount = 0.085
EXEC AddPriceInfo @ConferenceDayID = 129, @InitialDate = '2017-04-16', @Price = 18862.5, @StudentDiscount = 0.085
EXEC AddPriceInfo @ConferenceDayID = 129, @InitialDate = '2017-05-16', @Price = 26407.5, @StudentDiscount = 0.085
EXEC AddPriceInfo @ConferenceDayID = 130, @InitialDate = '2020-05-12', @Price = 15810, @StudentDiscount = 0.208
EXEC AddPriceInfo @ConferenceDayID = 130, @InitialDate = '2020-09-19', @Price = 19762.5, @StudentDiscount = 0.208
EXEC AddPriceInfo @ConferenceDayID = 130, @InitialDate = '2020-10-19', @Price = 27667.5, @StudentDiscount = 0.208
EXEC AddPriceInfo @ConferenceDayID = 131, @InitialDate = '2020-03-20', @Price = 10450, @StudentDiscount = 0.026
EXEC AddPriceInfo @ConferenceDayID = 131, @InitialDate = '2020-09-20', @Price = 13062.5, @StudentDiscount = 0.026
EXEC AddPriceInfo @ConferenceDayID = 131, @InitialDate = '2020-10-20', @Price = 18287.5, @StudentDiscount = 0.026
EXEC AddPriceInfo @ConferenceDayID = 132, @InitialDate = '2020-05-24', @Price = 13670, @StudentDiscount = 0.252
EXEC AddPriceInfo @ConferenceDayID = 132, @InitialDate = '2020-09-21', @Price = 17087.5, @StudentDiscount = 0.252
EXEC AddPriceInfo @ConferenceDayID = 132, @InitialDate = '2020-10-21', @Price = 23922.5, @StudentDiscount = 0.252
EXEC AddPriceInfo @ConferenceDayID = 133, @InitialDate = '2020-04-22', @Price = 16200, @StudentDiscount = 0.128
EXEC AddPriceInfo @ConferenceDayID = 133, @InitialDate = '2020-09-22', @Price = 20250.0, @StudentDiscount = 0.128
EXEC AddPriceInfo @ConferenceDayID = 133, @InitialDate = '2020-10-22', @Price = 28350.0, @StudentDiscount = 0.128
EXEC AddPriceInfo @ConferenceDayID = 134, @InitialDate = '2020-03-13', @Price = 15580, @StudentDiscount = 0.499
EXEC AddPriceInfo @ConferenceDayID = 134, @InitialDate = '2020-09-23', @Price = 19475.0, @StudentDiscount = 0.499
EXEC AddPriceInfo @ConferenceDayID = 134, @InitialDate = '2020-10-23', @Price = 27265.0, @StudentDiscount = 0.499
EXEC AddPriceInfo @ConferenceDayID = 135, @InitialDate = '2016-12-27', @Price = 8490, @StudentDiscount = 0.348
EXEC AddPriceInfo @ConferenceDayID = 135, @InitialDate = '2017-08-07', @Price = 10612.5, @StudentDiscount = 0.348
EXEC AddPriceInfo @ConferenceDayID = 135, @InitialDate = '2017-09-07', @Price = 14857.5, @StudentDiscount = 0.348
EXEC AddPriceInfo @ConferenceDayID = 136, @InitialDate = '2017-04-28', @Price = 12160, @StudentDiscount = 0.032
EXEC AddPriceInfo @ConferenceDayID = 136, @InitialDate = '2017-08-08', @Price = 15200.0, @StudentDiscount = 0.032
EXEC AddPriceInfo @ConferenceDayID = 136, @InitialDate = '2017-09-08', @Price = 21280.0, @StudentDiscount = 0.032
EXEC AddPriceInfo @ConferenceDayID = 137, @InitialDate = '2017-02-20', @Price = 6150, @StudentDiscount = 0.187
EXEC AddPriceInfo @ConferenceDayID = 137, @InitialDate = '2017-08-09', @Price = 7687.5, @StudentDiscount = 0.187
EXEC AddPriceInfo @ConferenceDayID = 137, @InitialDate = '2017-09-09', @Price = 10762.5, @StudentDiscount = 0.187
EXEC AddPriceInfo @ConferenceDayID = 138, @InitialDate = '2017-04-19', @Price = 12170, @StudentDiscount = 0.265
EXEC AddPriceInfo @ConferenceDayID = 138, @InitialDate = '2017-08-10', @Price = 15212.5, @StudentDiscount = 0.265
EXEC AddPriceInfo @ConferenceDayID = 138, @InitialDate = '2017-09-10', @Price = 21297.5, @StudentDiscount = 0.265
EXEC AddPriceInfo @ConferenceDayID = 139, @InitialDate = '2017-02-14', @Price = 8790, @StudentDiscount = 0.481
EXEC AddPriceInfo @ConferenceDayID = 139, @InitialDate = '2017-08-11', @Price = 10987.5, @StudentDiscount = 0.481
EXEC AddPriceInfo @ConferenceDayID = 139, @InitialDate = '2017-09-11', @Price = 15382.5, @StudentDiscount = 0.481
EXEC AddPriceInfo @ConferenceDayID = 140, @InitialDate = '2020-08-15', @Price = 15750, @StudentDiscount = 0.247
EXEC AddPriceInfo @ConferenceDayID = 140, @InitialDate = '2020-12-05', @Price = 19687.5, @StudentDiscount = 0.247
EXEC AddPriceInfo @ConferenceDayID = 140, @InitialDate = '2021-01-05', @Price = 27562.5, @StudentDiscount = 0.247
EXEC AddPriceInfo @ConferenceDayID = 141, @InitialDate = '2020-07-25', @Price = 7570, @StudentDiscount = 0.213
EXEC AddPriceInfo @ConferenceDayID = 141, @InitialDate = '2020-12-06', @Price = 9462.5, @StudentDiscount = 0.213
EXEC AddPriceInfo @ConferenceDayID = 141, @InitialDate = '2021-01-06', @Price = 13247.5, @StudentDiscount = 0.213
EXEC AddPriceInfo @ConferenceDayID = 142, @InitialDate = '2020-07-09', @Price = 13590, @StudentDiscount = 0.060
EXEC AddPriceInfo @ConferenceDayID = 142, @InitialDate = '2020-12-07', @Price = 16987.5, @StudentDiscount = 0.060
EXEC AddPriceInfo @ConferenceDayID = 142, @InitialDate = '2021-01-07', @Price = 23782.5, @StudentDiscount = 0.060
EXEC AddPriceInfo @ConferenceDayID = 143, @InitialDate = '2020-07-21', @Price = 13830, @StudentDiscount = 0.223
EXEC AddPriceInfo @ConferenceDayID = 143, @InitialDate = '2020-12-08', @Price = 17287.5, @StudentDiscount = 0.223
EXEC AddPriceInfo @ConferenceDayID = 143, @InitialDate = '2021-01-08', @Price = 24202.5, @StudentDiscount = 0.223
EXEC AddPriceInfo @ConferenceDayID = 144, @InitialDate = '2020-04-25', @Price = 3570, @StudentDiscount = 0.273
EXEC AddPriceInfo @ConferenceDayID = 144, @InitialDate = '2020-12-09', @Price = 4462.5, @StudentDiscount = 0.273
EXEC AddPriceInfo @ConferenceDayID = 144, @InitialDate = '2021-01-09', @Price = 6247.5, @StudentDiscount = 0.273
EXEC AddPriceInfo @ConferenceDayID = 145, @InitialDate = '2018-02-01', @Price = 13990, @StudentDiscount = 0.027
EXEC AddPriceInfo @ConferenceDayID = 145, @InitialDate = '2018-06-18', @Price = 17487.5, @StudentDiscount = 0.027
EXEC AddPriceInfo @ConferenceDayID = 145, @InitialDate = '2018-07-18', @Price = 24482.5, @StudentDiscount = 0.027
EXEC AddPriceInfo @ConferenceDayID = 146, @InitialDate = '2017-12-25', @Price = 13940, @StudentDiscount = 0.243
EXEC AddPriceInfo @ConferenceDayID = 146, @InitialDate = '2018-06-19', @Price = 17425.0, @StudentDiscount = 0.243
EXEC AddPriceInfo @ConferenceDayID = 146, @InitialDate = '2018-07-19', @Price = 24395.0, @StudentDiscount = 0.243
EXEC AddPriceInfo @ConferenceDayID = 147, @InitialDate = '2017-10-21', @Price = 8660, @StudentDiscount = 0.480
EXEC AddPriceInfo @ConferenceDayID = 147, @InitialDate = '2018-06-20', @Price = 10825.0, @StudentDiscount = 0.480
EXEC AddPriceInfo @ConferenceDayID = 147, @InitialDate = '2018-07-20', @Price = 15155.0, @StudentDiscount = 0.480
EXEC AddPriceInfo @ConferenceDayID = 148, @InitialDate = '2017-12-26', @Price = 7150, @StudentDiscount = 0.421
EXEC AddPriceInfo @ConferenceDayID = 148, @InitialDate = '2018-06-21', @Price = 8937.5, @StudentDiscount = 0.421
EXEC AddPriceInfo @ConferenceDayID = 148, @InitialDate = '2018-07-21', @Price = 12512.5, @StudentDiscount = 0.421
EXEC AddPriceInfo @ConferenceDayID = 149, @InitialDate = '2018-01-02', @Price = 4730, @StudentDiscount = 0.149
EXEC AddPriceInfo @ConferenceDayID = 149, @InitialDate = '2018-06-22', @Price = 5912.5, @StudentDiscount = 0.149
EXEC AddPriceInfo @ConferenceDayID = 149, @InitialDate = '2018-07-22', @Price = 8277.5, @StudentDiscount = 0.149
EXEC AddPriceInfo @ConferenceDayID = 150, @InitialDate = '2017-11-09', @Price = 7720, @StudentDiscount = 0.190
EXEC AddPriceInfo @ConferenceDayID = 150, @InitialDate = '2018-06-23', @Price = 9650.0, @StudentDiscount = 0.190
EXEC AddPriceInfo @ConferenceDayID = 150, @InitialDate = '2018-07-23', @Price = 13510.0, @StudentDiscount = 0.190
EXEC AddPriceInfo @ConferenceDayID = 151, @InitialDate = '2018-01-21', @Price = 13340, @StudentDiscount = 0.332
EXEC AddPriceInfo @ConferenceDayID = 151, @InitialDate = '2018-06-24', @Price = 16675.0, @StudentDiscount = 0.332
EXEC AddPriceInfo @ConferenceDayID = 151, @InitialDate = '2018-07-24', @Price = 23345.0, @StudentDiscount = 0.332
EXEC AddPriceInfo @ConferenceDayID = 152, @InitialDate = '2020-07-14', @Price = 14850, @StudentDiscount = 0.392
EXEC AddPriceInfo @ConferenceDayID = 152, @InitialDate = '2020-12-08', @Price = 18562.5, @StudentDiscount = 0.392
EXEC AddPriceInfo @ConferenceDayID = 152, @InitialDate = '2021-01-08', @Price = 25987.5, @StudentDiscount = 0.392
EXEC AddPriceInfo @ConferenceDayID = 153, @InitialDate = '2020-08-23', @Price = 8740, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 153, @InitialDate = '2020-12-09', @Price = 10925.0, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 153, @InitialDate = '2021-01-09', @Price = 15295.0, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 154, @InitialDate = '2020-06-15', @Price = 11250, @StudentDiscount = 0.278
EXEC AddPriceInfo @ConferenceDayID = 154, @InitialDate = '2020-12-10', @Price = 14062.5, @StudentDiscount = 0.278
EXEC AddPriceInfo @ConferenceDayID = 154, @InitialDate = '2021-01-10', @Price = 19687.5, @StudentDiscount = 0.278
EXEC AddPriceInfo @ConferenceDayID = 155, @InitialDate = '2020-04-16', @Price = 3970, @StudentDiscount = 0.437
EXEC AddPriceInfo @ConferenceDayID = 155, @InitialDate = '2020-12-11', @Price = 4962.5, @StudentDiscount = 0.437
EXEC AddPriceInfo @ConferenceDayID = 155, @InitialDate = '2021-01-11', @Price = 6947.5, @StudentDiscount = 0.437
EXEC AddPriceInfo @ConferenceDayID = 156, @InitialDate = '2020-08-10', @Price = 13460, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 156, @InitialDate = '2020-12-12', @Price = 16825.0, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 156, @InitialDate = '2021-01-12', @Price = 23555.0, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 157, @InitialDate = '2020-06-28', @Price = 14000, @StudentDiscount = 0.402
EXEC AddPriceInfo @ConferenceDayID = 157, @InitialDate = '2020-12-13', @Price = 17500.0, @StudentDiscount = 0.402
EXEC AddPriceInfo @ConferenceDayID = 157, @InitialDate = '2021-01-13', @Price = 24500.0, @StudentDiscount = 0.402
EXEC AddPriceInfo @ConferenceDayID = 158, @InitialDate = '2020-08-18', @Price = 8070, @StudentDiscount = 0.045
EXEC AddPriceInfo @ConferenceDayID = 158, @InitialDate = '2020-12-14', @Price = 10087.5, @StudentDiscount = 0.045
EXEC AddPriceInfo @ConferenceDayID = 158, @InitialDate = '2021-01-14', @Price = 14122.5, @StudentDiscount = 0.045
EXEC AddPriceInfo @ConferenceDayID = 159, @InitialDate = '2015-07-12', @Price = 12980, @StudentDiscount = 0.137
EXEC AddPriceInfo @ConferenceDayID = 159, @InitialDate = '2015-11-09', @Price = 16225.0, @StudentDiscount = 0.137
EXEC AddPriceInfo @ConferenceDayID = 159, @InitialDate = '2015-12-09', @Price = 22715.0, @StudentDiscount = 0.137
EXEC AddPriceInfo @ConferenceDayID = 160, @InitialDate = '2015-05-19', @Price = 3470, @StudentDiscount = 0.430
EXEC AddPriceInfo @ConferenceDayID = 160, @InitialDate = '2015-11-10', @Price = 4337.5, @StudentDiscount = 0.430
EXEC AddPriceInfo @ConferenceDayID = 160, @InitialDate = '2015-12-10', @Price = 6072.5, @StudentDiscount = 0.430
EXEC AddPriceInfo @ConferenceDayID = 161, @InitialDate = '2015-05-11', @Price = 6880, @StudentDiscount = 0.144
EXEC AddPriceInfo @ConferenceDayID = 161, @InitialDate = '2015-11-11', @Price = 8600.0, @StudentDiscount = 0.144
EXEC AddPriceInfo @ConferenceDayID = 161, @InitialDate = '2015-12-11', @Price = 12040.0, @StudentDiscount = 0.144
EXEC AddPriceInfo @ConferenceDayID = 162, @InitialDate = '2021-01-25', @Price = 10200, @StudentDiscount = 0.078
EXEC AddPriceInfo @ConferenceDayID = 162, @InitialDate = '2021-08-19', @Price = 12750.0, @StudentDiscount = 0.078
EXEC AddPriceInfo @ConferenceDayID = 162, @InitialDate = '2021-09-19', @Price = 17850.0, @StudentDiscount = 0.078
EXEC AddPriceInfo @ConferenceDayID = 163, @InitialDate = '2021-03-24', @Price = 11490, @StudentDiscount = 0.108
EXEC AddPriceInfo @ConferenceDayID = 163, @InitialDate = '2021-08-20', @Price = 14362.5, @StudentDiscount = 0.108
EXEC AddPriceInfo @ConferenceDayID = 163, @InitialDate = '2021-09-20', @Price = 20107.5, @StudentDiscount = 0.108
EXEC AddPriceInfo @ConferenceDayID = 164, @InitialDate = '2021-01-05', @Price = 3680, @StudentDiscount = 0.194
EXEC AddPriceInfo @ConferenceDayID = 164, @InitialDate = '2021-08-21', @Price = 4600.0, @StudentDiscount = 0.194
EXEC AddPriceInfo @ConferenceDayID = 164, @InitialDate = '2021-09-21', @Price = 6440.0, @StudentDiscount = 0.194
EXEC AddPriceInfo @ConferenceDayID = 165, @InitialDate = '2020-12-23', @Price = 14110, @StudentDiscount = 0.289
EXEC AddPriceInfo @ConferenceDayID = 165, @InitialDate = '2021-08-22', @Price = 17637.5, @StudentDiscount = 0.289
EXEC AddPriceInfo @ConferenceDayID = 165, @InitialDate = '2021-09-22', @Price = 24692.5, @StudentDiscount = 0.289
EXEC AddPriceInfo @ConferenceDayID = 166, @InitialDate = '2021-02-14', @Price = 3460, @StudentDiscount = 0.263
EXEC AddPriceInfo @ConferenceDayID = 166, @InitialDate = '2021-08-23', @Price = 4325.0, @StudentDiscount = 0.263
EXEC AddPriceInfo @ConferenceDayID = 166, @InitialDate = '2021-09-23', @Price = 6055.0, @StudentDiscount = 0.263
EXEC AddPriceInfo @ConferenceDayID = 167, @InitialDate = '2021-02-10', @Price = 7730, @StudentDiscount = 0.381
EXEC AddPriceInfo @ConferenceDayID = 167, @InitialDate = '2021-08-24', @Price = 9662.5, @StudentDiscount = 0.381
EXEC AddPriceInfo @ConferenceDayID = 167, @InitialDate = '2021-09-24', @Price = 13527.5, @StudentDiscount = 0.381
EXEC AddPriceInfo @ConferenceDayID = 168, @InitialDate = '2020-12-17', @Price = 6670, @StudentDiscount = 0.012
EXEC AddPriceInfo @ConferenceDayID = 168, @InitialDate = '2021-08-25', @Price = 8337.5, @StudentDiscount = 0.012
EXEC AddPriceInfo @ConferenceDayID = 168, @InitialDate = '2021-09-25', @Price = 11672.5, @StudentDiscount = 0.012
EXEC AddPriceInfo @ConferenceDayID = 169, @InitialDate = '2019-08-14', @Price = 12790, @StudentDiscount = 0.432
EXEC AddPriceInfo @ConferenceDayID = 169, @InitialDate = '2019-12-06', @Price = 15987.5, @StudentDiscount = 0.432
EXEC AddPriceInfo @ConferenceDayID = 169, @InitialDate = '2020-01-06', @Price = 22382.5, @StudentDiscount = 0.432
EXEC AddPriceInfo @ConferenceDayID = 170, @InitialDate = '2019-07-22', @Price = 7710, @StudentDiscount = 0.044
EXEC AddPriceInfo @ConferenceDayID = 170, @InitialDate = '2019-12-07', @Price = 9637.5, @StudentDiscount = 0.044
EXEC AddPriceInfo @ConferenceDayID = 170, @InitialDate = '2020-01-07', @Price = 13492.5, @StudentDiscount = 0.044
EXEC AddPriceInfo @ConferenceDayID = 171, @InitialDate = '2019-05-28', @Price = 3470, @StudentDiscount = 0.248
EXEC AddPriceInfo @ConferenceDayID = 171, @InitialDate = '2019-12-08', @Price = 4337.5, @StudentDiscount = 0.248
EXEC AddPriceInfo @ConferenceDayID = 171, @InitialDate = '2020-01-08', @Price = 6072.5, @StudentDiscount = 0.248
EXEC AddPriceInfo @ConferenceDayID = 172, @InitialDate = '2015-08-02', @Price = 8740, @StudentDiscount = 0.403
EXEC AddPriceInfo @ConferenceDayID = 172, @InitialDate = '2016-01-02', @Price = 10925.0, @StudentDiscount = 0.403
EXEC AddPriceInfo @ConferenceDayID = 172, @InitialDate = '2016-02-02', @Price = 15295.0, @StudentDiscount = 0.403
EXEC AddPriceInfo @ConferenceDayID = 173, @InitialDate = '2015-08-22', @Price = 4790, @StudentDiscount = 0.494
EXEC AddPriceInfo @ConferenceDayID = 173, @InitialDate = '2016-01-03', @Price = 5987.5, @StudentDiscount = 0.494
EXEC AddPriceInfo @ConferenceDayID = 173, @InitialDate = '2016-02-03', @Price = 8382.5, @StudentDiscount = 0.494
EXEC AddPriceInfo @ConferenceDayID = 174, @InitialDate = '2015-09-11', @Price = 13090, @StudentDiscount = 0.435
EXEC AddPriceInfo @ConferenceDayID = 174, @InitialDate = '2016-01-04', @Price = 16362.5, @StudentDiscount = 0.435
EXEC AddPriceInfo @ConferenceDayID = 174, @InitialDate = '2016-02-04', @Price = 22907.5, @StudentDiscount = 0.435
EXEC AddPriceInfo @ConferenceDayID = 175, @InitialDate = '2015-08-13', @Price = 7280, @StudentDiscount = 0.313
EXEC AddPriceInfo @ConferenceDayID = 175, @InitialDate = '2016-01-05', @Price = 9100.0, @StudentDiscount = 0.313
EXEC AddPriceInfo @ConferenceDayID = 175, @InitialDate = '2016-02-05', @Price = 12740.0, @StudentDiscount = 0.313
EXEC AddPriceInfo @ConferenceDayID = 176, @InitialDate = '2015-06-20', @Price = 9210, @StudentDiscount = 0.028
EXEC AddPriceInfo @ConferenceDayID = 176, @InitialDate = '2016-01-06', @Price = 11512.5, @StudentDiscount = 0.028
EXEC AddPriceInfo @ConferenceDayID = 176, @InitialDate = '2016-02-06', @Price = 16117.5, @StudentDiscount = 0.028
EXEC AddPriceInfo @ConferenceDayID = 177, @InitialDate = '2016-03-06', @Price = 14140, @StudentDiscount = 0.224
EXEC AddPriceInfo @ConferenceDayID = 177, @InitialDate = '2016-09-03', @Price = 17675.0, @StudentDiscount = 0.224
EXEC AddPriceInfo @ConferenceDayID = 177, @InitialDate = '2016-10-03', @Price = 24745.0, @StudentDiscount = 0.224
EXEC AddPriceInfo @ConferenceDayID = 178, @InitialDate = '2016-01-01', @Price = 4640, @StudentDiscount = 0.389
EXEC AddPriceInfo @ConferenceDayID = 178, @InitialDate = '2016-09-04', @Price = 5800.0, @StudentDiscount = 0.389
EXEC AddPriceInfo @ConferenceDayID = 178, @InitialDate = '2016-10-04', @Price = 8120.0, @StudentDiscount = 0.389
EXEC AddPriceInfo @ConferenceDayID = 179, @InitialDate = '2016-02-19', @Price = 6890, @StudentDiscount = 0.032
EXEC AddPriceInfo @ConferenceDayID = 179, @InitialDate = '2016-09-05', @Price = 8612.5, @StudentDiscount = 0.032
EXEC AddPriceInfo @ConferenceDayID = 179, @InitialDate = '2016-10-05', @Price = 12057.5, @StudentDiscount = 0.032
EXEC AddPriceInfo @ConferenceDayID = 180, @InitialDate = '2016-04-22', @Price = 10900, @StudentDiscount = 0.443
EXEC AddPriceInfo @ConferenceDayID = 180, @InitialDate = '2016-09-06', @Price = 13625.0, @StudentDiscount = 0.443
EXEC AddPriceInfo @ConferenceDayID = 180, @InitialDate = '2016-10-06', @Price = 19075.0, @StudentDiscount = 0.443
EXEC AddPriceInfo @ConferenceDayID = 181, @InitialDate = '2016-05-23', @Price = 13600, @StudentDiscount = 0.171
EXEC AddPriceInfo @ConferenceDayID = 181, @InitialDate = '2016-09-07', @Price = 17000.0, @StudentDiscount = 0.171
EXEC AddPriceInfo @ConferenceDayID = 181, @InitialDate = '2016-10-07', @Price = 23800.0, @StudentDiscount = 0.171
EXEC AddPriceInfo @ConferenceDayID = 182, @InitialDate = '2018-09-13', @Price = 11780, @StudentDiscount = 0.319
EXEC AddPriceInfo @ConferenceDayID = 182, @InitialDate = '2019-02-19', @Price = 14725.0, @StudentDiscount = 0.319
EXEC AddPriceInfo @ConferenceDayID = 182, @InitialDate = '2019-03-19', @Price = 20615.0, @StudentDiscount = 0.319
EXEC AddPriceInfo @ConferenceDayID = 183, @InitialDate = '2018-08-28', @Price = 6120, @StudentDiscount = 0.214
EXEC AddPriceInfo @ConferenceDayID = 183, @InitialDate = '2019-02-20', @Price = 7650.0, @StudentDiscount = 0.214
EXEC AddPriceInfo @ConferenceDayID = 183, @InitialDate = '2019-03-20', @Price = 10710.0, @StudentDiscount = 0.214
EXEC AddPriceInfo @ConferenceDayID = 184, @InitialDate = '2018-10-05', @Price = 6580, @StudentDiscount = 0.311
EXEC AddPriceInfo @ConferenceDayID = 184, @InitialDate = '2019-02-21', @Price = 8225.0, @StudentDiscount = 0.311
EXEC AddPriceInfo @ConferenceDayID = 184, @InitialDate = '2019-03-21', @Price = 11515.0, @StudentDiscount = 0.311
EXEC AddPriceInfo @ConferenceDayID = 185, @InitialDate = '2018-09-21', @Price = 13150, @StudentDiscount = 0.463
EXEC AddPriceInfo @ConferenceDayID = 185, @InitialDate = '2019-02-22', @Price = 16437.5, @StudentDiscount = 0.463
EXEC AddPriceInfo @ConferenceDayID = 185, @InitialDate = '2019-03-22', @Price = 23012.5, @StudentDiscount = 0.463
EXEC AddPriceInfo @ConferenceDayID = 186, @InitialDate = '2021-01-04', @Price = 9370, @StudentDiscount = 0.439
EXEC AddPriceInfo @ConferenceDayID = 186, @InitialDate = '2021-06-19', @Price = 11712.5, @StudentDiscount = 0.439
EXEC AddPriceInfo @ConferenceDayID = 186, @InitialDate = '2021-07-19', @Price = 16397.5, @StudentDiscount = 0.439
EXEC AddPriceInfo @ConferenceDayID = 187, @InitialDate = '2020-10-26', @Price = 5460, @StudentDiscount = 0.237
EXEC AddPriceInfo @ConferenceDayID = 187, @InitialDate = '2021-06-20', @Price = 6825.0, @StudentDiscount = 0.237
EXEC AddPriceInfo @ConferenceDayID = 187, @InitialDate = '2021-07-20', @Price = 9555.0, @StudentDiscount = 0.237
EXEC AddPriceInfo @ConferenceDayID = 188, @InitialDate = '2020-11-02', @Price = 10000, @StudentDiscount = 0.292
EXEC AddPriceInfo @ConferenceDayID = 188, @InitialDate = '2021-06-21', @Price = 12500.0, @StudentDiscount = 0.292
EXEC AddPriceInfo @ConferenceDayID = 188, @InitialDate = '2021-07-21', @Price = 17500.0, @StudentDiscount = 0.292
EXEC AddPriceInfo @ConferenceDayID = 189, @InitialDate = '2021-02-21', @Price = 9060, @StudentDiscount = 0.298
EXEC AddPriceInfo @ConferenceDayID = 189, @InitialDate = '2021-06-22', @Price = 11325.0, @StudentDiscount = 0.298
EXEC AddPriceInfo @ConferenceDayID = 189, @InitialDate = '2021-07-22', @Price = 15855.0, @StudentDiscount = 0.298
EXEC AddPriceInfo @ConferenceDayID = 190, @InitialDate = '2018-01-07', @Price = 6440, @StudentDiscount = 0.405
EXEC AddPriceInfo @ConferenceDayID = 190, @InitialDate = '2018-05-15', @Price = 8050.0, @StudentDiscount = 0.405
EXEC AddPriceInfo @ConferenceDayID = 190, @InitialDate = '2018-06-15', @Price = 11270.0, @StudentDiscount = 0.405
EXEC AddPriceInfo @ConferenceDayID = 191, @InitialDate = '2017-11-24', @Price = 3540, @StudentDiscount = 0.418
EXEC AddPriceInfo @ConferenceDayID = 191, @InitialDate = '2018-05-16', @Price = 4425.0, @StudentDiscount = 0.418
EXEC AddPriceInfo @ConferenceDayID = 191, @InitialDate = '2018-06-16', @Price = 6195.0, @StudentDiscount = 0.418
EXEC AddPriceInfo @ConferenceDayID = 192, @InitialDate = '2017-11-06', @Price = 10630, @StudentDiscount = 0.068
EXEC AddPriceInfo @ConferenceDayID = 192, @InitialDate = '2018-05-17', @Price = 13287.5, @StudentDiscount = 0.068
EXEC AddPriceInfo @ConferenceDayID = 192, @InitialDate = '2018-06-17', @Price = 18602.5, @StudentDiscount = 0.068
EXEC AddPriceInfo @ConferenceDayID = 193, @InitialDate = '2018-01-11', @Price = 5100, @StudentDiscount = 0.105
EXEC AddPriceInfo @ConferenceDayID = 193, @InitialDate = '2018-05-18', @Price = 6375.0, @StudentDiscount = 0.105
EXEC AddPriceInfo @ConferenceDayID = 193, @InitialDate = '2018-06-18', @Price = 8925.0, @StudentDiscount = 0.105
EXEC AddPriceInfo @ConferenceDayID = 194, @InitialDate = '2017-09-12', @Price = 3160, @StudentDiscount = 0.286
EXEC AddPriceInfo @ConferenceDayID = 194, @InitialDate = '2018-05-19', @Price = 3950.0, @StudentDiscount = 0.286
EXEC AddPriceInfo @ConferenceDayID = 194, @InitialDate = '2018-06-19', @Price = 5530.0, @StudentDiscount = 0.286
EXEC AddPriceInfo @ConferenceDayID = 195, @InitialDate = '2020-11-25', @Price = 8880, @StudentDiscount = 0.364
EXEC AddPriceInfo @ConferenceDayID = 195, @InitialDate = '2021-03-07', @Price = 11100.0, @StudentDiscount = 0.364
EXEC AddPriceInfo @ConferenceDayID = 195, @InitialDate = '2021-04-07', @Price = 15540.0, @StudentDiscount = 0.364
EXEC AddPriceInfo @ConferenceDayID = 196, @InitialDate = '2020-11-22', @Price = 7980, @StudentDiscount = 0.381
EXEC AddPriceInfo @ConferenceDayID = 196, @InitialDate = '2021-03-08', @Price = 9975.0, @StudentDiscount = 0.381
EXEC AddPriceInfo @ConferenceDayID = 196, @InitialDate = '2021-04-08', @Price = 13965.0, @StudentDiscount = 0.381
EXEC AddPriceInfo @ConferenceDayID = 197, @InitialDate = '2020-11-26', @Price = 9240, @StudentDiscount = 0.159
EXEC AddPriceInfo @ConferenceDayID = 197, @InitialDate = '2021-03-09', @Price = 11550.0, @StudentDiscount = 0.159
EXEC AddPriceInfo @ConferenceDayID = 197, @InitialDate = '2021-04-09', @Price = 16170.0, @StudentDiscount = 0.159
EXEC AddPriceInfo @ConferenceDayID = 198, @InitialDate = '2020-10-24', @Price = 15940, @StudentDiscount = 0.493
EXEC AddPriceInfo @ConferenceDayID = 198, @InitialDate = '2021-03-10', @Price = 19925.0, @StudentDiscount = 0.493
EXEC AddPriceInfo @ConferenceDayID = 198, @InitialDate = '2021-04-10', @Price = 27895.0, @StudentDiscount = 0.493
EXEC AddPriceInfo @ConferenceDayID = 199, @InitialDate = '2020-11-09', @Price = 12260, @StudentDiscount = 0.245
EXEC AddPriceInfo @ConferenceDayID = 199, @InitialDate = '2021-03-11', @Price = 15325.0, @StudentDiscount = 0.245
EXEC AddPriceInfo @ConferenceDayID = 199, @InitialDate = '2021-04-11', @Price = 21455.0, @StudentDiscount = 0.245
EXEC AddPriceInfo @ConferenceDayID = 200, @InitialDate = '2020-11-03', @Price = 2580, @StudentDiscount = 0.399
EXEC AddPriceInfo @ConferenceDayID = 200, @InitialDate = '2021-06-11', @Price = 3225.0, @StudentDiscount = 0.399
EXEC AddPriceInfo @ConferenceDayID = 200, @InitialDate = '2021-07-11', @Price = 4515.0, @StudentDiscount = 0.399
EXEC AddPriceInfo @ConferenceDayID = 201, @InitialDate = '2021-01-05', @Price = 9230, @StudentDiscount = 0.474
EXEC AddPriceInfo @ConferenceDayID = 201, @InitialDate = '2021-06-12', @Price = 11537.5, @StudentDiscount = 0.474
EXEC AddPriceInfo @ConferenceDayID = 201, @InitialDate = '2021-07-12', @Price = 16152.5, @StudentDiscount = 0.474
EXEC AddPriceInfo @ConferenceDayID = 202, @InitialDate = '2020-10-10', @Price = 7620, @StudentDiscount = 0.395
EXEC AddPriceInfo @ConferenceDayID = 202, @InitialDate = '2021-06-13', @Price = 9525.0, @StudentDiscount = 0.395
EXEC AddPriceInfo @ConferenceDayID = 202, @InitialDate = '2021-07-13', @Price = 13335.0, @StudentDiscount = 0.395
EXEC AddPriceInfo @ConferenceDayID = 203, @InitialDate = '2021-02-15', @Price = 11950, @StudentDiscount = 0.156
EXEC AddPriceInfo @ConferenceDayID = 203, @InitialDate = '2021-06-14', @Price = 14937.5, @StudentDiscount = 0.156
EXEC AddPriceInfo @ConferenceDayID = 203, @InitialDate = '2021-07-14', @Price = 20912.5, @StudentDiscount = 0.156
EXEC AddPriceInfo @ConferenceDayID = 204, @InitialDate = '2020-12-15', @Price = 15720, @StudentDiscount = 0.351
EXEC AddPriceInfo @ConferenceDayID = 204, @InitialDate = '2021-06-15', @Price = 19650.0, @StudentDiscount = 0.351
EXEC AddPriceInfo @ConferenceDayID = 204, @InitialDate = '2021-07-15', @Price = 27510.0, @StudentDiscount = 0.351
EXEC AddPriceInfo @ConferenceDayID = 205, @InitialDate = '2020-12-19', @Price = 16300, @StudentDiscount = 0.086
EXEC AddPriceInfo @ConferenceDayID = 205, @InitialDate = '2021-06-16', @Price = 20375.0, @StudentDiscount = 0.086
EXEC AddPriceInfo @ConferenceDayID = 205, @InitialDate = '2021-07-16', @Price = 28525.0, @StudentDiscount = 0.086
EXEC AddPriceInfo @ConferenceDayID = 206, @InitialDate = '2016-04-15', @Price = 9530, @StudentDiscount = 0.222
EXEC AddPriceInfo @ConferenceDayID = 206, @InitialDate = '2016-10-04', @Price = 11912.5, @StudentDiscount = 0.222
EXEC AddPriceInfo @ConferenceDayID = 206, @InitialDate = '2016-11-04', @Price = 16677.5, @StudentDiscount = 0.222
EXEC AddPriceInfo @ConferenceDayID = 207, @InitialDate = '2016-03-01', @Price = 5310, @StudentDiscount = 0.339
EXEC AddPriceInfo @ConferenceDayID = 207, @InitialDate = '2016-10-05', @Price = 6637.5, @StudentDiscount = 0.339
EXEC AddPriceInfo @ConferenceDayID = 207, @InitialDate = '2016-11-05', @Price = 9292.5, @StudentDiscount = 0.339
EXEC AddPriceInfo @ConferenceDayID = 208, @InitialDate = '2016-02-14', @Price = 7940, @StudentDiscount = 0.249
EXEC AddPriceInfo @ConferenceDayID = 208, @InitialDate = '2016-10-06', @Price = 9925.0, @StudentDiscount = 0.249
EXEC AddPriceInfo @ConferenceDayID = 208, @InitialDate = '2016-11-06', @Price = 13895.0, @StudentDiscount = 0.249
EXEC AddPriceInfo @ConferenceDayID = 209, @InitialDate = '2016-05-11', @Price = 15600, @StudentDiscount = 0.296
EXEC AddPriceInfo @ConferenceDayID = 209, @InitialDate = '2016-10-07', @Price = 19500.0, @StudentDiscount = 0.296
EXEC AddPriceInfo @ConferenceDayID = 209, @InitialDate = '2016-11-07', @Price = 27300.0, @StudentDiscount = 0.296
EXEC AddPriceInfo @ConferenceDayID = 210, @InitialDate = '2016-06-20', @Price = 8200, @StudentDiscount = 0.443
EXEC AddPriceInfo @ConferenceDayID = 210, @InitialDate = '2016-10-08', @Price = 10250.0, @StudentDiscount = 0.443
EXEC AddPriceInfo @ConferenceDayID = 210, @InitialDate = '2016-11-08', @Price = 14350.0, @StudentDiscount = 0.443
EXEC AddPriceInfo @ConferenceDayID = 211, @InitialDate = '2016-01-06', @Price = 15220, @StudentDiscount = 0.430
EXEC AddPriceInfo @ConferenceDayID = 211, @InitialDate = '2016-06-11', @Price = 19025.0, @StudentDiscount = 0.430
EXEC AddPriceInfo @ConferenceDayID = 211, @InitialDate = '2016-07-11', @Price = 26635.0, @StudentDiscount = 0.430
EXEC AddPriceInfo @ConferenceDayID = 212, @InitialDate = '2016-01-05', @Price = 4800, @StudentDiscount = 0.124
EXEC AddPriceInfo @ConferenceDayID = 212, @InitialDate = '2016-06-12', @Price = 6000.0, @StudentDiscount = 0.124
EXEC AddPriceInfo @ConferenceDayID = 212, @InitialDate = '2016-07-12', @Price = 8400.0, @StudentDiscount = 0.124
EXEC AddPriceInfo @ConferenceDayID = 213, @InitialDate = '2015-10-22', @Price = 4360, @StudentDiscount = 0.161
EXEC AddPriceInfo @ConferenceDayID = 213, @InitialDate = '2016-06-13', @Price = 5450.0, @StudentDiscount = 0.161
EXEC AddPriceInfo @ConferenceDayID = 213, @InitialDate = '2016-07-13', @Price = 7630.0, @StudentDiscount = 0.161
EXEC AddPriceInfo @ConferenceDayID = 214, @InitialDate = '2015-10-13', @Price = 15640, @StudentDiscount = 0.135
EXEC AddPriceInfo @ConferenceDayID = 214, @InitialDate = '2016-06-14', @Price = 19550.0, @StudentDiscount = 0.135
EXEC AddPriceInfo @ConferenceDayID = 214, @InitialDate = '2016-07-14', @Price = 27370.0, @StudentDiscount = 0.135
EXEC AddPriceInfo @ConferenceDayID = 215, @InitialDate = '2015-12-14', @Price = 6330, @StudentDiscount = 0.270
EXEC AddPriceInfo @ConferenceDayID = 215, @InitialDate = '2016-06-15', @Price = 7912.5, @StudentDiscount = 0.270
EXEC AddPriceInfo @ConferenceDayID = 215, @InitialDate = '2016-07-15', @Price = 11077.5, @StudentDiscount = 0.270
EXEC AddPriceInfo @ConferenceDayID = 216, @InitialDate = '2015-10-09', @Price = 12770, @StudentDiscount = 0.208
EXEC AddPriceInfo @ConferenceDayID = 216, @InitialDate = '2016-06-16', @Price = 15962.5, @StudentDiscount = 0.208
EXEC AddPriceInfo @ConferenceDayID = 216, @InitialDate = '2016-07-16', @Price = 22347.5, @StudentDiscount = 0.208
EXEC AddPriceInfo @ConferenceDayID = 217, @InitialDate = '2015-07-24', @Price = 14340, @StudentDiscount = 0.385
EXEC AddPriceInfo @ConferenceDayID = 217, @InitialDate = '2016-02-16', @Price = 17925.0, @StudentDiscount = 0.385
EXEC AddPriceInfo @ConferenceDayID = 217, @InitialDate = '2016-03-16', @Price = 25095.0, @StudentDiscount = 0.385
EXEC AddPriceInfo @ConferenceDayID = 218, @InitialDate = '2015-06-12', @Price = 13400, @StudentDiscount = 0.400
EXEC AddPriceInfo @ConferenceDayID = 218, @InitialDate = '2016-02-17', @Price = 16750.0, @StudentDiscount = 0.400
EXEC AddPriceInfo @ConferenceDayID = 218, @InitialDate = '2016-03-17', @Price = 23450.0, @StudentDiscount = 0.400
EXEC AddPriceInfo @ConferenceDayID = 219, @InitialDate = '2015-09-19', @Price = 14800, @StudentDiscount = 0.030
EXEC AddPriceInfo @ConferenceDayID = 219, @InitialDate = '2016-02-18', @Price = 18500.0, @StudentDiscount = 0.030
EXEC AddPriceInfo @ConferenceDayID = 219, @InitialDate = '2016-03-18', @Price = 25900.0, @StudentDiscount = 0.030
EXEC AddPriceInfo @ConferenceDayID = 220, @InitialDate = '2015-07-27', @Price = 9940, @StudentDiscount = 0.466
EXEC AddPriceInfo @ConferenceDayID = 220, @InitialDate = '2016-02-19', @Price = 12425.0, @StudentDiscount = 0.466
EXEC AddPriceInfo @ConferenceDayID = 220, @InitialDate = '2016-03-19', @Price = 17395.0, @StudentDiscount = 0.466
EXEC AddPriceInfo @ConferenceDayID = 221, @InitialDate = '2016-11-16', @Price = 16140, @StudentDiscount = 0.118
EXEC AddPriceInfo @ConferenceDayID = 221, @InitialDate = '2017-05-20', @Price = 20175.0, @StudentDiscount = 0.118
EXEC AddPriceInfo @ConferenceDayID = 221, @InitialDate = '2017-06-20', @Price = 28245.0, @StudentDiscount = 0.118
EXEC AddPriceInfo @ConferenceDayID = 222, @InitialDate = '2016-12-23', @Price = 3910, @StudentDiscount = 0.086
EXEC AddPriceInfo @ConferenceDayID = 222, @InitialDate = '2017-05-21', @Price = 4887.5, @StudentDiscount = 0.086
EXEC AddPriceInfo @ConferenceDayID = 222, @InitialDate = '2017-06-21', @Price = 6842.5, @StudentDiscount = 0.086
EXEC AddPriceInfo @ConferenceDayID = 223, @InitialDate = '2016-09-14', @Price = 13680, @StudentDiscount = 0.104
EXEC AddPriceInfo @ConferenceDayID = 223, @InitialDate = '2017-05-22', @Price = 17100.0, @StudentDiscount = 0.104
EXEC AddPriceInfo @ConferenceDayID = 223, @InitialDate = '2017-06-22', @Price = 23940.0, @StudentDiscount = 0.104
EXEC AddPriceInfo @ConferenceDayID = 224, @InitialDate = '2019-06-23', @Price = 11250, @StudentDiscount = 0.319
EXEC AddPriceInfo @ConferenceDayID = 224, @InitialDate = '2020-02-17', @Price = 14062.5, @StudentDiscount = 0.319
EXEC AddPriceInfo @ConferenceDayID = 224, @InitialDate = '2020-03-17', @Price = 19687.5, @StudentDiscount = 0.319
EXEC AddPriceInfo @ConferenceDayID = 225, @InitialDate = '2019-07-01', @Price = 2930, @StudentDiscount = 0.070
EXEC AddPriceInfo @ConferenceDayID = 225, @InitialDate = '2020-02-18', @Price = 3662.5, @StudentDiscount = 0.070
EXEC AddPriceInfo @ConferenceDayID = 225, @InitialDate = '2020-03-18', @Price = 5127.5, @StudentDiscount = 0.070
EXEC AddPriceInfo @ConferenceDayID = 226, @InitialDate = '2019-08-20', @Price = 9560, @StudentDiscount = 0.060
EXEC AddPriceInfo @ConferenceDayID = 226, @InitialDate = '2020-02-19', @Price = 11950.0, @StudentDiscount = 0.060
EXEC AddPriceInfo @ConferenceDayID = 226, @InitialDate = '2020-03-19', @Price = 16730.0, @StudentDiscount = 0.060
EXEC AddPriceInfo @ConferenceDayID = 227, @InitialDate = '2019-08-23', @Price = 8540, @StudentDiscount = 0.203
EXEC AddPriceInfo @ConferenceDayID = 227, @InitialDate = '2020-02-20', @Price = 10675.0, @StudentDiscount = 0.203
EXEC AddPriceInfo @ConferenceDayID = 227, @InitialDate = '2020-03-20', @Price = 14945.0, @StudentDiscount = 0.203
EXEC AddPriceInfo @ConferenceDayID = 228, @InitialDate = '2019-08-27', @Price = 5540, @StudentDiscount = 0.139
EXEC AddPriceInfo @ConferenceDayID = 228, @InitialDate = '2020-02-21', @Price = 6925.0, @StudentDiscount = 0.139
EXEC AddPriceInfo @ConferenceDayID = 228, @InitialDate = '2020-03-21', @Price = 9695.0, @StudentDiscount = 0.139
EXEC AddPriceInfo @ConferenceDayID = 229, @InitialDate = '2019-08-24', @Price = 10160, @StudentDiscount = 0.105
EXEC AddPriceInfo @ConferenceDayID = 229, @InitialDate = '2020-02-22', @Price = 12700.0, @StudentDiscount = 0.105
EXEC AddPriceInfo @ConferenceDayID = 229, @InitialDate = '2020-03-22', @Price = 17780.0, @StudentDiscount = 0.105
EXEC AddPriceInfo @ConferenceDayID = 230, @InitialDate = '2019-09-26', @Price = 9970, @StudentDiscount = 0.310
EXEC AddPriceInfo @ConferenceDayID = 230, @InitialDate = '2020-02-23', @Price = 12462.5, @StudentDiscount = 0.310
EXEC AddPriceInfo @ConferenceDayID = 230, @InitialDate = '2020-03-23', @Price = 17447.5, @StudentDiscount = 0.310
EXEC AddPriceInfo @ConferenceDayID = 231, @InitialDate = '2018-07-19', @Price = 4870, @StudentDiscount = 0.246
EXEC AddPriceInfo @ConferenceDayID = 231, @InitialDate = '2018-11-11', @Price = 6087.5, @StudentDiscount = 0.246
EXEC AddPriceInfo @ConferenceDayID = 231, @InitialDate = '2018-12-11', @Price = 8522.5, @StudentDiscount = 0.246
EXEC AddPriceInfo @ConferenceDayID = 232, @InitialDate = '2018-03-23', @Price = 5440, @StudentDiscount = 0.252
EXEC AddPriceInfo @ConferenceDayID = 232, @InitialDate = '2018-11-12', @Price = 6800.0, @StudentDiscount = 0.252
EXEC AddPriceInfo @ConferenceDayID = 232, @InitialDate = '2018-12-12', @Price = 9520.0, @StudentDiscount = 0.252
EXEC AddPriceInfo @ConferenceDayID = 233, @InitialDate = '2018-03-18', @Price = 9550, @StudentDiscount = 0.437
EXEC AddPriceInfo @ConferenceDayID = 233, @InitialDate = '2018-11-13', @Price = 11937.5, @StudentDiscount = 0.437
EXEC AddPriceInfo @ConferenceDayID = 233, @InitialDate = '2018-12-13', @Price = 16712.5, @StudentDiscount = 0.437
EXEC AddPriceInfo @ConferenceDayID = 234, @InitialDate = '2016-03-15', @Price = 15850, @StudentDiscount = 0.386
EXEC AddPriceInfo @ConferenceDayID = 234, @InitialDate = '2016-09-04', @Price = 19812.5, @StudentDiscount = 0.386
EXEC AddPriceInfo @ConferenceDayID = 234, @InitialDate = '2016-10-04', @Price = 27737.5, @StudentDiscount = 0.386
EXEC AddPriceInfo @ConferenceDayID = 235, @InitialDate = '2016-04-16', @Price = 12910, @StudentDiscount = 0.475
EXEC AddPriceInfo @ConferenceDayID = 235, @InitialDate = '2016-09-05', @Price = 16137.5, @StudentDiscount = 0.475
EXEC AddPriceInfo @ConferenceDayID = 235, @InitialDate = '2016-10-05', @Price = 22592.5, @StudentDiscount = 0.475
EXEC AddPriceInfo @ConferenceDayID = 236, @InitialDate = '2016-05-18', @Price = 7430, @StudentDiscount = 0.014
EXEC AddPriceInfo @ConferenceDayID = 236, @InitialDate = '2016-09-06', @Price = 9287.5, @StudentDiscount = 0.014
EXEC AddPriceInfo @ConferenceDayID = 236, @InitialDate = '2016-10-06', @Price = 13002.5, @StudentDiscount = 0.014
EXEC AddPriceInfo @ConferenceDayID = 237, @InitialDate = '2016-02-28', @Price = 9650, @StudentDiscount = 0.426
EXEC AddPriceInfo @ConferenceDayID = 237, @InitialDate = '2016-09-07', @Price = 12062.5, @StudentDiscount = 0.426
EXEC AddPriceInfo @ConferenceDayID = 237, @InitialDate = '2016-10-07', @Price = 16887.5, @StudentDiscount = 0.426
EXEC AddPriceInfo @ConferenceDayID = 238, @InitialDate = '2016-04-03', @Price = 4690, @StudentDiscount = 0.210
EXEC AddPriceInfo @ConferenceDayID = 238, @InitialDate = '2016-09-08', @Price = 5862.5, @StudentDiscount = 0.210
EXEC AddPriceInfo @ConferenceDayID = 238, @InitialDate = '2016-10-08', @Price = 8207.5, @StudentDiscount = 0.210
EXEC AddPriceInfo @ConferenceDayID = 239, @InitialDate = '2016-01-08', @Price = 15620, @StudentDiscount = 0.190
EXEC AddPriceInfo @ConferenceDayID = 239, @InitialDate = '2016-09-09', @Price = 19525.0, @StudentDiscount = 0.190
EXEC AddPriceInfo @ConferenceDayID = 239, @InitialDate = '2016-10-09', @Price = 27335.0, @StudentDiscount = 0.190
EXEC AddPriceInfo @ConferenceDayID = 240, @InitialDate = '2016-02-09', @Price = 10510, @StudentDiscount = 0.183
EXEC AddPriceInfo @ConferenceDayID = 240, @InitialDate = '2016-09-10', @Price = 13137.5, @StudentDiscount = 0.183
EXEC AddPriceInfo @ConferenceDayID = 240, @InitialDate = '2016-10-10', @Price = 18392.5, @StudentDiscount = 0.183
EXEC AddPriceInfo @ConferenceDayID = 241, @InitialDate = '2020-02-21', @Price = 14340, @StudentDiscount = 0.119
EXEC AddPriceInfo @ConferenceDayID = 241, @InitialDate = '2020-09-08', @Price = 17925.0, @StudentDiscount = 0.119
EXEC AddPriceInfo @ConferenceDayID = 241, @InitialDate = '2020-10-08', @Price = 25095.0, @StudentDiscount = 0.119
EXEC AddPriceInfo @ConferenceDayID = 242, @InitialDate = '2020-04-17', @Price = 7890, @StudentDiscount = 0.048
EXEC AddPriceInfo @ConferenceDayID = 242, @InitialDate = '2020-09-09', @Price = 9862.5, @StudentDiscount = 0.048
EXEC AddPriceInfo @ConferenceDayID = 242, @InitialDate = '2020-10-09', @Price = 13807.5, @StudentDiscount = 0.048
EXEC AddPriceInfo @ConferenceDayID = 243, @InitialDate = '2020-02-01', @Price = 8830, @StudentDiscount = 0.194
EXEC AddPriceInfo @ConferenceDayID = 243, @InitialDate = '2020-09-10', @Price = 11037.5, @StudentDiscount = 0.194
EXEC AddPriceInfo @ConferenceDayID = 243, @InitialDate = '2020-10-10', @Price = 15452.5, @StudentDiscount = 0.194
EXEC AddPriceInfo @ConferenceDayID = 244, @InitialDate = '2020-04-06', @Price = 14790, @StudentDiscount = 0.010
EXEC AddPriceInfo @ConferenceDayID = 244, @InitialDate = '2020-09-11', @Price = 18487.5, @StudentDiscount = 0.010
EXEC AddPriceInfo @ConferenceDayID = 244, @InitialDate = '2020-10-11', @Price = 25882.5, @StudentDiscount = 0.010
EXEC AddPriceInfo @ConferenceDayID = 245, @InitialDate = '2020-01-16', @Price = 12740, @StudentDiscount = 0.132
EXEC AddPriceInfo @ConferenceDayID = 245, @InitialDate = '2020-09-12', @Price = 15925.0, @StudentDiscount = 0.132
EXEC AddPriceInfo @ConferenceDayID = 245, @InitialDate = '2020-10-12', @Price = 22295.0, @StudentDiscount = 0.132
EXEC AddPriceInfo @ConferenceDayID = 246, @InitialDate = '2020-04-08', @Price = 10590, @StudentDiscount = 0.489
EXEC AddPriceInfo @ConferenceDayID = 246, @InitialDate = '2020-09-13', @Price = 13237.5, @StudentDiscount = 0.489
EXEC AddPriceInfo @ConferenceDayID = 246, @InitialDate = '2020-10-13', @Price = 18532.5, @StudentDiscount = 0.489
EXEC AddPriceInfo @ConferenceDayID = 247, @InitialDate = '2020-03-07', @Price = 13180, @StudentDiscount = 0.329
EXEC AddPriceInfo @ConferenceDayID = 247, @InitialDate = '2020-09-14', @Price = 16475.0, @StudentDiscount = 0.329
EXEC AddPriceInfo @ConferenceDayID = 247, @InitialDate = '2020-10-14', @Price = 23065.0, @StudentDiscount = 0.329
EXEC AddPriceInfo @ConferenceDayID = 248, @InitialDate = '2018-04-02', @Price = 10960, @StudentDiscount = 0.282
EXEC AddPriceInfo @ConferenceDayID = 248, @InitialDate = '2018-11-11', @Price = 13700.0, @StudentDiscount = 0.282
EXEC AddPriceInfo @ConferenceDayID = 248, @InitialDate = '2018-12-11', @Price = 19180.0, @StudentDiscount = 0.282
EXEC AddPriceInfo @ConferenceDayID = 249, @InitialDate = '2018-06-25', @Price = 10210, @StudentDiscount = 0.455
EXEC AddPriceInfo @ConferenceDayID = 249, @InitialDate = '2018-11-12', @Price = 12762.5, @StudentDiscount = 0.455
EXEC AddPriceInfo @ConferenceDayID = 249, @InitialDate = '2018-12-12', @Price = 17867.5, @StudentDiscount = 0.455
EXEC AddPriceInfo @ConferenceDayID = 250, @InitialDate = '2018-07-08', @Price = 4350, @StudentDiscount = 0.175
EXEC AddPriceInfo @ConferenceDayID = 250, @InitialDate = '2018-11-13', @Price = 5437.5, @StudentDiscount = 0.175
EXEC AddPriceInfo @ConferenceDayID = 250, @InitialDate = '2018-12-13', @Price = 7612.5, @StudentDiscount = 0.175
EXEC AddPriceInfo @ConferenceDayID = 251, @InitialDate = '2018-06-23', @Price = 14870, @StudentDiscount = 0.032
EXEC AddPriceInfo @ConferenceDayID = 251, @InitialDate = '2018-11-14', @Price = 18587.5, @StudentDiscount = 0.032
EXEC AddPriceInfo @ConferenceDayID = 251, @InitialDate = '2018-12-14', @Price = 26022.5, @StudentDiscount = 0.032
EXEC AddPriceInfo @ConferenceDayID = 252, @InitialDate = '2018-04-25', @Price = 8180, @StudentDiscount = 0.403
EXEC AddPriceInfo @ConferenceDayID = 252, @InitialDate = '2018-11-15', @Price = 10225.0, @StudentDiscount = 0.403
EXEC AddPriceInfo @ConferenceDayID = 252, @InitialDate = '2018-12-15', @Price = 14315.0, @StudentDiscount = 0.403
EXEC AddPriceInfo @ConferenceDayID = 253, @InitialDate = '2018-04-20', @Price = 8800, @StudentDiscount = 0.164
EXEC AddPriceInfo @ConferenceDayID = 253, @InitialDate = '2018-11-16', @Price = 11000.0, @StudentDiscount = 0.164
EXEC AddPriceInfo @ConferenceDayID = 253, @InitialDate = '2018-12-16', @Price = 15400.0, @StudentDiscount = 0.164
EXEC AddPriceInfo @ConferenceDayID = 254, @InitialDate = '2018-05-09', @Price = 8430, @StudentDiscount = 0.438
EXEC AddPriceInfo @ConferenceDayID = 254, @InitialDate = '2018-11-17', @Price = 10537.5, @StudentDiscount = 0.438
EXEC AddPriceInfo @ConferenceDayID = 254, @InitialDate = '2018-12-17', @Price = 14752.5, @StudentDiscount = 0.438
EXEC AddPriceInfo @ConferenceDayID = 255, @InitialDate = '2020-03-08', @Price = 13800, @StudentDiscount = 0.198
EXEC AddPriceInfo @ConferenceDayID = 255, @InitialDate = '2020-08-17', @Price = 17250.0, @StudentDiscount = 0.198
EXEC AddPriceInfo @ConferenceDayID = 255, @InitialDate = '2020-09-17', @Price = 24150.0, @StudentDiscount = 0.198
EXEC AddPriceInfo @ConferenceDayID = 256, @InitialDate = '2020-03-27', @Price = 9370, @StudentDiscount = 0.492
EXEC AddPriceInfo @ConferenceDayID = 256, @InitialDate = '2020-08-18', @Price = 11712.5, @StudentDiscount = 0.492
EXEC AddPriceInfo @ConferenceDayID = 256, @InitialDate = '2020-09-18', @Price = 16397.5, @StudentDiscount = 0.492
EXEC AddPriceInfo @ConferenceDayID = 257, @InitialDate = '2020-04-09', @Price = 11700, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 257, @InitialDate = '2020-08-19', @Price = 14625.0, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 257, @InitialDate = '2020-09-19', @Price = 20475.0, @StudentDiscount = 0.047
EXEC AddPriceInfo @ConferenceDayID = 258, @InitialDate = '2020-03-06', @Price = 11570, @StudentDiscount = 0.172
EXEC AddPriceInfo @ConferenceDayID = 258, @InitialDate = '2020-08-20', @Price = 14462.5, @StudentDiscount = 0.172
EXEC AddPriceInfo @ConferenceDayID = 258, @InitialDate = '2020-09-20', @Price = 20247.5, @StudentDiscount = 0.172
EXEC AddPriceInfo @ConferenceDayID = 259, @InitialDate = '2020-02-22', @Price = 12930, @StudentDiscount = 0.014
EXEC AddPriceInfo @ConferenceDayID = 259, @InitialDate = '2020-08-21', @Price = 16162.5, @StudentDiscount = 0.014
EXEC AddPriceInfo @ConferenceDayID = 259, @InitialDate = '2020-09-21', @Price = 22627.5, @StudentDiscount = 0.014
EXEC AddPriceInfo @ConferenceDayID = 260, @InitialDate = '2020-03-15', @Price = 7060, @StudentDiscount = 0.268
EXEC AddPriceInfo @ConferenceDayID = 260, @InitialDate = '2020-08-22', @Price = 8825.0, @StudentDiscount = 0.268
EXEC AddPriceInfo @ConferenceDayID = 260, @InitialDate = '2020-09-22', @Price = 12355.0, @StudentDiscount = 0.268
EXEC AddPriceInfo @ConferenceDayID = 261, @InitialDate = '2019-08-15', @Price = 3870, @StudentDiscount = 0.369
EXEC AddPriceInfo @ConferenceDayID = 261, @InitialDate = '2020-01-12', @Price = 4837.5, @StudentDiscount = 0.369
EXEC AddPriceInfo @ConferenceDayID = 261, @InitialDate = '2020-02-12', @Price = 6772.5, @StudentDiscount = 0.369
EXEC AddPriceInfo @ConferenceDayID = 262, @InitialDate = '2019-09-01', @Price = 14830, @StudentDiscount = 0.167
EXEC AddPriceInfo @ConferenceDayID = 262, @InitialDate = '2020-01-13', @Price = 18537.5, @StudentDiscount = 0.167
EXEC AddPriceInfo @ConferenceDayID = 262, @InitialDate = '2020-02-13', @Price = 25952.5, @StudentDiscount = 0.167
EXEC AddPriceInfo @ConferenceDayID = 263, @InitialDate = '2019-05-10', @Price = 3870, @StudentDiscount = 0.384
EXEC AddPriceInfo @ConferenceDayID = 263, @InitialDate = '2020-01-14', @Price = 4837.5, @StudentDiscount = 0.384
EXEC AddPriceInfo @ConferenceDayID = 263, @InitialDate = '2020-02-14', @Price = 6772.5, @StudentDiscount = 0.384
EXEC AddPriceInfo @ConferenceDayID = 264, @InitialDate = '2019-09-23', @Price = 13370, @StudentDiscount = 0.080
EXEC AddPriceInfo @ConferenceDayID = 264, @InitialDate = '2020-01-15', @Price = 16712.5, @StudentDiscount = 0.080
EXEC AddPriceInfo @ConferenceDayID = 264, @InitialDate = '2020-02-15', @Price = 23397.5, @StudentDiscount = 0.080
EXEC AddPriceInfo @ConferenceDayID = 265, @InitialDate = '2019-06-05', @Price = 14000, @StudentDiscount = 0.080
EXEC AddPriceInfo @ConferenceDayID = 265, @InitialDate = '2020-01-16', @Price = 17500.0, @StudentDiscount = 0.080
EXEC AddPriceInfo @ConferenceDayID = 265, @InitialDate = '2020-02-16', @Price = 24500.0, @StudentDiscount = 0.080
EXEC AddPriceInfo @ConferenceDayID = 266, @InitialDate = '2018-07-17', @Price = 4100, @StudentDiscount = 0.050
EXEC AddPriceInfo @ConferenceDayID = 266, @InitialDate = '2018-12-08', @Price = 5125.0, @StudentDiscount = 0.050
EXEC AddPriceInfo @ConferenceDayID = 266, @InitialDate = '2019-01-08', @Price = 7175.0, @StudentDiscount = 0.050
EXEC AddPriceInfo @ConferenceDayID = 267, @InitialDate = '2018-06-13', @Price = 12320, @StudentDiscount = 0.362
EXEC AddPriceInfo @ConferenceDayID = 267, @InitialDate = '2018-12-09', @Price = 15400.0, @StudentDiscount = 0.362
EXEC AddPriceInfo @ConferenceDayID = 267, @InitialDate = '2019-01-09', @Price = 21560.0, @StudentDiscount = 0.362
EXEC AddPriceInfo @ConferenceDayID = 268, @InitialDate = '2018-05-14', @Price = 3200, @StudentDiscount = 0.442
EXEC AddPriceInfo @ConferenceDayID = 268, @InitialDate = '2018-12-10', @Price = 4000.0, @StudentDiscount = 0.442
EXEC AddPriceInfo @ConferenceDayID = 268, @InitialDate = '2019-01-10', @Price = 5600.0, @StudentDiscount = 0.442
EXEC AddPriceInfo @ConferenceDayID = 269, @InitialDate = '2018-04-24', @Price = 12200, @StudentDiscount = 0.158
EXEC AddPriceInfo @ConferenceDayID = 269, @InitialDate = '2018-12-11', @Price = 15250.0, @StudentDiscount = 0.158
EXEC AddPriceInfo @ConferenceDayID = 269, @InitialDate = '2019-01-11', @Price = 21350.0, @StudentDiscount = 0.158
EXEC AddPriceInfo @ConferenceDayID = 270, @InitialDate = '2018-07-14', @Price = 14030, @StudentDiscount = 0.272
EXEC AddPriceInfo @ConferenceDayID = 270, @InitialDate = '2019-03-20', @Price = 17537.5, @StudentDiscount = 0.272
EXEC AddPriceInfo @ConferenceDayID = 270, @InitialDate = '2019-04-20', @Price = 24552.5, @StudentDiscount = 0.272
EXEC AddPriceInfo @ConferenceDayID = 271, @InitialDate = '2018-10-12', @Price = 9410, @StudentDiscount = 0.057
EXEC AddPriceInfo @ConferenceDayID = 271, @InitialDate = '2019-03-21', @Price = 11762.5, @StudentDiscount = 0.057
EXEC AddPriceInfo @ConferenceDayID = 271, @InitialDate = '2019-04-21', @Price = 16467.5, @StudentDiscount = 0.057
EXEC AddPriceInfo @ConferenceDayID = 272, @InitialDate = '2018-10-16', @Price = 4270, @StudentDiscount = 0.365
EXEC AddPriceInfo @ConferenceDayID = 272, @InitialDate = '2019-03-22', @Price = 5337.5, @StudentDiscount = 0.365
EXEC AddPriceInfo @ConferenceDayID = 272, @InitialDate = '2019-04-22', @Price = 7472.5, @StudentDiscount = 0.365
EXEC AddPriceInfo @ConferenceDayID = 273, @InitialDate = '2017-04-13', @Price = 15940, @StudentDiscount = 0.479
EXEC AddPriceInfo @ConferenceDayID = 273, @InitialDate = '2017-12-14', @Price = 19925.0, @StudentDiscount = 0.479
EXEC AddPriceInfo @ConferenceDayID = 273, @InitialDate = '2018-01-14', @Price = 27895.0, @StudentDiscount = 0.479
EXEC AddPriceInfo @ConferenceDayID = 274, @InitialDate = '2017-06-10', @Price = 4450, @StudentDiscount = 0.020
EXEC AddPriceInfo @ConferenceDayID = 274, @InitialDate = '2017-12-15', @Price = 5562.5, @StudentDiscount = 0.020
EXEC AddPriceInfo @ConferenceDayID = 274, @InitialDate = '2018-01-15', @Price = 7787.5, @StudentDiscount = 0.020
EXEC AddPriceInfo @ConferenceDayID = 275, @InitialDate = '2017-04-22', @Price = 15070, @StudentDiscount = 0.372
EXEC AddPriceInfo @ConferenceDayID = 275, @InitialDate = '2017-12-16', @Price = 18837.5, @StudentDiscount = 0.372
EXEC AddPriceInfo @ConferenceDayID = 275, @InitialDate = '2018-01-16', @Price = 26372.5, @StudentDiscount = 0.372
EXEC AddPriceInfo @ConferenceDayID = 276, @InitialDate = '2019-01-26', @Price = 5030, @StudentDiscount = 0.144
EXEC AddPriceInfo @ConferenceDayID = 276, @InitialDate = '2019-05-08', @Price = 6287.5, @StudentDiscount = 0.144
EXEC AddPriceInfo @ConferenceDayID = 276, @InitialDate = '2019-06-08', @Price = 8802.5, @StudentDiscount = 0.144
EXEC AddPriceInfo @ConferenceDayID = 277, @InitialDate = '2018-09-16', @Price = 6740, @StudentDiscount = 0.410
EXEC AddPriceInfo @ConferenceDayID = 277, @InitialDate = '2019-05-09', @Price = 8425.0, @StudentDiscount = 0.410
EXEC AddPriceInfo @ConferenceDayID = 277, @InitialDate = '2019-06-09', @Price = 11795.0, @StudentDiscount = 0.410
EXEC AddPriceInfo @ConferenceDayID = 278, @InitialDate = '2018-09-16', @Price = 4710, @StudentDiscount = 0.393
EXEC AddPriceInfo @ConferenceDayID = 278, @InitialDate = '2019-05-10', @Price = 5887.5, @StudentDiscount = 0.393
EXEC AddPriceInfo @ConferenceDayID = 278, @InitialDate = '2019-06-10', @Price = 8242.5, @StudentDiscount = 0.393
EXEC AddPriceInfo @ConferenceDayID = 279, @InitialDate = '2018-09-22', @Price = 3830, @StudentDiscount = 0.099
EXEC AddPriceInfo @ConferenceDayID = 279, @InitialDate = '2019-05-11', @Price = 4787.5, @StudentDiscount = 0.099
EXEC AddPriceInfo @ConferenceDayID = 279, @InitialDate = '2019-06-11', @Price = 6702.5, @StudentDiscount = 0.099
EXEC AddPriceInfo @ConferenceDayID = 280, @InitialDate = '2018-11-24', @Price = 10990, @StudentDiscount = 0.317
EXEC AddPriceInfo @ConferenceDayID = 280, @InitialDate = '2019-05-12', @Price = 13737.5, @StudentDiscount = 0.317
EXEC AddPriceInfo @ConferenceDayID = 280, @InitialDate = '2019-06-12', @Price = 19232.5, @StudentDiscount = 0.317
EXEC AddPriceInfo @ConferenceDayID = 281, @InitialDate = '2018-10-08', @Price = 6300, @StudentDiscount = 0.100
EXEC AddPriceInfo @ConferenceDayID = 281, @InitialDate = '2019-05-13', @Price = 7875.0, @StudentDiscount = 0.100
EXEC AddPriceInfo @ConferenceDayID = 281, @InitialDate = '2019-06-13', @Price = 11025.0, @StudentDiscount = 0.100
EXEC AddPriceInfo @ConferenceDayID = 282, @InitialDate = '2018-09-21', @Price = 4710, @StudentDiscount = 0.228
EXEC AddPriceInfo @ConferenceDayID = 282, @InitialDate = '2019-05-14', @Price = 5887.5, @StudentDiscount = 0.228
EXEC AddPriceInfo @ConferenceDayID = 282, @InitialDate = '2019-06-14', @Price = 8242.5, @StudentDiscount = 0.228
EXEC AddPriceInfo @ConferenceDayID = 283, @InitialDate = '2019-07-26', @Price = 8530, @StudentDiscount = 0.233
EXEC AddPriceInfo @ConferenceDayID = 283, @InitialDate = '2020-03-05', @Price = 10662.5, @StudentDiscount = 0.233
EXEC AddPriceInfo @ConferenceDayID = 283, @InitialDate = '2020-04-05', @Price = 14927.5, @StudentDiscount = 0.233
EXEC AddPriceInfo @ConferenceDayID = 284, @InitialDate = '2019-10-24', @Price = 4580, @StudentDiscount = 0.443
EXEC AddPriceInfo @ConferenceDayID = 284, @InitialDate = '2020-03-06', @Price = 5725.0, @StudentDiscount = 0.443
EXEC AddPriceInfo @ConferenceDayID = 284, @InitialDate = '2020-04-06', @Price = 8015.0, @StudentDiscount = 0.443
EXEC AddPriceInfo @ConferenceDayID = 285, @InitialDate = '2019-09-12', @Price = 6740, @StudentDiscount = 0.287
EXEC AddPriceInfo @ConferenceDayID = 285, @InitialDate = '2020-03-07', @Price = 8425.0, @StudentDiscount = 0.287
EXEC AddPriceInfo @ConferenceDayID = 285, @InitialDate = '2020-04-07', @Price = 11795.0, @StudentDiscount = 0.287
EXEC AddPriceInfo @ConferenceDayID = 286, @InitialDate = '2019-07-08', @Price = 6030, @StudentDiscount = 0.022
EXEC AddPriceInfo @ConferenceDayID = 286, @InitialDate = '2020-03-08', @Price = 7537.5, @StudentDiscount = 0.022
EXEC AddPriceInfo @ConferenceDayID = 286, @InitialDate = '2020-04-08', @Price = 10552.5, @StudentDiscount = 0.022
EXEC AddPriceInfo @ConferenceDayID = 287, @InitialDate = '2016-09-07', @Price = 16000, @StudentDiscount = 0.302
EXEC AddPriceInfo @ConferenceDayID = 287, @InitialDate = '2017-02-03', @Price = 20000.0, @StudentDiscount = 0.302
EXEC AddPriceInfo @ConferenceDayID = 287, @InitialDate = '2017-03-03', @Price = 28000.0, @StudentDiscount = 0.302
EXEC AddPriceInfo @ConferenceDayID = 288, @InitialDate = '2016-09-03', @Price = 11450, @StudentDiscount = 0.372
EXEC AddPriceInfo @ConferenceDayID = 288, @InitialDate = '2017-02-04', @Price = 14312.5, @StudentDiscount = 0.372
EXEC AddPriceInfo @ConferenceDayID = 288, @InitialDate = '2017-03-04', @Price = 20037.5, @StudentDiscount = 0.372
EXEC AddPriceInfo @ConferenceDayID = 289, @InitialDate = '2016-09-27', @Price = 12120, @StudentDiscount = 0.049
EXEC AddPriceInfo @ConferenceDayID = 289, @InitialDate = '2017-02-05', @Price = 15150.0, @StudentDiscount = 0.049
EXEC AddPriceInfo @ConferenceDayID = 289, @InitialDate = '2017-03-05', @Price = 21210.0, @StudentDiscount = 0.049
EXEC AddPriceInfo @ConferenceDayID = 290, @InitialDate = '2016-09-19', @Price = 6810, @StudentDiscount = 0.268
EXEC AddPriceInfo @ConferenceDayID = 290, @InitialDate = '2017-02-06', @Price = 8512.5, @StudentDiscount = 0.268
EXEC AddPriceInfo @ConferenceDayID = 290, @InitialDate = '2017-03-06', @Price = 11917.5, @StudentDiscount = 0.268
EXEC AddPriceInfo @ConferenceDayID = 291, @InitialDate = '2016-09-20', @Price = 16060, @StudentDiscount = 0.355
EXEC AddPriceInfo @ConferenceDayID = 291, @InitialDate = '2017-02-07', @Price = 20075.0, @StudentDiscount = 0.355
EXEC AddPriceInfo @ConferenceDayID = 291, @InitialDate = '2017-03-07', @Price = 28105.0, @StudentDiscount = 0.355
EXEC AddPriceInfo @ConferenceDayID = 292, @InitialDate = '2016-09-21', @Price = 4510, @StudentDiscount = 0.116
EXEC AddPriceInfo @ConferenceDayID = 292, @InitialDate = '2017-02-08', @Price = 5637.5, @StudentDiscount = 0.116
EXEC AddPriceInfo @ConferenceDayID = 292, @InitialDate = '2017-03-08', @Price = 7892.5, @StudentDiscount = 0.116
EXEC AddPriceInfo @ConferenceDayID = 293, @InitialDate = '2017-05-11', @Price = 8220, @StudentDiscount = 0.202
EXEC AddPriceInfo @ConferenceDayID = 293, @InitialDate = '2017-10-01', @Price = 10275.0, @StudentDiscount = 0.202
EXEC AddPriceInfo @ConferenceDayID = 293, @InitialDate = '2017-11-01', @Price = 14385.0, @StudentDiscount = 0.202
EXEC AddPriceInfo @ConferenceDayID = 294, @InitialDate = '2017-02-27', @Price = 14950, @StudentDiscount = 0.366
EXEC AddPriceInfo @ConferenceDayID = 294, @InitialDate = '2017-10-02', @Price = 18687.5, @StudentDiscount = 0.366
EXEC AddPriceInfo @ConferenceDayID = 294, @InitialDate = '2017-11-02', @Price = 26162.5, @StudentDiscount = 0.366
EXEC AddPriceInfo @ConferenceDayID = 295, @InitialDate = '2017-04-20', @Price = 11930, @StudentDiscount = 0.250
EXEC AddPriceInfo @ConferenceDayID = 295, @InitialDate = '2017-10-03', @Price = 14912.5, @StudentDiscount = 0.250
EXEC AddPriceInfo @ConferenceDayID = 295, @InitialDate = '2017-11-03', @Price = 20877.5, @StudentDiscount = 0.250
EXEC AddPriceInfo @ConferenceDayID = 296, @InitialDate = '2017-04-26', @Price = 9940, @StudentDiscount = 0.308
EXEC AddPriceInfo @ConferenceDayID = 296, @InitialDate = '2017-10-04', @Price = 12425.0, @StudentDiscount = 0.308
EXEC AddPriceInfo @ConferenceDayID = 296, @InitialDate = '2017-11-04', @Price = 17395.0, @StudentDiscount = 0.308
EXEC AddPriceInfo @ConferenceDayID = 297, @InitialDate = '2017-04-09', @Price = 7090, @StudentDiscount = 0.275
EXEC AddPriceInfo @ConferenceDayID = 297, @InitialDate = '2017-10-05', @Price = 8862.5, @StudentDiscount = 0.275
EXEC AddPriceInfo @ConferenceDayID = 297, @InitialDate = '2017-11-05', @Price = 12407.5, @StudentDiscount = 0.275
EXEC AddPriceInfo @ConferenceDayID = 298, @InitialDate = '2015-12-23', @Price = 12340, @StudentDiscount = 0.192
EXEC AddPriceInfo @ConferenceDayID = 298, @InitialDate = '2016-04-04', @Price = 15425.0, @StudentDiscount = 0.192
EXEC AddPriceInfo @ConferenceDayID = 298, @InitialDate = '2016-05-04', @Price = 21595.0, @StudentDiscount = 0.192
EXEC AddPriceInfo @ConferenceDayID = 299, @InitialDate = '2015-08-10', @Price = 6140, @StudentDiscount = 0.381
EXEC AddPriceInfo @ConferenceDayID = 299, @InitialDate = '2016-04-05', @Price = 7675.0, @StudentDiscount = 0.381
EXEC AddPriceInfo @ConferenceDayID = 299, @InitialDate = '2016-05-05', @Price = 10745.0, @StudentDiscount = 0.381
EXEC AddPriceInfo @ConferenceDayID = 300, @InitialDate = '2015-12-18', @Price = 7070, @StudentDiscount = 0.183
EXEC AddPriceInfo @ConferenceDayID = 300, @InitialDate = '2016-04-06', @Price = 8837.5, @StudentDiscount = 0.183
EXEC AddPriceInfo @ConferenceDayID = 300, @InitialDate = '2016-05-06', @Price = 12372.5, @StudentDiscount = 0.183
EXEC AddPriceInfo @ConferenceDayID = 301, @InitialDate = '2015-09-18', @Price = 3650, @StudentDiscount = 0.290
EXEC AddPriceInfo @ConferenceDayID = 301, @InitialDate = '2016-04-07', @Price = 4562.5, @StudentDiscount = 0.290
EXEC AddPriceInfo @ConferenceDayID = 301, @InitialDate = '2016-05-07', @Price = 6387.5, @StudentDiscount = 0.290
EXEC AddPriceInfo @ConferenceDayID = 302, @InitialDate = '2015-09-27', @Price = 16260, @StudentDiscount = 0.306
EXEC AddPriceInfo @ConferenceDayID = 302, @InitialDate = '2016-04-08', @Price = 20325.0, @StudentDiscount = 0.306
EXEC AddPriceInfo @ConferenceDayID = 302, @InitialDate = '2016-05-08', @Price = 28455.0, @StudentDiscount = 0.306
EXEC AddPriceInfo @ConferenceDayID = 303, @InitialDate = '2015-12-20', @Price = 10730, @StudentDiscount = 0.440
EXEC AddPriceInfo @ConferenceDayID = 303, @InitialDate = '2016-04-09', @Price = 13412.5, @StudentDiscount = 0.440
EXEC AddPriceInfo @ConferenceDayID = 303, @InitialDate = '2016-05-09', @Price = 18777.5, @StudentDiscount = 0.440
EXEC AddPriceInfo @ConferenceDayID = 304, @InitialDate = '2017-08-17', @Price = 14130, @StudentDiscount = 0.363
EXEC AddPriceInfo @ConferenceDayID = 304, @InitialDate = '2018-04-16', @Price = 17662.5, @StudentDiscount = 0.363
EXEC AddPriceInfo @ConferenceDayID = 304, @InitialDate = '2018-05-16', @Price = 24727.5, @StudentDiscount = 0.363
EXEC AddPriceInfo @ConferenceDayID = 305, @InitialDate = '2017-08-02', @Price = 2700, @StudentDiscount = 0.311
EXEC AddPriceInfo @ConferenceDayID = 305, @InitialDate = '2018-04-17', @Price = 3375.0, @StudentDiscount = 0.311
EXEC AddPriceInfo @ConferenceDayID = 305, @InitialDate = '2018-05-17', @Price = 4725.0, @StudentDiscount = 0.311
EXEC AddPriceInfo @ConferenceDayID = 306, @InitialDate = '2017-09-05', @Price = 8610, @StudentDiscount = 0.279
EXEC AddPriceInfo @ConferenceDayID = 306, @InitialDate = '2018-04-18', @Price = 10762.5, @StudentDiscount = 0.279
EXEC AddPriceInfo @ConferenceDayID = 306, @InitialDate = '2018-05-18', @Price = 15067.5, @StudentDiscount = 0.279
EXEC AddPriceInfo @ConferenceDayID = 307, @InitialDate = '2017-08-20', @Price = 10530, @StudentDiscount = 0.425
EXEC AddPriceInfo @ConferenceDayID = 307, @InitialDate = '2018-04-19', @Price = 13162.5, @StudentDiscount = 0.425
EXEC AddPriceInfo @ConferenceDayID = 307, @InitialDate = '2018-05-19', @Price = 18427.5, @StudentDiscount = 0.425
EXEC AddPriceInfo @ConferenceDayID = 308, @InitialDate = '2019-07-02', @Price = 14860, @StudentDiscount = 0.192
EXEC AddPriceInfo @ConferenceDayID = 308, @InitialDate = '2019-11-08', @Price = 18575.0, @StudentDiscount = 0.192
EXEC AddPriceInfo @ConferenceDayID = 308, @InitialDate = '2019-12-08', @Price = 26005.0, @StudentDiscount = 0.192
EXEC AddPriceInfo @ConferenceDayID = 309, @InitialDate = '2019-06-08', @Price = 6790, @StudentDiscount = 0.406
EXEC AddPriceInfo @ConferenceDayID = 309, @InitialDate = '2019-11-09', @Price = 8487.5, @StudentDiscount = 0.406
EXEC AddPriceInfo @ConferenceDayID = 309, @InitialDate = '2019-12-09', @Price = 11882.5, @StudentDiscount = 0.406
EXEC AddPriceInfo @ConferenceDayID = 310, @InitialDate = '2019-05-14', @Price = 5090, @StudentDiscount = 0.492
EXEC AddPriceInfo @ConferenceDayID = 310, @InitialDate = '2019-11-10', @Price = 6362.5, @StudentDiscount = 0.492
EXEC AddPriceInfo @ConferenceDayID = 310, @InitialDate = '2019-12-10', @Price = 8907.5, @StudentDiscount = 0.492
EXEC AddPriceInfo @ConferenceDayID = 311, @InitialDate = '2019-03-11', @Price = 4320, @StudentDiscount = 0.238
EXEC AddPriceInfo @ConferenceDayID = 311, @InitialDate = '2019-11-11', @Price = 5400.0, @StudentDiscount = 0.238
EXEC AddPriceInfo @ConferenceDayID = 311, @InitialDate = '2019-12-11', @Price = 7560.0, @StudentDiscount = 0.238
EXEC AddPriceInfo @ConferenceDayID = 312, @InitialDate = '2019-05-20', @Price = 4020, @StudentDiscount = 0.487
EXEC AddPriceInfo @ConferenceDayID = 312, @InitialDate = '2019-11-12', @Price = 5025.0, @StudentDiscount = 0.487
EXEC AddPriceInfo @ConferenceDayID = 312, @InitialDate = '2019-12-12', @Price = 7035.0, @StudentDiscount = 0.487
EXEC AddPriceInfo @ConferenceDayID = 313, @InitialDate = '2019-07-28', @Price = 5450, @StudentDiscount = 0.061
EXEC AddPriceInfo @ConferenceDayID = 313, @InitialDate = '2019-11-13', @Price = 6812.5, @StudentDiscount = 0.061
EXEC AddPriceInfo @ConferenceDayID = 313, @InitialDate = '2019-12-13', @Price = 9537.5, @StudentDiscount = 0.061
EXEC AddPriceInfo @ConferenceDayID = 314, @InitialDate = '2020-06-11', @Price = 12510, @StudentDiscount = 0.215
EXEC AddPriceInfo @ConferenceDayID = 314, @InitialDate = '2021-01-04', @Price = 15637.5, @StudentDiscount = 0.215
EXEC AddPriceInfo @ConferenceDayID = 314, @InitialDate = '2021-02-04', @Price = 21892.5, @StudentDiscount = 0.215
EXEC AddPriceInfo @ConferenceDayID = 315, @InitialDate = '2020-07-01', @Price = 11600, @StudentDiscount = 0.138
EXEC AddPriceInfo @ConferenceDayID = 315, @InitialDate = '2021-01-05', @Price = 14500.0, @StudentDiscount = 0.138
EXEC AddPriceInfo @ConferenceDayID = 315, @InitialDate = '2021-02-05', @Price = 20300.0, @StudentDiscount = 0.138
EXEC AddPriceInfo @ConferenceDayID = 316, @InitialDate = '2020-05-24', @Price = 12020, @StudentDiscount = 0.007
EXEC AddPriceInfo @ConferenceDayID = 316, @InitialDate = '2021-01-06', @Price = 15025.0, @StudentDiscount = 0.007
EXEC AddPriceInfo @ConferenceDayID = 316, @InitialDate = '2021-02-06', @Price = 21035.0, @StudentDiscount = 0.007
EXEC AddPriceInfo @ConferenceDayID = 317, @InitialDate = '2020-08-26', @Price = 7660, @StudentDiscount = 0.366
EXEC AddPriceInfo @ConferenceDayID = 317, @InitialDate = '2021-01-07', @Price = 9575.0, @StudentDiscount = 0.366
EXEC AddPriceInfo @ConferenceDayID = 317, @InitialDate = '2021-02-07', @Price = 13405.0, @StudentDiscount = 0.366
EXEC AddPriceInfo @ConferenceDayID = 318, @InitialDate = '2020-09-04', @Price = 10600, @StudentDiscount = 0.064
EXEC AddPriceInfo @ConferenceDayID = 318, @InitialDate = '2021-01-08', @Price = 13250.0, @StudentDiscount = 0.064
EXEC AddPriceInfo @ConferenceDayID = 318, @InitialDate = '2021-02-08', @Price = 18550.0, @StudentDiscount = 0.064
EXEC AddPriceInfo @ConferenceDayID = 319, @InitialDate = '2020-08-17', @Price = 13170, @StudentDiscount = 0.238
EXEC AddPriceInfo @ConferenceDayID = 319, @InitialDate = '2021-01-09', @Price = 16462.5, @StudentDiscount = 0.238
EXEC AddPriceInfo @ConferenceDayID = 319, @InitialDate = '2021-02-09', @Price = 23047.5, @StudentDiscount = 0.238
EXEC AddPriceInfo @ConferenceDayID = 320, @InitialDate = '2017-10-06', @Price = 10370, @StudentDiscount = 0.364
EXEC AddPriceInfo @ConferenceDayID = 320, @InitialDate = '2018-06-19', @Price = 12962.5, @StudentDiscount = 0.364
EXEC AddPriceInfo @ConferenceDayID = 320, @InitialDate = '2018-07-19', @Price = 18147.5, @StudentDiscount = 0.364
EXEC AddPriceInfo @ConferenceDayID = 321, @InitialDate = '2017-11-27', @Price = 3590, @StudentDiscount = 0.158
EXEC AddPriceInfo @ConferenceDayID = 321, @InitialDate = '2018-06-20', @Price = 4487.5, @StudentDiscount = 0.158
EXEC AddPriceInfo @ConferenceDayID = 321, @InitialDate = '2018-07-20', @Price = 6282.5, @StudentDiscount = 0.158
EXEC AddPriceInfo @ConferenceDayID = 322, @InitialDate = '2018-01-06', @Price = 4530, @StudentDiscount = 0.330
EXEC AddPriceInfo @ConferenceDayID = 322, @InitialDate = '2018-06-21', @Price = 5662.5, @StudentDiscount = 0.330
EXEC AddPriceInfo @ConferenceDayID = 322, @InitialDate = '2018-07-21', @Price = 7927.5, @StudentDiscount = 0.330
EXEC AddPriceInfo @ConferenceDayID = 323, @InitialDate = '2017-10-01', @Price = 16190, @StudentDiscount = 0.459
EXEC AddPriceInfo @ConferenceDayID = 323, @InitialDate = '2018-06-22', @Price = 20237.5, @StudentDiscount = 0.459
EXEC AddPriceInfo @ConferenceDayID = 323, @InitialDate = '2018-07-22', @Price = 28332.5, @StudentDiscount = 0.459
EXEC AddPriceInfo @ConferenceDayID = 324, @InitialDate = '2017-12-13', @Price = 3140, @StudentDiscount = 0.428
EXEC AddPriceInfo @ConferenceDayID = 324, @InitialDate = '2018-06-23', @Price = 3925.0, @StudentDiscount = 0.428
EXEC AddPriceInfo @ConferenceDayID = 324, @InitialDate = '2018-07-23', @Price = 5495.0, @StudentDiscount = 0.428
EXEC AddPriceInfo @ConferenceDayID = 325, @InitialDate = '2017-10-07', @Price = 12370, @StudentDiscount = 0.161
EXEC AddPriceInfo @ConferenceDayID = 325, @InitialDate = '2018-06-24', @Price = 15462.5, @StudentDiscount = 0.161
EXEC AddPriceInfo @ConferenceDayID = 325, @InitialDate = '2018-07-24', @Price = 21647.5, @StudentDiscount = 0.161
EXEC AddPriceInfo @ConferenceDayID = 326, @InitialDate = '2017-10-13', @Price = 12410, @StudentDiscount = 0.128
EXEC AddPriceInfo @ConferenceDayID = 326, @InitialDate = '2018-06-25', @Price = 15512.5, @StudentDiscount = 0.128
EXEC AddPriceInfo @ConferenceDayID = 326, @InitialDate = '2018-07-25', @Price = 21717.5, @StudentDiscount = 0.128
EXEC AddPriceInfo @ConferenceDayID = 327, @InitialDate = '2019-01-14', @Price = 14830, @StudentDiscount = 0.258
EXEC AddPriceInfo @ConferenceDayID = 327, @InitialDate = '2019-07-17', @Price = 18537.5, @StudentDiscount = 0.258
EXEC AddPriceInfo @ConferenceDayID = 327, @InitialDate = '2019-08-17', @Price = 25952.5, @StudentDiscount = 0.258
EXEC AddPriceInfo @ConferenceDayID = 328, @InitialDate = '2018-11-26', @Price = 7050, @StudentDiscount = 0.304
EXEC AddPriceInfo @ConferenceDayID = 328, @InitialDate = '2019-07-18', @Price = 8812.5, @StudentDiscount = 0.304
EXEC AddPriceInfo @ConferenceDayID = 328, @InitialDate = '2019-08-18', @Price = 12337.5, @StudentDiscount = 0.304
EXEC AddPriceInfo @ConferenceDayID = 329, @InitialDate = '2019-02-14', @Price = 13050, @StudentDiscount = 0.289
EXEC AddPriceInfo @ConferenceDayID = 329, @InitialDate = '2019-07-19', @Price = 16312.5, @StudentDiscount = 0.289
EXEC AddPriceInfo @ConferenceDayID = 329, @InitialDate = '2019-08-19', @Price = 22837.5, @StudentDiscount = 0.289
EXEC AddPriceInfo @ConferenceDayID = 330, @InitialDate = '2018-11-22', @Price = 3690, @StudentDiscount = 0.110
EXEC AddPriceInfo @ConferenceDayID = 330, @InitialDate = '2019-07-20', @Price = 4612.5, @StudentDiscount = 0.110
EXEC AddPriceInfo @ConferenceDayID = 330, @InitialDate = '2019-08-20', @Price = 6457.5, @StudentDiscount = 0.110
EXEC AddPriceInfo @ConferenceDayID = 331, @InitialDate = '2018-12-25', @Price = 3920, @StudentDiscount = 0.412
EXEC AddPriceInfo @ConferenceDayID = 331, @InitialDate = '2019-07-21', @Price = 4900.0, @StudentDiscount = 0.412
EXEC AddPriceInfo @ConferenceDayID = 331, @InitialDate = '2019-08-21', @Price = 6860.0, @StudentDiscount = 0.412
EXEC AddPriceInfo @ConferenceDayID = 332, @InitialDate = '2019-03-11', @Price = 13490, @StudentDiscount = 0.243
EXEC AddPriceInfo @ConferenceDayID = 332, @InitialDate = '2019-07-22', @Price = 16862.5, @StudentDiscount = 0.243
EXEC AddPriceInfo @ConferenceDayID = 332, @InitialDate = '2019-08-22', @Price = 23607.5, @StudentDiscount = 0.243
EXEC AddPriceInfo @ConferenceDayID = 333, @InitialDate = '2021-03-21', @Price = 16350, @StudentDiscount = 0.229
EXEC AddPriceInfo @ConferenceDayID = 333, @InitialDate = '2021-07-08', @Price = 20437.5, @StudentDiscount = 0.229
EXEC AddPriceInfo @ConferenceDayID = 333, @InitialDate = '2021-08-08', @Price = 28612.5, @StudentDiscount = 0.229
EXEC AddPriceInfo @ConferenceDayID = 334, @InitialDate = '2021-02-23', @Price = 13040, @StudentDiscount = 0.130
EXEC AddPriceInfo @ConferenceDayID = 334, @InitialDate = '2021-07-09', @Price = 16300.0, @StudentDiscount = 0.130
EXEC AddPriceInfo @ConferenceDayID = 334, @InitialDate = '2021-08-09', @Price = 22820.0, @StudentDiscount = 0.130
EXEC AddPriceInfo @ConferenceDayID = 335, @InitialDate = '2020-12-21', @Price = 3610, @StudentDiscount = 0.269
EXEC AddPriceInfo @ConferenceDayID = 335, @InitialDate = '2021-07-10', @Price = 4512.5, @StudentDiscount = 0.269
EXEC AddPriceInfo @ConferenceDayID = 335, @InitialDate = '2021-08-10', @Price = 6317.5, @StudentDiscount = 0.269
EXEC AddPriceInfo @ConferenceDayID = 336, @InitialDate = '2021-02-19', @Price = 3650, @StudentDiscount = 0.025
EXEC AddPriceInfo @ConferenceDayID = 336, @InitialDate = '2021-07-11', @Price = 4562.5, @StudentDiscount = 0.025
EXEC AddPriceInfo @ConferenceDayID = 336, @InitialDate = '2021-08-11', @Price = 6387.5, @StudentDiscount = 0.025
EXEC AddPriceInfo @ConferenceDayID = 337, @InitialDate = '2021-03-17', @Price = 16020, @StudentDiscount = 0.105
EXEC AddPriceInfo @ConferenceDayID = 337, @InitialDate = '2021-07-12', @Price = 20025.0, @StudentDiscount = 0.105
EXEC AddPriceInfo @ConferenceDayID = 337, @InitialDate = '2021-08-12', @Price = 28035.0, @StudentDiscount = 0.105
EXEC AddPriceInfo @ConferenceDayID = 338, @InitialDate = '2021-02-22', @Price = 6720, @StudentDiscount = 0.202
EXEC AddPriceInfo @ConferenceDayID = 338, @InitialDate = '2021-07-13', @Price = 8400.0, @StudentDiscount = 0.202
EXEC AddPriceInfo @ConferenceDayID = 338, @InitialDate = '2021-08-13', @Price = 11760.0, @StudentDiscount = 0.202
EXEC AddPriceInfo @ConferenceDayID = 339, @InitialDate = '2021-03-14', @Price = 11500, @StudentDiscount = 0.282
EXEC AddPriceInfo @ConferenceDayID = 339, @InitialDate = '2021-07-14', @Price = 14375.0, @StudentDiscount = 0.282
EXEC AddPriceInfo @ConferenceDayID = 339, @InitialDate = '2021-08-14', @Price = 20125.0, @StudentDiscount = 0.282
EXEC AddPriceInfo @ConferenceDayID = 340, @InitialDate = '2017-12-27', @Price = 12710, @StudentDiscount = 0.258
EXEC AddPriceInfo @ConferenceDayID = 340, @InitialDate = '2018-04-15', @Price = 15887.5, @StudentDiscount = 0.258
EXEC AddPriceInfo @ConferenceDayID = 340, @InitialDate = '2018-05-15', @Price = 22242.5, @StudentDiscount = 0.258
EXEC AddPriceInfo @ConferenceDayID = 341, @InitialDate = '2017-09-08', @Price = 14980, @StudentDiscount = 0.377
EXEC AddPriceInfo @ConferenceDayID = 341, @InitialDate = '2018-04-16', @Price = 18725.0, @StudentDiscount = 0.377
EXEC AddPriceInfo @ConferenceDayID = 341, @InitialDate = '2018-05-16', @Price = 26215.0, @StudentDiscount = 0.377
EXEC AddPriceInfo @ConferenceDayID = 342, @InitialDate = '2017-09-16', @Price = 15470, @StudentDiscount = 0.143
EXEC AddPriceInfo @ConferenceDayID = 342, @InitialDate = '2018-04-17', @Price = 19337.5, @StudentDiscount = 0.143
EXEC AddPriceInfo @ConferenceDayID = 342, @InitialDate = '2018-05-17', @Price = 27072.5, @StudentDiscount = 0.143
EXEC AddPriceInfo @ConferenceDayID = 343, @InitialDate = '2017-09-22', @Price = 9840, @StudentDiscount = 0.223
EXEC AddPriceInfo @ConferenceDayID = 343, @InitialDate = '2018-04-18', @Price = 12300.0, @StudentDiscount = 0.223
EXEC AddPriceInfo @ConferenceDayID = 343, @InitialDate = '2018-05-18', @Price = 17220.0, @StudentDiscount = 0.223
EXEC AddPriceInfo @ConferenceDayID = 344, @InitialDate = '2017-12-26', @Price = 15680, @StudentDiscount = 0.024
EXEC AddPriceInfo @ConferenceDayID = 344, @InitialDate = '2018-04-19', @Price = 19600.0, @StudentDiscount = 0.024
EXEC AddPriceInfo @ConferenceDayID = 344, @InitialDate = '2018-05-19', @Price = 27440.0, @StudentDiscount = 0.024
EXEC AddPriceInfo @ConferenceDayID = 345, @InitialDate = '2017-08-15', @Price = 4890, @StudentDiscount = 0.337
EXEC AddPriceInfo @ConferenceDayID = 345, @InitialDate = '2018-04-20', @Price = 6112.5, @StudentDiscount = 0.337
EXEC AddPriceInfo @ConferenceDayID = 345, @InitialDate = '2018-05-20', @Price = 8557.5, @StudentDiscount = 0.337
EXEC AddPriceInfo @ConferenceDayID = 346, @InitialDate = '2017-10-16', @Price = 15400, @StudentDiscount = 0.194
EXEC AddPriceInfo @ConferenceDayID = 346, @InitialDate = '2018-04-21', @Price = 19250.0, @StudentDiscount = 0.194
EXEC AddPriceInfo @ConferenceDayID = 346, @InitialDate = '2018-05-21', @Price = 26950.0, @StudentDiscount = 0.194
EXEC AddPriceInfo @ConferenceDayID = 347, @InitialDate = '2021-01-16', @Price = 10000, @StudentDiscount = 0.440
EXEC AddPriceInfo @ConferenceDayID = 347, @InitialDate = '2021-05-08', @Price = 12500.0, @StudentDiscount = 0.440
EXEC AddPriceInfo @ConferenceDayID = 347, @InitialDate = '2021-06-08', @Price = 17500.0, @StudentDiscount = 0.440
EXEC AddPriceInfo @ConferenceDayID = 348, @InitialDate = '2020-09-18', @Price = 15980, @StudentDiscount = 0.275
EXEC AddPriceInfo @ConferenceDayID = 348, @InitialDate = '2021-05-09', @Price = 19975.0, @StudentDiscount = 0.275
EXEC AddPriceInfo @ConferenceDayID = 348, @InitialDate = '2021-06-09', @Price = 27965.0, @StudentDiscount = 0.275
EXEC AddPriceInfo @ConferenceDayID = 349, @InitialDate = '2021-01-26', @Price = 3780, @StudentDiscount = 0.339
EXEC AddPriceInfo @ConferenceDayID = 349, @InitialDate = '2021-05-10', @Price = 4725.0, @StudentDiscount = 0.339
EXEC AddPriceInfo @ConferenceDayID = 349, @InitialDate = '2021-06-10', @Price = 6615.0, @StudentDiscount = 0.339
EXEC AddPriceInfo @ConferenceDayID = 350, @InitialDate = '2020-12-23', @Price = 14480, @StudentDiscount = 0.223
EXEC AddPriceInfo @ConferenceDayID = 350, @InitialDate = '2021-05-11', @Price = 18100.0, @StudentDiscount = 0.223
EXEC AddPriceInfo @ConferenceDayID = 350, @InitialDate = '2021-06-11', @Price = 25340.0, @StudentDiscount = 0.223
EXEC AddPriceInfo @ConferenceDayID = 351, @InitialDate = '2015-12-10', @Price = 11150, @StudentDiscount = 0.116
EXEC AddPriceInfo @ConferenceDayID = 351, @InitialDate = '2016-07-18', @Price = 13937.5, @StudentDiscount = 0.116
EXEC AddPriceInfo @ConferenceDayID = 351, @InitialDate = '2016-08-18', @Price = 19512.5, @StudentDiscount = 0.116
EXEC AddPriceInfo @ConferenceDayID = 352, @InitialDate = '2015-12-10', @Price = 10480, @StudentDiscount = 0.214
EXEC AddPriceInfo @ConferenceDayID = 352, @InitialDate = '2016-07-19', @Price = 13100.0, @StudentDiscount = 0.214
EXEC AddPriceInfo @ConferenceDayID = 352, @InitialDate = '2016-08-19', @Price = 18340.0, @StudentDiscount = 0.214
EXEC AddPriceInfo @ConferenceDayID = 353, @InitialDate = '2016-01-06', @Price = 14460, @StudentDiscount = 0.057
EXEC AddPriceInfo @ConferenceDayID = 353, @InitialDate = '2016-07-20', @Price = 18075.0, @StudentDiscount = 0.057
EXEC AddPriceInfo @ConferenceDayID = 353, @InitialDate = '2016-08-20', @Price = 25305.0, @StudentDiscount = 0.057
EXEC AddPriceInfo @ConferenceDayID = 354, @InitialDate = '2016-01-14', @Price = 12420, @StudentDiscount = 0.086
EXEC AddPriceInfo @ConferenceDayID = 354, @InitialDate = '2016-07-21', @Price = 15525.0, @StudentDiscount = 0.086
EXEC AddPriceInfo @ConferenceDayID = 354, @InitialDate = '2016-08-21', @Price = 21735.0, @StudentDiscount = 0.086

