-- Create the Input Table For Getting Employer ID , Check in time and check out time 
CREATE TABLE EmployeeLogins (
    EmployerID INT,
    Name VARCHAR(100),
    CheckInTime DATETIME,
    CheckOutTime DATETIME
);

-- Inserting sample data from the given hint documentation 
INSERT INTO EmployeeLogins (EmployerID, Name, CheckInTime, CheckOutTime) VALUES
(1, 'Him', '2024-03-01 10:08', '2024-03-01 12:00'),
(1, 'Him', '2024-03-01 13:00', '2024-03-01 15:00'),
(1, 'Him', '2024-03-01 16:00', '2024-03-01 18:08'),
(2, 'Raj', '2024-03-01 10:10', '2024-03-01 12:00'),
(2, 'Raj', '2024-03-01 13:00', '2024-03-01 15:12'),
(3, 'Anu', '2024-03-01 10:12', '2024-03-01 12:00'),
(3, 'Anu', '2024-03-01 13:00', '2024-03-01 15:00'),
(3, 'Anu', '2024-03-01 16:00', '2024-03-01 18:35');

-- Created the Output Table to display the first check in time and last checkin time and total work hours and total Out Count
CREATE TABLE EmployeeWorkHours (
    EmployerID INT,
    Name VARCHAR(100),
    FirstCheckInTime DATETIME,
    LastCheckOutTime DATETIME,
    TotalOutCount INT,
    TotalWorkHours VARCHAR(10)
);

-- Calculating the Required Fields of employer
INSERT INTO EmployeeWorkHours (EmployerID, Name, FirstCheckInTime, LastCheckOutTime, TotalOutCount, TotalWorkHours)
SELECT 
    EmployerID,
    Name,
    MIN(CheckInTime) AS FirstCheckInTime,
    MAX(CheckOutTime) AS LastCheckOutTime,
    COUNT(*) - 1 AS TotalOutCount,
    CONVERT(VARCHAR, DATEADD(MINUTE, SUM(DATEDIFF(MINUTE, CheckInTime, CheckOutTime)), 0), 108) AS TotalWorkHours
FROM 
    EmployeeLogins
GROUP BY 
    EmployerID, Name;

-- Displaying results
SELECT * FROM EmployeeWorkHours;




-- Below the Output of Following Sql code 