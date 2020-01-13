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