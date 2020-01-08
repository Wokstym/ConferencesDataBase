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