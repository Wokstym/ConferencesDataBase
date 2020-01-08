/*  AvailableWorkshops  */

SELECT C.ConferenceName                                   AS 'Conference name',
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


/* ParticipantsForConferenceDay */

SELECT P.FirstName, P.LastName, P.ParticipantID, CB.ConferenceDayID, CB.CustomerID
FROM dbo.ConferenceDayReservations AS CR
         INNER JOIN dbo.Participants
    AS P ON CR.ParticipantsID = P.ParticipantsID
         INNER JOIN dbo.ConferenceDayBooking
    AS CB ON CR.ConferenceDayBookingID = CB.ConferenceDayBookingID


GO
CREATE VIEW ClientsWhoMustFullfilBookings AS
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
GO
CREATE VIEW WorkshopBookingPayingInfo AS
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