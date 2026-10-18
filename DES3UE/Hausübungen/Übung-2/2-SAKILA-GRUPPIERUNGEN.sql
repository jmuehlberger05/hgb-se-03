-- 1. Geben Sie Vor- und Nachnamen aller Schauspieler*innen aus, die in keinem Film der Kategorie
-- „Horror“ mitgespielt haben. Verwenden Sie KEINEN Mengenoperator.
-- (44 Zeilen, 1,5 Punkte)

SELECT First_Name, Last_Name
FROM Actor
WHERE Actor_Id NOT IN (SELECT Actor_Id
                       FROM Film_Actor
                                INNER JOIN Film_Category USING (Film_Id)
                                INNER JOIN Category USING (Category_Id)
                       WHERE Category.Name = 'Horror');

-- 2. Geben Sie die Vor- und Nachnamen aller Kund*innen aus, die eine Adresse in den
-- „United States“ aufweisen, deren zugewiesene Hauptfiliale (customer.store_id) sich aber in
-- „Canada“ befindet.
-- (17 Zeilen, 1,5 Punkte)

SELECT C.First_Name, C.Last_Name
FROM Customer C
         JOIN Address A ON A.Address_Id = C.Address_Id
         JOIN City Ci ON Ci.City_Id = A.City_Id
         JOIN Country Co ON Co.Country_Id = Ci.Country_Id
WHERE Co.Country = 'United States'
  AND C.Store_Id IN (SELECT S.Store_Id
                     FROM Store S
                              JOIN Address A ON A.Address_Id = S.Address_Id
                              JOIN City Ci ON Ci.City_Id = A.City_Id
                              JOIN Country Co ON Co.Country_Id = Ci.Country_Id
                     WHERE Co.Country = 'Canada');


-- 3. Geben Sie Vor- und Nachnamen sowie den Gesamtumsatz (Summe aller Zahlungen) jener
-- Kund*innen aus, deren Gesamtumsatz über dem durchschnittlichen Gesamtumsatz pro Kund*in
-- liegt. Sortieren Sie absteigend nach dem Umsatz.
-- (285 Zeilen, 2 Punkte)

SELECT First_Name, Last_Name, SUM(Amount) AS Gesamtumsatz
FROM Customer
         INNER JOIN Payment USING (Customer_Id)
GROUP BY Customer_Id, First_Name, Last_Name
HAVING SUM(Payment.Amount) > (SELECT AVG(SUM(Amount))
                              FROM Payment
                              GROUP BY Customer_Id)
ORDER BY Gesamtumsatz DESC;

-- 4. Ermitteln Sie alle Filmtitel, die kürzer oder gleich lange dauern als der Film mit der ID 50.
-- Geben Sie von diesen Titeln allerdings nur jene mit den größten Ersetzungskosten aus.
-- Sortieren Sie nach Filmtitel.
-- (53 Zeilen, 2 Punkte)

SELECT Title
FROM Film
WHERE Length <= (SELECT Length FROM Film WHERE Film_Id = 50)
  AND Replacement_Cost = (SELECT MAX(Replacement_Cost) FROM Film)
ORDER BY Title;


-- 5. Ermitteln Sie für jede Sprache den längsten Film mit einer Dauer von höchstens 120 Minuten.
-- Verwenden Sie dafür die Spalte language_id. Berücksichtigen Sie nur Filme, bei denen eine
-- Originalsprache (original_language_id) hinterlegt ist. Haben mehrere Filme dieselbe
-- maximale Dauer, sollen alle ausgegeben werden. Geben Sie den Namen der Sprache sowie die
-- Titel und Länge der Filme aus, sortieren Sie nach Sprache.
-- (11 Zeilen, 2,5 Punkte)

SELECT Name AS Language, Title, Length
FROM Film F
         INNER JOIN Language ON F.Language_Id = Language.Language_Id
WHERE Original_Language_Id IS NOT NULL
  AND Length = (SELECT MAX(Length)
                FROM Film
                WHERE Length <= 120
                  AND Original_Language_Id IS NOT NULL
                  AND Language_Id = F.Language_Id)
ORDER BY Language;

-- Geben Sie die neun zuletzt verliehenen Filme und das Verleihdatum im Format ‘YYYY-MM-
-- DD‘ aus. Welche Möglichkeiten haben Sie, um die „neun letzten“ Filme zu ermitteln?
-- (1,5 Punkte)

SELECT Title, TO_CHAR(Rental_Date, 'YYYY-MM-DD') AS Verleihdatum
FROM Film
         JOIN Inventory USING (Film_Id)
         JOIN Rental USING (Inventory_Id)
ORDER BY Rental_Date DESC, Rental_Id DESC
    FETCH FIRST 9 ROWS ONLY;

SELECT Title,
       TO_CHAR(Rental_Date, 'YYYY-MM-DD') AS Verleihdatum
FROM (SELECT F.Title, R.Rental_Date, R.Rental_Id
      FROM Rental R
               JOIN Inventory I ON I.Inventory_Id = R.Inventory_Id
               JOIN Film F ON F.Film_Id = I.Film_Id
      ORDER BY R.Rental_Date DESC, R.Rental_Id DESC)
WHERE ROWNUM <= 9
ORDER BY Rental_Date DESC, Rental_Id DESC;

