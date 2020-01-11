
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
    AS P ON CR.ParticipantsID = P.ParticipantsID
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
    (SELECT COUNT (ConferenceDayReservationID) AS
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
    WorkshopBooking.PlacesReservedAmount,
    count(WorkshopReservations.WorkshopReservationID) as 'Places assigned',
    Workshops.Price as 'Regular price for place',
    count(Students.ParticipantID) as 'Students amount',
    (cast((Workshop.Price * ((count(WorkshopReservations.WorkshopReservationID)) as numeric(10,2))) as 'Price for reserved places',
    (Workshop.Price * WorkshopBooking.PlacesReservedAmount) as 'Expected payment for booking'

  FROM
    WorkshopBooking INNER JOIN
    Workshops ON WorkshopBooking.WorkshopID = Workshops.WorkshopID LEFT JOIN
    ConferenceDayReservations ON WorkshopBooking.ConferenceDayBookingID = ConferenceDayReservations.ConferenceDayBookingID LEFT JOIN
    WorkshopReservations ON WorkshopBooking.WorkshopBookingID = WorkshopReservations.WorkshopBookingID INNER JOIN
    ConferenceDays ON Workshops.ConferenceDayID = ConferenceDays.ConferenceDayID LEFT JOIN
    Students ON( (ConferenceDayReservations.ParticipantID = Students.ParticipantID) AND (DATEDIFF(day,Conferences.StartDate,Students.ExpirationDate)>=0 )) INNER JOIN
    Conferences ON ConferenceDays.ConferenceID = Conferences.ConferenceID
  GROUP BY WorkshopBooking.WorkshopBookingID, WorkshopBooking.PlacesResevervedAmount, Workshop.Price;

/* Author: Grzegorz Poręba */
GO
CREATE VIEW [dbo].[ClientsToCall]
AS
SELECT CI.booking_id,
       CI.booking_date,
       C.conference_id,
       C.start_day,
       CI.[Places booked],
       CI.[Places assigned],
       ISNULL(PAI.[Paid money], 0) AS 'Paid money',
       CI.client_id,
       CL.name                     AS 'Client name',
       CL.phone                    AS 'Client phone',
       CL.email                    AS 'Client email',
       CL.is_company               AS 'Is company'
FROM dbo.ConferenceDayPayingInfo AS CI
         LEFT OUTER JOIN
     dbo.PaymentsDiffInfo AS PAI ON CI.ConferenceDayBookingID = PAI.[Conference day booking id] AND
                                    PAI.[Paid money] > CI.[Conference day act price] + CI.[Workshops act price]
         INNER JOIN
     dbo.ConferenceDayBooking AS CB ON CI.ConferenceDayBookingID = CB.ConferenceDayBookingID AND CB.isCancelled = 0
         INNER JOIN
     dbo.ConferenceDay AS CD ON CI.ConferenceDayID = CD.ConferenceDayID
         INNER JOIN
     dbo.Conferences AS C ON CD.ConferenceID = C.ConferenceID
         INNER JOIN
     dbo.Customers AS CL ON CI.CustomerID = CL.CustomerID
WHERE (DATEDIFF(day, GETDATE(), C.StartDay) <= 14)
  AND (DATEDIFF(day, GETDATE(), C.StartDay) >= 0)

/* Author: Grzegorz Poręba */
GO
CREATE VIEW [dbo].[ImportantClients]
AS
SELECT dbo.Customers.CustomerID,
       dbo.Customers.FirstName,
       dbo.Customers.LastName,
       dbo.Customers.Phone,
       dbo.Customers.Email,
       IsCompany(Customers.CustomerID) AS IsCompany,
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
GROUP BY dbo.Customers.CustomerID,  dbo.Customers.FirstName, dbo.Customers.LastName, dbo.Customers.Phone, dbo.Customers.Email, IsCompany

/* Author: Grzegorz Poręba */
GO
CREATE VIEW [dbo].[ParticipantsForWorkshops]
AS
SELECT P.ParticipantID, P.FirstName, P.LastName, WB.WorkshopBookingID
FROM dbo.WorkshopReservations AS WR
         INNER JOIN
     dbo.ConferenceDayReservations AS CR ON WR.ConferenceDayReservationsID = CR.ConferenceDayReservationsID
         INNER JOIN
     dbo.Participants AS P ON CR.ParticipantID = P.ParticipantID
         INNER JOIN
     dbo.WorkshopBooking AS WB ON WR.WorkshopBookingID = WB.WorkshopBookingID
