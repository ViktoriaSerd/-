---1
SELECT Productid, Name, Color, ListPrice, Size
FROM Production.Product
WHERE Productid NOT IN (SELECT Productid FROM Sales.SalesOrderDetail)
ORDER BY Productid


---2
SELECT c.CustomerID,
    CASE 
        WHEN p.LastName IS NULL THEN 'Unknown' 
        ELSE p.LastName 
    END AS LastName,
    CASE 
        WHEN p.FirstName IS NULL THEN 'Unknown' 
        ELSE p.FirstName 
    END AS FirstName
FROM Sales.Customer c 
    LEFT JOIN Person.Person p ON c.PersonID = p.BusinessEntityID 
	LEFT JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE soh.SalesOrderID IS NULL
ORDER BY c.CustomerID;


---3
SELECT TOP 10 o.CustomerID, p.FirstName, p.LastName,
    COUNT(o.SalesOrderID) AS CountOfOrders
FROM Person.Person p 
    JOIN sales.SalesOrderHeader o ON p.BusinessEntityID = o.CustomerID
GROUP BY o.CustomerID, p.FirstName, p.LastName
ORDER BY CountOfOrders DESC


---4
SELECT p.FirstName, p.LastName, e.JobTitle, e.HireDate,
     COUNT(e2.BusinessEntityID) AS CountOfTitle
FROM HumanResources.Employee e 
     JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID 
	 JOIN HumanResources.Employee e2 ON e.JobTitle = e2.JobTitle
GROUP BY p.FirstName, p.LastName, e.JobTitle, e.HireDate
ORDER BY CountOfTitle


---5
WITH vtOrderRanks AS
    (SELECT soh.SalesOrderID,c.CustomerID,p.LastName,p.FirstName,soh.OrderDate,
        ROW_NUMBER() OVER (PARTITION BY c.CustomerID ORDER BY soh.OrderDate DESC) AS OrderRank
    FROM Sales.SalesOrderHeader soh 
	JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID 
	JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    )
SELECT r1.SalesOrderID, r1.CustomerID, r1.LastName, r1.FirstName, 
       r1.OrderDate AS LastOrder, r2.OrderDate AS PreviousOrder
FROM vtOrderRanks r1 LEFT JOIN vtOrderRanks r2 
    ON r1.CustomerID = r2.CustomerID AND r2.OrderRank = r1.OrderRank + 1
WHERE r1.OrderRank = 1
ORDER BY r1.CustomerID;



---6
WITH vtOrderTotals AS (
    SELECT soh.SalesOrderID, c.CustomerID, p.LastName, p.FirstName,
        YEAR(soh.OrderDate) AS OrderYear,
        SUM(sod.UnitPrice * (1 - sod.UnitPriceDiscount) * sod.OrderQty) AS Total
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    GROUP BY
        soh.SalesOrderID, c.CustomerID, p.LastName, p.FirstName, YEAR(soh.OrderDate)
)
SELECT ot.OrderYear AS [Year], ot.SalesOrderID, ot.LastName, ot.FirstName,
    FORMAT(ot.Total, 'N', 'en-us') AS Total
FROM vtOrderTotals ot
    JOIN (SELECT OrderYear, MAX(Total) AS MaxTotal
          FROM vtOrderTotals
          GROUP BY  OrderYear) otMax
ON ot.OrderYear = otMax.OrderYear AND ot.Total = otMax.MaxTotal
ORDER BY ot.OrderYear;


---7
SELECT Month, [2011], [2012], [2013], [2014]
FROM (SELECT YEAR(o.OrderDate) AS Year,
             MONTH(o.OrderDate) AS Month
      FROM sales.SalesOrderHeader o) YM
PIVOT ( COUNT(Year) FOR Year IN ([2011], [2012], [2013], [2014])) AS MM
ORDER BY Month;


---8
WITH vtMonthlyTotals AS (
    SELECT YEAR(soh.OrderDate) AS OrderYear,
           MONTH(soh.OrderDate) AS OrderMonth,
           SUM(sod.UnitPrice * (1 - sod.UnitPriceDiscount) * sod.OrderQty) AS SumPrice
    FROM Sales.SalesOrderHeader soh
         JOIN Sales.SalesOrderDetail sod 
		 ON soh.SalesOrderID = sod.SalesOrderID
    GROUP BY YEAR(soh.OrderDate), MONTH(soh.OrderDate)
    ),
    vtYearlyTotals AS (
	SELECT OrderYear, SUM(SumPrice) AS YearlySum
    FROM vtMonthlyTotals
    GROUP BY OrderYear
	),
    vtCombResults AS (
	SELECT OrderYear AS [Year], CAST(OrderMonth AS NVARCHAR) AS [Month],
    SumPrice AS [Sum_Price], SUM(SumPrice) OVER (PARTITION BY OrderYear ORDER BY OrderMonth) AS [CumSum],
    OrderMonth AS SortMonth
    FROM vtMonthlyTotals
    UNION ALL
    SELECT OrderYear AS [Year], 'grand' AS [Month], NULL AS [Sum_Price], YearlySum AS [CumSum], 13 AS SortMonth
    FROM vtYearlyTotals
    )
SELECT [Year],[Month],[Sum_Price],[CumSum]
FROM vtCombResults
ORDER BY [Year], SortMonth;



---9
WITH vtEmployeeRank AS (
    SELECT d.Name AS DepartmentName,e.BusinessEntityID AS EmployeeID,
	       p.FirstName + ' ' + p.LastName AS EmployeeFullName,e.HireDate,
        DATEDIFF(MONTH, e.HireDate, GETDATE()) AS Seniority,
        LEAD(p.FirstName + ' ' + p.LastName) OVER (PARTITION BY d.Name ORDER BY e.HireDate DESC) AS PreviousEmpName,
        LEAD(e.HireDate) OVER (PARTITION BY d.Name ORDER BY e.HireDate DESC) AS PreviousEmpHireDate,
        ROW_NUMBER() OVER (PARTITION BY d.Name ORDER BY e.HireDate DESC) AS RowNum
    FROM HumanResources.Employee e
    JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
    JOIN HumanResources.Department d ON edh.DepartmentID = d.DepartmentID
    WHERE edh.EndDate IS NULL
    )
SELECT DepartmentName,EmployeeID,EmployeeFullName,HireDate,Seniority,PreviousEmpName,PreviousEmpHireDate,
    DATEDIFF(DAY, PreviousEmpHireDate, HireDate) AS DiffDays
FROM vtEmployeeRank
ORDER BY DepartmentName, RowNum;

---10
SELECT HireDate, DepartmentID, TeamEmployees
FROM (SELECT e.HireDate, edh.DepartmentID,
        REPLACE((SELECT ', ' + CAST(e2.BusinessEntityID AS VARCHAR(10)) + ' ' + p2.FirstName + ' ' + p2.LastName
            FROM HumanResources.Employee e2
            JOIN Person.Person p2 ON e2.BusinessEntityID = p2.BusinessEntityID
            JOIN HumanResources.EmployeeDepartmentHistory edh2 ON e2.BusinessEntityID = edh2.BusinessEntityID
            WHERE e2.HireDate = e.HireDate AND edh2.DepartmentID = edh.DepartmentID AND edh2.EndDate IS NULL
            FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), ', ', '') AS TeamEmployees
    FROM HumanResources.Employee e
    JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    JOIN HumanResources.EmployeeDepartmentHistory edh ON e.BusinessEntityID = edh.BusinessEntityID
    WHERE edh.EndDate IS NULL
    GROUP BY e.HireDate, edh.DepartmentID) AS vtEmployeeTeams
ORDER BY HireDate DESC, DepartmentID;

















