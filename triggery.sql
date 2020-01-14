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
