# Mass Shooting in USA

![Headline exact](gun-violence-1.jpg)
Gun violence in the United States include mass shootings, homicides, suicides, and accidental shootings. From the data, U.S.A. recorded a total number of 694 cases of mass shooting with 2,836 injured and 701 dead in 2021. The number of people killed or injured in these incidents can vary widely, but the impact on individuals, families, and communities is often devastating.

A comprehensive dataset of 2356 rows was gotten from the Kaggle database and analysed to get insights into the pattern of gun violence in the USA over the period of 5 years ranging from from 2018 - 2022.

The causes of gun violence in the United States are complex and multifaceted, and there is no single solution that will eliminate the problem entirely. Factors that contribute to gun violence include easy access to firearms, social and economic inequality, mental illness, and a culture of violence and aggression.

## Problem Statements
- Which year has the most recorded mass shooting incidence?
- Which state has the highest gun violence victims?
- How many shooting incidence happened on Holidays?
- What is the monthly trends of mass shooting incidence?

## Analysis
The Mass shooting dataset was gotten from kaggle. SQl was the tool of choice used to clean, process and interact with the 2,356 rows of data. Attached [here](https://github.com/DayoDak/Mass-Shooting-in-USA/blob/73324fda979f29a7c8557a26d7d4de44942581a1/USA%20Mass%20Shooting.sql) is the sql file used to querry the data and below is a selected summary screenshots of the querries used. 👇  
```sql
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
```

## Visualisation
Tableau was used for the visualisation of the insights gotten from the dataset. The visual was spread across the Bar, Map, Radial and line graph charts. An interactive minimalist [dashboard](https://public.tableau.com/views/MassShootinginUSA_16784575287990/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link) was designed to answer different questions that comes to mind, cool right 🙈

Here is what to expect 👇
![](Mass_Shooting_Dashboard2.png)

## Conclusions and Recommendations
- There's been an exponential increase in Gun violence in the United States over the years.
- Illinios and Texas has the highest gun violence incidence in the country.

Overall, gun violence remains a complex and multifaceted issue in the United States, and addressing it will require a comprehensive approach that addresses both the availability of firearms and the underlying social and economic factors that contribute to violence.
Stricter gun control laws and evaluation of mental health are necessary to prevent mass shootings and reduce overall levels of gun violence in the country.

Efforts should be made to address the root causes of gun violence, such as poverty, mental illness, and social isolation. These efforts must include improving access to mental health services, reducing economic inequality, and increasing funding for community programs that promote social connection and support.
