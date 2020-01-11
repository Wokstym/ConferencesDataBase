
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
    WorkshopBooking.ConferenceDayBookingID,
    WorkshopBooking.PlacesReservedAmount,
    count(WorkshopReservations.WorkshopReservationID) as 'PlacesAssigned',
    Workshops.Price as 'RegularPriceForPlace',
    count(Students.ParticipantID) as 'StudentsAmount',
    (cast((Workshop.Price * ((count(WorkshopReservations.WorkshopReservationID)) as numeric(10,2))) as 'PriceForReservedPlaces',
    (Workshop.Price * WorkshopBooking.PlacesReservedAmount) as 'MaxExpectedPaymentForBooking'

  FROM
    WorkshopBooking INNER JOIN
    Workshops ON WorkshopBooking.WorkshopID = Workshops.WorkshopID LEFT JOIN
    ConferenceDayReservations ON WorkshopBooking.ConferenceDayBookingID = ConferenceDayReservations.ConferenceDayBookingID LEFT JOIN
    WorkshopReservations ON WorkshopBooking.WorkshopBookingID = WorkshopReservations.WorkshopBookingID INNER JOIN
    ConferenceDays ON Workshops.ConferenceDayID = ConferenceDays.ConferenceDayID LEFT JOIN
    Students ON( (ConferenceDayReservations.ParticipantID = Students.ParticipantID) AND (DATEDIFF(day,Conferences.StartDate,Students.ExpirationDate)>=0 )) INNER JOIN
    Conferences ON ConferenceDays.ConferenceID = Conferences.ConferenceID
  GROUP BY WorkshopBooking.WorkshopBookingID, WorkshopBooking.PlacesReservedAmount, Workshop.Price;

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
          - COUNT(S.ParticipantID) + COUNT(S.ParticipantID)*PI.StudentDiscount)) as numeric(10,2))) as 'ConferenceDayActualPrice',
        (GetPriceStageForDate(CDB.BookingDate,CDB.ConferenceDayID)* CDB.PlacesReservedAmount) as 'ConferenceDayMaxExpectedPrice',
        (ISNULL(WI.ActualPrice,0)) as 'WorkshopActualPrice', (ISNULL(WI.ExpectedPrice,0)) as 'WorkshopMaxExpectedPrice'
FROM ConferenceDayBooking as CDB
    INNER JOIN ConferenceDay as CD 
        ON CD.ConferenceDayID = CDB.ConferenceDayID
    INNER JOIN Conferences as C
        ON CD.ConferenceID = C.ConferenceID
    LEFT JOIN ConferenceDayReservations as CDR 
        ON CDR.ConferenceDayBookingID = CDB.ConferenceDayBookingID
    LEFT JOIN Students as S 
        ON (CDR.ParticipantID = S.ParticipantID) AND (DATEDIFF(day, C.StartDate, S.ExpirationDate) >= 0)
    INNER JOIN PriceInfo as PI
        ON (PI.PriceInfoID = GetPriceInfoIDForDate(CDB.BookingDate,CDB.ConferenceDayID))
    LEFT JOIN (SELECT WBPI.ConferenceDayBookingID, SUM(WBPI.PriceForReservedPlaces) as 'ActualPrice',
                SUM(WBPI.MaxExpectedPaymentForBooking) as 'MaxExpectedPrice'
                FROM WorkshopBookingPayingInfo as WBPI
                GROUP BY WBPI.WorkshopBookingID) as WI
        ON CDB.ConferenceDayBookingID = WI.ConferenceDayBookingID
GROUP BY CDB.ConferenceDayBookingID, CDB.ConfernceDayID, CDB.CustomerID, CDB.BookingDate, CDB.PlacesReservedAmount,
          PI.Price, PI.StudentDiscount, C.ConferenceID, WI.ActualPrice, WI.ExpectedPrice

/* Author: Mateusz Pawłowicz */
GO
CREATE VIEW ConferencePayingInfo
AS
SELECT CustomerID, ConferenceID, cast((SUM(ConferenceDayActualPrice) + SUM(WorkshopActualPrice)) as numeric(10,2))
        as 'ActualPriceToPayForConference',
        cast((SUM(ConferenceDayMaxExpectedPrice) + SUM(WorkshopMaxExpectedPrice)) as numeric(10,2))
        as 'MaxExpectedPriceToPayForConference',
FROM ConferenceDayPayingInfo
GROUP BY CustomerID, ConferenceID

/* Author: Mateusz Pawłowicz */
GO
CREATE VIEW PaymentsDiffInfo
AS
SELECT P.ConferenceDayBookingID, CAST(SUM(P.Amount) as numeric(10,2)) as 'PaidMoney',
      CAST(CDPI.ConferenceDayActualPrice + CDPI.WorkshopActualPrice as numeric(10,2)) as 'ActualPriceToPay',
      CAST(CDPI.ConferenceDayMaxExpectedPrice + CDPI.WorkshopMaxExpectedPrice as numeric(10,2)) as 'MaxExpectedPriceToPay',
FROM Payments as P
    INNER JOIN ConferenceDayPayingInfo as CDPI
        ON P.ConferenceDayBookingID = CDPI.ConferenceDayBookingID
GROUP BY P.ConferenceDayBookingID ,(CDPI.ConferenceDayActualPrice + CDPI.WorkshopActualPrice),
          (CDPI.ConferenceDayMaxExpectedPrice + CDPI.WorkshopMaxExpectedPrice) 
