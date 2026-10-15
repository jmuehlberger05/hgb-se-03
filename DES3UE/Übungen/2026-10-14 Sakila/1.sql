-- 1. Welche Filme sind vor 1985 entstanden und behandeln das Thema Datenbank (Beschreibung enthät 'Database')

SELECT *
FROM Film
WHERE Release_Year < 1985
  AND LOWER(Description) LIKE LOWER('%Database%');

-- 2. Ermitteln Sie, wie viele Verleihvorgänge ein Mitarbeiter durchschnittlich ausführt

SELECT AVG(COUNT(*))
FROM Rental
GROUP BY Staff_Id;

-- 3. Wie lautet der Titel des kürzesten Films, der kürzesten Filme?

-- 3.a) 10 beliebige Filme ausgeben

SELECT *
FROM Film
WHERE ROWNUM < 11;

-- 3b. Titel des kürzesten Films / der kürzesten Filme

SELECT Title, Length
FROM Film
WHERE Length = (SELECT MIN(Length) FROM Film);

-- 4. Welcher Kunde borgt die meisten Filme aus Kategorie Animation aus?


SELECT Customer_Id, First_Name, (COUNT(*)) AS Animation_Count
FROM Category
         INNER JOIN Film_Category USING (Category_Id)
         INNER JOIN Inventory USING (Film_Id)
         INNER JOIN Rental USING (Inventory_Id)
         INNER JOIN Customer USING (Customer_Id)
WHERE Category.Name LIKE 'Animation'
GROUP BY Customer_Id, First_Name
HAVING COUNT(*) = (SELECT MAX(COUNT(Rental_Id))
                   FROM Category
                            INNER JOIN Film_Category USING (Category_Id)
                            INNER JOIN Inventory USING (Film_Id)
                            INNER JOIN Rental USING (Inventory_Id)
                            INNER JOIN Customer USING (Customer_Id)
                   WHERE Category.Name LIKE 'Animation'
                   GROUP BY Customer_Id, First_Name)
ORDER BY COUNT(*) DESC;


SELECT Customer_Id, First_Name, (COUNT(*)) AS Animation_Count
FROM Category
         INNER JOIN Film_Category USING (Category_Id)
         INNER JOIN Inventory USING (Film_Id)
         INNER JOIN Rental USING (Inventory_Id)
         INNER JOIN Customer USING (Customer_Id)
WHERE Category.Name LIKE 'Animation'
GROUP BY Customer_Id, First_Name
ORDER BY COUNT(*) DESC
    FETCH FIRST 1 ROWS
WITH TIES;


