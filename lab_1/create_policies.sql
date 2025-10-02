DROP ROLE IF EXISTS doctor;
DROP ROLE IF EXISTS dispatcher;

CREATE ROLE doctor;
CREATE ROLE dispatcher;

ALTER TABLE Calls ENABLE ROW LEVEL SECURITY;
ALTER TABLE Brigades ENABLE ROW LEVEL SECURITY;

-- Доступ ко всем атрибутам
GRANT SELECT ON Calls TO doctor;
GRANT SELECT ON Brigades TO doctor;
GRANT UPDATE (Diagnosis, HospitalizationFlag, Actions) ON Calls TO doctor;

-- Создаём политику для SELECT
CREATE POLICY doctor_brigades_select_policy ON Brigades
FOR SELECT
TO doctor
USING (true);
CREATE POLICY doctor_select_policy ON Calls
FOR SELECT
TO doctor
USING (true);

-- Политика RLS для ограничения UPDATE на своих вызовах
CREATE POLICY doctor_update_policy ON Calls
FOR UPDATE
TO doctor
USING (
    EXISTS (
        SELECT 1 FROM Brigades b
        WHERE b.BrigadeNumber = Calls.BrigadeNumber
        AND b.DoctorName = CURRENT_USER
    )
)
WITH CHECK (
    EXISTS (
        SELECT 1 FROM Brigades b
        WHERE b.BrigadeNumber = Calls.BrigadeNumber
        AND b.DoctorName = CURRENT_USER
    )
);

-- Доступ ко всем атрибутам 
GRANT SELECT ON Calls TO dispatcher;
GRANT SELECT ON Brigades TO dispatcher;

CREATE POLICY dispatcher_brigades_xselect ON Brigades
FOR SELECT
TO dispatcher
USING (true);

-- Политика RLS для ограничения строк
CREATE POLICY dispatcher_select_policy ON Calls
FOR SELECT
TO dispatcher
USING (DispatcherName = CURRENT_USER);