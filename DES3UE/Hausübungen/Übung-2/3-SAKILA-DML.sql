-- 1. Erstellen Sie eine neue Tabelle „new_film“, diese soll den gleichen Aufbau wie die Tabelle
-- „film“ haben, jedoch nur die neueren Filme enthalten. Als neuere Filme gelten jene, die nicht
-- älter als 25 Jahre sind (setzen Sie dazu das aktuelle Datum in Bezug mit dem Erscheinungsjahr).
-- (1 Punkt)

CREATE TABLE New_Film
AS
SELECT *
FROM Film
WHERE Release_Year >= EXTRACT(YEAR FROM SYSDATE) - 25;


-- 2. Fügen Sie den Film „Love Machine 3“ mit ID = 1001 in Englisch (language_id = 1) mit 5
-- Tagen Verleihdauer (zum Preis von 1,79) mit Ersetzungskosten von 21,50 in die Tabelle ein.
-- (1 Punkt)

INSERT INTO New_Film (Film_Id,
                      Title,
                      Language_Id,
                      Rental_Duration,
                      Rental_Rate,
                      Replacement_Cost,
                      Last_Update)
VALUES (1001,
        'Love Machine 3',
        1,
        5,
        1.79,
        21.50,
        SYSDATE);

-- 3. Erhöhen Sie den Leihpreis der Filme in der Tabelle „new_film“ um 15%, wenn der Leihpreis
-- kleiner als 2 ist. (0,5 Punkte)

UPDATE New_Film
SET Rental_Rate = Rental_Rate * 1.15
WHERE Rental_Rate < 2;

-- 4. Erstellen Sie eine View, die alle Filme der Tabelle „new_film“ enthält, deren Leihpreis
-- maximal 2 beträgt, vergeben Sie die Check-Option. Die View soll nur den Filmtitel, die
-- Beschreibung, den Leihpreis und die Länge enthalten. (1 Punkt)

CREATE VIEW IF NOT EXISTS Cheap_Films
AS
SELECT Title, Description, Rental_Rate, Length
FROM New_Film
WHERE Rental_Rate <= 2
WITH CHECK OPTION CONSTRAINT Cheap_Films_Check;

-- 5. Welche Auswirkungen haben COMMIT und ROLLBACK an dieser Stelle (nachdem Sie die
-- View erstellt haben). (0,5 Punkte)

-- Insofern COMMIT oder Rollback direkt nach dem Erstellen der View ausgeführt werden, haben sie keine Wirkung.
-- Nachdem CREATE VIEW ein DDL Statement ist, wird davor und danach implizit commited. COMMIT wurde damit deshalb schon
-- erledigt und ROLLBACK zeigt keine Wirkung.


-- 6. Können Sie die Datensätze Ihrer neuen View verändern? Wenn ja, führen Sie die Erhöhung der
-- Filme (15%) ein weiteres Mal durch, diesmal auf Ihre View. Wenn nein, warum nicht?
-- (0,5 Punkte)

-- Ja, die Datensätze können grundsätzlich verändert werden, aber nur, solange sie noch im definierten Fenster der View
-- sichtbar bleiben.

-- Nein die Erhöhung kann nicht durchgeführt werden, weil einige Filme dann teurer als die definierten 2 € würden.
-- Die Check Option verhindert das.

UPDATE Cheap_Films
SET Rental_Rate = Rental_Rate * 1.15
WHERE Rental_Rate < 2;


-- 7. Löschen Sie alle Einträge aus der Tabelle „new_film“, deren Leihpreis über 1.79 liegt.
-- (0,5 Punkte)

DELETE
FROM New_Film
WHERE Rental_Rate > 1.79;


-- 8. Können Sie den Leihpreis der Filme in der View nun erhöhen? Erklären Sie dieses Verhalten.
-- (0,5 Punkte)

-- Ja jetzt kann die Preiserhöhung durchgeführt werden, da kein Film teuer als 2 € werden kann.

UPDATE Cheap_Films
SET Rental_Rate = Rental_Rate * 1.15
WHERE Rental_Rate < 2;


-- 9. Löschen Sie die Tabelle „new_film“ und Ihre erstellte View wieder. (2 Statements, 0,5 Punkte)

DROP VIEW IF EXISTS Cheap_Films;
DROP TABLE IF EXISTS New_Film;

