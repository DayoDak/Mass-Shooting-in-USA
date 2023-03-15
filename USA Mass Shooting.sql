SELECT *
FROM shooting.shootings_2018;

SELECT *
FROM shooting.shootings_2019;

SELECT *
FROM shooting.shootings_2020;

SELECT *
FROM shooting.shootings_2021;

SELECT *
FROM shooting.shootings_2022;

CREATE TABLE combined_shootings AS
SELECT * FROM shooting.shootings_2018 
UNION ALL 
SELECT * FROM shooting.shootings_2019 
UNION ALL 
SELECT * FROM shooting.shootings_2020 
UNION ALL 
SELECT * FROM shooting.shootings_2021
UNION ALL 
SELECT * FROM shooting.shootings_2022;


SELECT *
FROM combined_shootings;

-- Shooting Incidence per State
SELECT State, sum(Dead) AS Total_dead, sum(Injured) AS Total_injured, sum(Total) AS Total_shooting
FROM combined_shootings
GROUP BY State
ORDER BY Total_shooting desc;

--	Shooting Incidence per year
 SELECT Year(Date) as Year, SUM(Dead) as Dead, SUM(Injured) as Injured, SUM(Total) as Total
 FROM combined_shootings
 GROUP BY Year

-- Month on Year Cases
SELECT DATE_FORMAT(Date, '%Y-%m') as Month, SUM(Dead) as Total_dead, SUM(Injured) as Total_injured, SUM(Total) as Total_cases
FROM combined_shootings
GROUP BY Month;

-- Shooting Cases on Holidays
CREATE TABLE holidays (
  date DATE, 
  name VARCHAR(255)
);

INSERT INTO holidays (date, name) VALUES
('2023-01-01', 'New Year''s Day'),
('2023-01-16', 'Martin Luther King Jr. Day'),
('2023-02-20', 'Presidents'' Day'),
('2023-05-29', 'Memorial Day'),
('2023-07-04', 'Independence Day'),
('2023-09-04', 'Labor Day'),
('2023-10-09', 'Columbus Day'),
('2023-11-11', 'Veterans Day'),
('2023-11-23', 'Thanksgiving Day'),
('2023-12-25', 'Christmas Day');

SELECT
  DATE_FORMAT(t1.Date, '%m-%d') AS date,
  COUNT(*) AS num_shootings,
  holidays.name AS holiday_name
FROM
  combined_shootings t1
  LEFT JOIN holidays ON DATE_FORMAT(t1.Date, '%m-%d') = DATE_FORMAT(holidays.date, '%m-%d')
GROUP BY
  DATE_FORMAT(t1.Date, '%m-%d'),
  holiday_name
  HAVING
  holiday_name != 'null'
ORDER BY num_shootings desc



