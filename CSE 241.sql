-- 1. Find buildings where a course is offered at least 3 times in the same room in that building
with building_list as (
    select building, course_id, room_number, count(section.course_id) as times_had
    from section 
    group by building, course_id, room_number
)
select distinct building
from building_list
where times_had > 2;

-- 2. Find Avg salary of instructors, sum of salaries, count of the total instructors
with salary_info as(
    select AVG(salary) as Average, SUM(salary) as Sum, COUNT(ID) as Total_Insntructors
    from instructor
)
select (Average-(Sum/Total_Insntructors)), Average
from salary_info;

-- 3. Find the id and title of math courses that are not a prerequisite of any other courses
--Need to find all math (Dept_name) classes, and then minus all courses that have a matching course id to a prereq id
select course_id, title
from course
where dept_name = 'Math'
minus
select course.course_id, title
from course, prereq
where course.course_id = prereq_id;
-- 4. Write a SQL query to find the id and title of course(s) with the maximum number of prerequisite courses.
with prereq_info as(
    select course_id, count(prereq_id) as num_prereq
    from prereq
    group by course_id
)
select course.course_id, course.title
from prereq_info, course
where num_prereq = (select max(num_prereq) from prereq_info)
and prereq_info.course_id = course.course_id;
-- 5. Write an SQL query using the university schema that finds the course(s) (showing course id and title) starting with ”The ” and do not have any prerequisite. Do this query using no subqueries and no set operations (use an outer join).
-- Find all classes in which the prereq is not null, and 
select course.course_id, title
from course full outer join prereq 
on prereq.course_id = course.course_id
where prereq_id IS NULL
and title like 'The %';
-- 6. Create three relations (refer to Appendix A for schema)
create table cssection (
    
)
