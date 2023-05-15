#Create database
create database hr_employee;
use hr_employee;

#Create table 
CREATE table employee(
    employee_id	INT,
    department	VARCHAR(30),
    region	CHAR(30),
    education	VARCHAR(30),
    gender	VARCHAR(2),
    recruitment_channel	VARCHAR(30),
    no_of_trainings	INT,
    age	INT,
    previous_year_rating	float,
    length_of_service	INT,
    KPIs_met_more_than_80	INT,
    awards_won	INT,
    avg_training_score	INT);

# describe table
select * from employee;
# Import data wizard :imported 17415 records

select count(*) from employee;

#Module2:
/*task1:Write an SQL query to solve the given problem statement.
Find the average age of employees in each department and gender group. 
( Round average  age up to two decimal places if needed)*/

select department, gender, round(avg(age),2) as average_age from employee group by department, gender;

/*task2:List the top 3 departments with the highest average training scores. 
( Round average scores up to two decimal places if needed)*/

SELECT department, round(avg(avg_training_score),2) as highest_average_training_scores 
from employee 
group by department
order by round(avg(avg_training_score),2) DESC limit 3 ;

/*task3: Find the percentage of employees who have won awards in each region. 
(Round percentages up to two decimal places if needed)*/

select region, round(count(*) * 100/ (select sum(awards_won) from employee),2) 
as award_percentage
from employee where awards_won!=0
group by region;

/*task4: Show the number of employees who have met more than 80% of KPIs for each recruitment channel and 
education level.*/

select department, round(avg(length_of_service),2) as average_length_of_service from employee 
where `previous_year_rating`>=4
group by department;

/*task5: Find the average length of service for employees in each department, considering only employees with
 previous year ratings greater than or equal to 4. ( Round average length up to two decimal places if needed)
*/

select department, round(avg(length_of_service),2) as average_length_of_service
from employee
where previous_year_rating>=4
group by department;

/*task6: List the top 5 regions with the highest average previous year ratings.*/
 
select region, round(avg(previous_year_rating),2) as highest_average_previous_year_rating
from employee
group by region
order by round(avg(previous_year_rating),2) DESC limit 5;

/*task7: List the departments with more than 100 employees having a length of service greater than 5 years.
*/

select department, count(KPIs_met_more_than_80)  as employee_count
from employee
where length_of_service >5
group by department
having count(KPIs_met_more_than_80) >100;


/*task8:Show the average length of service for employees who have attended more than 3 trainings, grouped by department and gender. 
( Round average length up to two decimal places if needed)
*/

select department,gender, round(avg(length_of_service),2) as average_length_of_service
from employee
where no_of_trainings > 3
group by department,gender;

/*task9: Find the percentage of female employees who have won awards, per department. Also show the number of female employees who won awards and total female employees.
 ( Round percentage up to two decimal places if needed)
*/

select department,
round((count(case when awards_won=1 then 1 end)*100)/ round (count(*) ,2),2)as female_award_winners_percentage,
sum(awards_won)as Female_won_award,
sum(gender='f')as Total_females
from employee where gender='f'
group by department;

/*task10:Calculate the percentage of employees per department who have a length of service between 5 and 10 years. 
( Round percentage up to two decimal places if needed)
*/

select department, 
round(count(case when length_of_service between 5 and 10 then 1 end)*100/count(*),2)
as service_percentage
from employee 
group by department;


/*task11:Find the top 3 regions with the highest number of employees who have met more than 80% of their KPIs and 
received at least one award, grouped by department and region.
*/

select department, region, count(*) as no_of_employee
from employee where KPIs_met_more_than_80=1 and awards_won >=1 
group by 1,2
order by 3
DESC limit 3;

/*task12:Calculate the average length of service for employees per education level and gender, considering only those
 employees who have completed more than 2 trainings and have an average training score greater than 75 
( Round average length up to two decimal places if needed)
*/

select education, gender, round(avg(length_of_service),2) as avg_length_of_service
from employee where no_of_trainings > 2 and avg_training_score > 75
group by education,gender;

/*task13:For each department and recruitment channel, find the total number of employees who have met more
 than 80% of their KPIs, have a previous_year_rating of 5, and 
have a length of service greater than 10 years.
*/

select department, recruitment_channel, count(*) as Total_employee
from employee where KPIS_met_more_than_80 =1 
and previous_year_rating=5 
and length_of_service > 10
group by department,recruitment_channel;

/*task14:Calculate the percentage of employees in each department who have received awards, have a
 previous_year_rating of 4 or 5, and an average training score above 70, grouped by department and gender
 ( Round percentage up to two decimal places if needed).
*/

select department, gender, 
round((count(case when awards_won=1 and previous_year_rating>=4 and avg_training_score>70 then 1 end)*100/count(*)),2)
as award_wining
from employee group by 1,2;

/*task15:List the top 5 recruitment channels with the highest average length of service for employees who have met more than 80% of their KPIs, have a previous_year_rating of 5, and an age between 25 and 45 years, grouped by department and recruitment channel. 
( Round average length up to two decimal places if needed).
*/

select department, recruitment_channel, round(avg(length_of_service),2) as avg_length
from employee where KPIs_met_more_than_80 =1 
and previous_year_rating = 5
and age between 25 and 45
group by 1,2
order by 3 
DESC limit 5;
