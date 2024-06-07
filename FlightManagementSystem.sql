	DROP DATABASE IF EXISTS FlightManagementSystem;
	CREATE DATABASE FlightManagementSystem;
	USE FlightManagementSystem;

	CREATE TABLE Admin (
		username VARCHAR(30),
		password VARCHAR(30),
		PRIMARY KEY (username)
	);

	CREATE TABLE Representative (
		username VARCHAR(30),
		password VARCHAR(30),
		PRIMARY KEY (username)
	);

	CREATE TABLE Aircraft (
		numOfSeats INT,
		planeID INT,
		PRIMARY KEY (planeID)
	);

	CREATE TABLE AirlineCompany (
		twoLetterid CHAR(2),
		PRIMARY KEY (twoLetterid)
	);

	CREATE TABLE Airport (
		threeLetterid CHAR(3),
		PRIMARY KEY (threeLetterid)
	);

	CREATE TABLE FlightDetails (
		flightNum INT,
		twoLetterId CHAR(2),
		departureThreeLetterId CHAR(3),
		depDate DATETIME,
		arrivalThreeLetterId CHAR(3),
		arrDate DATETIME,
		duration INT,
		planeID INT,
		numOfStops INT,
		PRIMARY KEY (flightNum, twoLetterId),
		FOREIGN KEY (twoLetterId) REFERENCES AirlineCompany(twoLetterid),
		FOREIGN KEY (departureThreeLetterId) REFERENCES Airport(threeLetterid),
		FOREIGN KEY (arrivalThreeLetterId) REFERENCES Airport(threeLetterid),
		FOREIGN KEY (planeID) REFERENCES Aircraft(planeID)
	);

	CREATE TABLE WaitingList (
		flightNum INT,
		twoLetterId CHAR(2),
		PRIMARY KEY (flightNum, twoLetterId),
		FOREIGN KEY (flightNum, twoLetterId) REFERENCES FlightDetails(flightNum, twoLetterId)
	);

	CREATE TABLE FlightTicketTransaction (
		ticketid INT,
		seatNumber INT,
		farePrice INT,
		oneWay BOOLEAN,
		class VARCHAR(20),
		purchaseDate DATETIME,
		bookingFee INT,
		dateFlexibility INT,
		cancelFee INT,
		username VARCHAR(50),
		PRIMARY KEY (ticketid)
	);

	CREATE TABLE UserAccount (
		username VARCHAR(50),
		fname VARCHAR(50),
		lname VARCHAR(50),
		password VARCHAR(50),
		PRIMARY KEY (username)
	);

	CREATE TABLE WaitsFor (
		flightNum INT,
		twoLetterId CHAR(2),
		username VARCHAR(50),
		PRIMARY KEY (flightNum, twoLetterId, username),
		FOREIGN KEY (flightNum, twoLetterId) REFERENCES FlightDetails(flightNum, twoLetterId),
		FOREIGN KEY (username) REFERENCES UserAccount(username)
	);

	CREATE TABLE Owns (
		twoLetterid CHAR(2),
		planeID INT,
		PRIMARY KEY (twoLetterid, planeID),
		FOREIGN KEY (twoLetterid) REFERENCES AirlineCompany(twoLetterid),
		FOREIGN KEY (planeID) REFERENCES Aircraft(planeID)
	);

	CREATE TABLE AssociatedWith (
		twoLetterid CHAR(2),
		threeLetterid CHAR(3),
		PRIMARY KEY (twoLetterid, threeLetterid),
		FOREIGN KEY (twoLetterid) REFERENCES AirlineCompany(twoLetterid),
		FOREIGN KEY (threeLetterid) REFERENCES Airport(threeLetterid)
	);

	CREATE TABLE RelatesTo (
		flightNum INT,
		twoLetterId CHAR(2),
		ticketid INT,
		PRIMARY KEY (flightNum, twoLetterId, ticketid),
		FOREIGN KEY (ticketid) REFERENCES FlightTicketTransaction(ticketid),
		FOREIGN KEY (flightNum, twoLetterId) REFERENCES FlightDetails(flightNum, twoLetterId)
	);

	CREATE TABLE Questions (
		questionID INT,
		question VARCHAR(1000),
		answer VARCHAR(1000),
		primary key (questionID)
	);

	ALTER TABLE FlightTicketTransaction
	ADD FOREIGN KEY (username) REFERENCES UserAccount(username);


	INSERT INTO Admin (username, password) VALUES ('admin', 'group51');
	INSERT INTO Representative (username, password) VALUES ('rep1', 'pswd');
	INSERT INTO UserAccount (username, password, fname, lname) VALUES ('user1', 'pswd', 'User', 'Name');
	INSERT INTO Questions (questionID, question, answer) VALUES (1, 'How do I log in?', 'Enter your username and password and then press log in.');
	INSERT INTO Questions (questionID, question, answer) VALUES (2, 'Super long question to test margins', 'Sample Answer');

	INSERT INTO Airport (threeLetterid) VALUES ('EWR');
	INSERT INTO Airport (threeLetterid) VALUES ('HNL');
	INSERT INTO Airport (threeLetterid) VALUES ('LAX');
	INSERT INTO AirlineCompany (twoLetterid) VALUES ('UA');
	INSERT INTO AirlineCompany (twoLetterid) VALUES ('DL');
	INSERT INTO Aircraft (planeID, numOfSeats) VALUES (001747, 500);
	INSERT INTO Aircraft (planeID, numOfSeats) VALUES (002747, 500);
	INSERT INTO Aircraft (planeID, numOfSeats) VALUES (003747, 500);
	INSERT INTO Aircraft (planeID, numOfSeats) VALUES (004747, 500);
	INSERT INTO Aircraft (planeID, numOfSeats) VALUES (005747, 500);

	INSERT INTO FlightTicketTransaction(ticketid, seatNumber, farePrice, oneWay, class, purchaseDate, bookingFee, dateFlexibility, cancelFee, username) VALUES
	(10000, 001, 900, true, 'first', null, 100, 1, 50, null); 
	INSERT INTO FlightTicketTransaction(ticketid, seatNumber, farePrice, oneWay, class, purchaseDate, bookingFee, dateFlexibility, cancelFee, username) VALUES
	(10002, 002, 850, true, 'first', null, 100, 1, 50, null); 
	INSERT INTO FlightTicketTransaction(ticketid, seatNumber, farePrice, oneWay, class, purchaseDate, bookingFee, dateFlexibility, cancelFee, username) VALUES
	(10003, 003, 1000, true, 'first', null, 100, 1, 50, null);
	INSERT INTO FlightTicketTransaction(ticketid, seatNumber, farePrice, oneWay, class, purchaseDate, bookingFee, dateFlexibility, cancelFee, username) VALUES
	(10004, 004, 1100, true, 'first', null, 100, 1, 50, null);
	INSERT INTO FlightTicketTransaction(ticketid, seatNumber, farePrice, oneWay, class, purchaseDate, bookingFee, dateFlexibility, cancelFee, username) VALUES
	(10001, 005, 900, true, 'first', '2022-11-12 19:00:00', 100, 1, 50, 'user1'); 

	INSERT INTO FlightDetails(flightNum, twoLetterId, departureThreeLetterId, depDate, arrivalThreeLetterId, arrDate, duration, planeID, numOfStops) VALUES
	(1234, 'UA', 'EWR', '2025-12-20 12:00:00', 'HNL', '2025-12-20 22:00:00', 600, 001747, 2);
	INSERT INTO FlightDetails(flightNum, twoLetterId, departureThreeLetterId, depDate, arrivalThreeLetterId, arrDate, duration, planeID, numOfStops) VALUES
	(1235, 'UA', 'LAX', '2025-12-23 12:00:00', 'EWR', '2025-12-28 18:00:00', 360, 002747, 1);
	INSERT INTO FlightDetails(flightNum, twoLetterId, departureThreeLetterId, depDate, arrivalThreeLetterId, arrDate, duration, planeID, numOfStops) VALUES
	(1236, 'DL', 'HNL', '2025-12-30 12:00:00', 'EWR', '2025-12-30 22:00:00', 600, 003747, 2);
	INSERT INTO FlightDetails(flightNum, twoLetterId, departureThreeLetterId, depDate, arrivalThreeLetterId, arrDate, duration, planeID, numOfStops) VALUES
	(1237, 'DL', 'HNL', '2025-12-29 12:00:00', 'EWR', '2025-12-29 22:00:00', 600, 004747, 2);
	INSERT INTO FlightDetails(flightNum, twoLetterId, departureThreeLetterId, depDate, arrivalThreeLetterId, arrDate, duration, planeID, numOfStops) VALUES
	(1111, 'DL', 'LAX', '2022-12-29 12:00:00', 'HNL', '2022-12-29 18:00:00', 360, 005747, 2);


	INSERT INTO RelatesTo(flightNum, twoLetterId, ticketid) VALUES ('1234', 'UA', 10000);
	INSERT INTO RelatesTo(flightNum, twoLetterId, ticketid) VALUES ('1234', 'UA', 10002);
	INSERT INTO RelatesTo(flightNum, twoLetterId, ticketid) VALUES ('1236', 'DL', 10003);
	INSERT INTO RelatesTo(flightNum, twoLetterId, ticketid) VALUES ('1234', 'UA', 10004);
	INSERT INTO RelatesTo(flightNum, twoLetterId, ticketid) VALUES ('1111', 'DL', 10001);

	INSERT INTO Owns (planeID, twoLetterID) VALUES (001747, 'UA');
	INSERT INTO Owns (planeID, twoLetterID) VALUES (002747, 'UA');
	INSERT INTO Owns (planeID, twoLetterID) VALUES (003747, 'DL');
	INSERT INTO Owns (planeID, twoLetterID) VALUES (004747, 'DL');
	INSERT INTO Owns (planeID, twoLetterID) VALUES (005747, 'DL');

	INSERT INTO AssociatedWith (threeLetterId, twoLetterId) VALUES ('EWR', 'DL');
	INSERT INTO AssociatedWith (threeLetterId, twoLetterId) VALUES ('EWR', 'UA');
	INSERT INTO AssociatedWith (threeLetterId, twoLetterId) VALUES ('HNL', 'DL');
	INSERT INTO AssociatedWith (threeLetterId, twoLetterId) VALUES ('HNL', 'UA');
	INSERT INTO AssociatedWith (threeLetterId, twoLetterId) VALUES ('LAX', 'DL');
	INSERT INTO AssociatedWith (threeLetterId, twoLetterId) VALUES ('LAX', 'UA');






