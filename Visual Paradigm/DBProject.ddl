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
  PhoneNumber     varchar(50) NOT NULL, 
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
  Price            varchar(50) NOT NULL CHECK(Price >= 0), 
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
  isCancelled            bit DEFAULT '0' NOT NULL, 
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
  CompanyID   int NOT NULL, 
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
