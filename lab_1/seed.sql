-- === Очистка таблиц перед заполнением ===
TRUNCATE TABLE Calls CASCADE;
TRUNCATE TABLE Brigades CASCADE;

-- === Заполнение таблицы Brigades ===
INSERT INTO Brigades (BrigadeNumber, DoctorName, DoctorPosition) VALUES
(1, 'ivanov', 'Emergency doctor'),
(2, 'petrova', 'senior doctor'),
(3, 'sidorov', 'paramedic'),
(4, 'kuznetsova', 'Emergency doctor');

DROP USER IF EXISTS ivanov;
DROP USER IF EXISTS petrova;
DROP USER IF EXISTS sidorov;
DROP USER IF EXISTS kuznetsova;

DROP USER IF EXISTS dispatcher_1;
DROP USER IF EXISTS dispatcher_2;
DROP USER IF EXISTS dispatcher_3;

-- Создание пользователей
CREATE USER ivanov WITH NOLOGIN;
CREATE USER petrova WITH NOLOGIN;
CREATE USER sidorov WITH NOLOGIN;
CREATE USER kuznetsova WITH NOLOGIN;

CREATE USER dispatcher_1 WITH NOLOGIN;
CREATE USER dispatcher_2 WITH NOLOGIN;
CREATE USER dispatcher_3 WITH NOLOGIN;

GRANT doctor TO ivanov, petrova, sidorov, kuznetsova;
GRANT dispatcher TO dispatcher_1, dispatcher_2, dispatcher_3;

-- === Заполнение таблицы Calls ===
INSERT INTO Calls (CallDateTime, ArrivalDateTime, PatientName, PatientAddress, BrigadeNumber, Diagnosis, HospitalizationFlag, Actions, DispatcherName) VALUES
('2025-06-01 08:30:00', '2025-06-01 09:05:00', 'Petrov I.I.', 'Lenin St., 15', 1, 'Suspected stroke', true, 'Transport assigned to Hospital #1', 'dispatcher_1'),
('2025-06-01 10:15:00', '2025-06-01 10:40:00', 'Smirnova O.A.', 'Pobedy Ave., 7', 1, 'Hypertensive crisis', true, 'Medication administered, hospitalized', 'dispatcher_1'),

-- Calls for Brigade 2 — Petrova
('2025-06-01 12:00:00', '2025-06-01 12:25:00', 'Kozlov D.R.', 'Gagarin St., 22', 2, 'Forearm fracture', true, 'Cast applied, transported to trauma center', 'dispatcher_2'),
('2025-06-01 14:30:00', '2025-06-01 15:00:00', 'Morozova N.T.', 'Kirov St., 33', 2, 'Acute poisoning', true, 'Stomach lavage, IV drip', 'dispatcher_2'),

-- Calls for Brigade 3 — Sidorov
('2025-06-01 09:45:00', '2025-06-01 10:10:00', 'Lebedev A.V.', 'Mira St., 5', 3, 'Fainting', false, 'Resuscitation performed, patient regained consciousness', 'dispatcher_1'),
('2025-06-01 16:00:00', '2024-06-01 16:25:00', 'Egorova L.I.', 'Sadovaya St., 12', 3, 'Allergic reaction', false, 'Antihistamine administered', 'dispatcher_3'),

-- Calls for Brigade 4 — Kuznetsova
('2025-06-01 11:30:00', '2025-06-01 12:00:00', 'Fedorov R.A.', 'Tsentralnaya St., 8', 4, 'Abdominal pain', true, 'Referred to hospital for examination', 'dispatcher_2'),
('2025-06-01 17:00:00', '2025-06-01 17:30:00', 'Zaitseva Y.M.', 'Shkolnaya St., 19', 4, 'Suspected appendicitis', true, 'Emergency hospitalization', 'dispatcher_3');


