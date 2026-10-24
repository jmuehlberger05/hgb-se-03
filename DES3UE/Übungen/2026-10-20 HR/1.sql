-- Bsp. 5
SELECT Department_Id, Job_Id, SUM(Salary)
FROM Employees
WHERE Department_Id < 60
GROUP BY CUBE (Department_Id, Job_Id);


-- Bsp. 6
SELECT Department_Id           Deptid,
       Job_Id                  Job,
       SUM(Salary),
       GROUPING(Department_Id) Grp_Dept,
       GROUPING(Job_Id)        Grp_Job
FROM Employees
WHERE Department_Id < 50
GROUP BY ROLLUP (Department_Id, Job_Id);