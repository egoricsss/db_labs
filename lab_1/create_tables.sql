DROP TABLE IF EXISTS Brigades CASCADE;
CREATE TABLE Brigades (
	BrigadeNumber INT PRIMARY KEY,
	DoctorName TEXT NOT NULL,
	DoctorPosition TEXT NOT NULL,
	UNIQUE (BrigadeNumber)
);

DROP TABLE IF EXISTS Calls;
CREATE TABLE Calls (
	CallDateTime TIMESTAMP NOT NULL,
	ArrivalDateTime TIMESTAMP NOT NULL,
	PatientName TEXT NOT NULL,
	PatientAddress TEXT NOT NULL,
	BrigadeNumber INT NOT NULL,
	Diagnosis TEXT NOT NULL,
	HospitalizationFlag BOOLEAN NOT NULL,
	Actions TEXT,
	DispatcherName TEXT NOT NULL,
	PRIMARY KEY (CallDateTime, PatientAddress),
	FOREIGN KEY (BrigadeNumber) REFERENCES Brigades(BrigadeNumber),
	UNIQUE (CallDateTime, BrigadeNumber), -- AK1
	UNIQUE (ArrivalDateTime, PatientName), -- AK2
	UNIQUE (ArrivalDateTime, BrigadeNumber) -- AK3
);