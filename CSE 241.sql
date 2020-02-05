  
-- Find buildings where a course is offered at least 3 times in the same room in that building
with building_list as (
    select building, course_id, room_number, count(section.course_id) as times_had
    from section 
    group by building, course_id, room_number
)
select distinct building
from building_list
where times_had > 2;

-- Find Avg salary of instructors, sum of salaries, count of the total instructors
with salary_info as(
    select AVG(salary) as Average, SUM(salary) as Sum, COUNT(ID) as Total_Insntructors
    from instructor
)
select (Average-(Sum/Total_Insntructors)), Average
from salary_info;

--Find the id and title of math courses that are not a prerequisite of any other courses
--Need to find all math (Dept_name) classes, and then minus all courses that have a matching course id to a prereq id
select course_id, title
from course
where dept_name = 'Math'
minus
select course.course_id, title
from course, prereq
where course.course_id = prereq_id;
--Create three relations (refer to Appendix A for schema):

