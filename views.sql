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
