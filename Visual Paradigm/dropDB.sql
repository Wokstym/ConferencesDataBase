ALTER TABLE Conferences DROP CONSTRAINT FKConference324472;
ALTER TABLE Buildings DROP CONSTRAINT FKBuildings784537;
ALTER TABLE Conferences DROP CONSTRAINT FKConference475199;
ALTER TABLE PartnersForConferences DROP CONSTRAINT FKPartnersFo229207;
ALTER TABLE PartnersForConferences DROP CONSTRAINT FKPartnersFo611831;
ALTER TABLE Rooms DROP CONSTRAINT FKRooms994958;
ALTER TABLE Workshops DROP CONSTRAINT FKWorkshops151547;
ALTER TABLE ConferenceDays DROP CONSTRAINT FKConference689988;
ALTER TABLE Workshops DROP CONSTRAINT FKWorkshops976736;
ALTER TABLE EmployeesForConferenceDays DROP CONSTRAINT FKEmployeesF719312;
ALTER TABLE EmployeesForConferenceDays DROP CONSTRAINT FKEmployeesF764688;
ALTER TABLE Students DROP CONSTRAINT FKStudents971491;
ALTER TABLE ConferenceDayReservations DROP CONSTRAINT FKConference74141;
ALTER TABLE WorkshopReservations DROP CONSTRAINT FKWorkshopRe101140;
ALTER TABLE WorkshopReservations DROP CONSTRAINT FKWorkshopRe592703;
ALTER TABLE Payments DROP CONSTRAINT FKPayments321954;
ALTER TABLE ConferenceDayBooking DROP CONSTRAINT FKConference310116;
ALTER TABLE Companies DROP CONSTRAINT FKCompanies259074;
ALTER TABLE ConferenceDayBooking DROP CONSTRAINT FKConference447239;
ALTER TABLE WorkshopBooking DROP CONSTRAINT FKWorkshopBo241185;
ALTER TABLE ConferenceDayReservations DROP CONSTRAINT FKConference87939;
ALTER TABLE WorkshopBooking DROP CONSTRAINT FKWorkshopBo808220;
ALTER TABLE PriceInfo DROP CONSTRAINT FKPriceInfo736566;
ALTER TABLE Conferences DROP CONSTRAINT FKConference232345;
DROP TABLE Conferences;
DROP TABLE Organizers;
DROP TABLE BuildingOwners;
DROP TABLE Buildings;
DROP TABLE Partners;
DROP TABLE PartnersForConferences;
DROP TABLE Rooms;
DROP TABLE Workshops;
DROP TABLE ConferenceDays;
DROP TABLE Employees;
DROP TABLE EmployeesForConferenceDays;
DROP TABLE ConferenceDayBooking;
DROP TABLE Customers;
DROP TABLE Companies;
DROP TABLE Payments;
DROP TABLE WorkshopBooking;
DROP TABLE PriceInfo;
DROP TABLE ConferenceDayReservations;
DROP TABLE Participants;
DROP TABLE Students;
DROP TABLE WorkshopReservations;
DROP FUNCTION dbo.GetNumberOfFreePlacesForConference
DROP FUNCTION dbo.GetNumberOfFreePlacesForWorkshop
DROP FUNCTION dbo.GetPriceInfoForDate
DROP FUNCTION dbo.GetPriceStageForDate
DROP FUNCTION dbo.IsCompany
DROP PROCEDURE dbo.AddBuilding
DROP PROCEDURE dbo.AddBuildingOwner
DROP PROCEDURE dbo.AddCompanyData
DROP PROCEDURE dbo.AddConference
DROP PROCEDURE dbo.AddCustomer
DROP PROCEDURE dbo.AddConferenceDay
DROP PROCEDURE dbo.AddEmployee
DROP PROCEDURE dbo.AddOrganizer
DROP PROCEDURE dbo.AddParticipant
DROP PROCEDURE dbo.AddPayment
DROP PROCEDURE dbo.AddPartner
DROP PROCEDURE dbo.AddRoom
DROP PROCEDURE dbo.AddStudentData
DROP PROCEDURE dbo.AddWorkshop
DROP PROCEDURE dbo.AssignEmployeeToConferenceDay
DROP PROCEDURE dbo.AssignParticipantToWorkshopBooking
DROP PROCEDURE dbo.AssignPartnerToConference
DROP PROCEDURE dbo.AssignParticipantToConferenceDayBooking
DROP PROCEDURE dbo.BookPlacesForConferenceDay
DROP PROCEDURE dbo.BookPlacesForWorkshop
DROP PROCEDURE dbo.AddPriceInfo
DROP PROCEDURE dbo.CancelConferenceDayBooking
DROP PROCEDURE dbo.CancelWorkshopBooking
DROP PROCEDURE dbo.ChangePlacesReservedAmountForWorkshopBooking
DROP PROCEDURE dbo.DecreasePlacesReservedAmountForConferenceDay
DROP PROCEDURE dbo.GEN_AssignParticipantToConferenceDayBooking
DROP PROCEDURE dbo.GEN_AddPayment
DROP PROCEDURE dbo.GEN_AssignParticipantToWorkshopBooking
DROP PROCEDURE dbo.GEN_BookPlacesForWorkshop
DROP PROCEDURE dbo.CancelAllUnpaidConferenceDayBookings
DROP PROCEDURE dbo.IncreaseParticipantLimitForConferenceDay
DROP PROCEDURE dbo.GEN_BookPlacesForConferenceDay
DROP PROCEDURE dbo.IncreaseParticipantLimitForWorkshop
DROP PROCEDURE dbo.RemoveParticiptanReservationForConferenceDay
DROP PROCEDURE dbo.RemoveParticiptanReservationForWorkshop
DROP VIEW dbo.AvailableWorkshops
DROP VIEW dbo.ConferenceDayPayingInfo
DROP VIEW dbo.ClientsToCall
DROP VIEW dbo.ImportantClients
DROP VIEW dbo.ConferencePayingInfo
DROP VIEW dbo.ParticipantsForConferenceDay
DROP VIEW dbo.ParticipantsForWorkshops
DROP VIEW dbo.PaymentsDiffInfo
DROP VIEW dbo.ClientsWhoMustFullfilBookings
DROP VIEW dbo.WorkshopBookingPayingInfo


