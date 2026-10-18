-- 1. Erstellen Sie eine Liste aller Schauspieler*innen. Verketten Sie Vor- und Nachname (getrennt
-- durch ein Leerzeichen) und nennen Sie die neue Spalte „Name“. Sortieren Sie das Ergebnis
-- nach dem Nachnamen. (1 Punkt)

SELECT First_Name || ' ' || Last_Name AS Name
FROM Actor
ORDER BY Last_Name;


-- 2. Geben Sie eine Liste mit Titel und Länge all jener Filme aus, die mindestens 120 Minuten
-- dauern und deren Titel an zweiter Stelle ein 'A' enthält. Geben Sie die Titel so aus, dass jeweils
-- der erste Buchstabe eines Wortes mit einem Großbuchstaben beginnt (zB Calendar Gunfight).
-- (1 Punkt)

SELECT INITCAP(Title) AS Title, Length
FROM Film
WHERE Length >= 120
  AND Title LIKE '_A%';


-- 3. Geben Sie alle Inventar-Ids aus, die noch nie verliehen wurden. Verwenden Sie einen
-- Mengenoperator. (1 Punkt)

SELECT Inventory_Id
FROM Inventory
MINUS
SELECT Inventory_Id
FROM Rental;


-- 4. Geben Sie für alle Mitarbeiter*innen folgende Informationen aus: den Nachnamen als
-- „StaffName“, die ID (store_id) der zugeordneten Filiale sowie den Nachnamen des Managers
-- der jeweiligen Filiale als „ManagerName“. (1,5 Punkte)

SELECT Last_Name                                AS Staffname,
       Store_Id,
       (SELECT M.Last_Name
        FROM Staff M
        WHERE St.Manager_Staff_Id = M.Staff_Id) AS Managername
FROM Staff
         JOIN Store St USING (Store_Id);

-- 5. Geben Sie die Anzahl der Verleihvorgänge im Jahr 2015 aus (Start des Verleihvorgangs,
-- rental_date). (1 Punkt)

SELECT COUNT(*) AS Verleihvorgänge
FROM Rental
WHERE Rental_Date BETWEEN TO_DATE('01.01.2015', 'DD.MM.YYYY')
          AND TO_DATE('31.12.2015', 'DD.MM.YYYY');


-- 6. Geben Sie für alle Verleihvorgänge die ID sowie das Rückgabedatum (in absteigender
-- Reihenfolge, nicht abgeschlossene Verleihvorgänge zuerst) in folgendem Format aus:
-- ‚Wed, 14th October 2026‘. Wenn noch kein Rückgabedatum vorhanden ist, soll stattdessen der
-- Text „not returned yet“ ausgegeben werden. Verwenden Sie zur Formatierung des Datums die
-- Funktion TO_CHAR. Achten Sie darauf, die Wochentags- und Monatsnamen in englischer
-- Sprache auszugeben, indem Sie den passenden NLS-Parameter setzen. Recherchieren Sie bei
-- Bedarf in der Oracle-Dokumentation. (1,5 Punkte)

SELECT Rental_Id,
       COALESCE(TO_CHAR(
                        Return_Date,
                        'fmDy, DDth Month YYYY',
                        'NLS_DATE_LANGUAGE=English'),
                'not returned yet') AS Rueckgabedatum
FROM Rental
ORDER BY Return_Date DESC NULLS FIRST;
