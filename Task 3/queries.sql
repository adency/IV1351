/**
* This view Joins the ensamble and lesson table where the lesson.lesson_id and ensamble.lesson_id are
* the same, then checks for all the ensamble lesson whos start date is between tomorrow and less than the 
* the current date + 7 days. It then outputs the result in the following format:
    
    day           | genre       | no of free seats
    -----------------------------------------------
    2025-02-25    | Classical   | Many Seats
    2024-12-15    | Jazz        | Many Seats
    2025-02-05    | Jazz        | Many Seats
    2025-01-10    | Rock        | Many Seats
    2025-01-25    | Rock        | Many Seats
*
* you might need to adjust WHERE lesson.date >= (CURRENT_DATE + 1) AND lesson.date <= (CURRENT_DATE + 7)
* to get relevant output.
*/
-- View: public.ensemble_this_week

-- DROP VIEW public.ensemble_this_week;

CREATE OR REPLACE VIEW public.ensemble_this_week
 AS
 SELECT lesson.date AS day,
    ensemble.genre,
        CASE
            WHEN (ensemble.max_students - count(lesson_students.student_id)) = 0 THEN 'No Seats'::text
            WHEN (ensemble.max_students - count(lesson_students.student_id)) <= 2 THEN '1 or 2 Seats'::text
            ELSE 'Many Seats'::text
        END AS no_of_free_seats
   FROM lesson
     JOIN ensemble ON lesson.lesson_id = ensemble.lesson_id
     LEFT JOIN lesson_students ON lesson.lesson_id = lesson_students.lesson_id
  WHERE lesson.date >= (CURRENT_DATE + 1) AND lesson.date <= (CURRENT_DATE + 7)
  GROUP BY lesson.date, ensemble.genre, ensemble.max_students
  ORDER BY ensemble.genre, lesson.date;

ALTER TABLE public.ensemble_this_week
    OWNER TO postgres;




-- View: public.instructors_lesson_count

/**
* This view aggregates the amount of lessons each instructor is booked for 
* each month. The output for this month should be:
    instructor_id | first_name | last_name  | no_of_lessons
    -------------------------------------------------------
    6             | Len        | Merritt    | 1
    7             | Rachel     | Natalie    | 1
    8             | Darius     | Rose       | 1
    9             | Xaviera    | Helen      | 1
    10            | Dara       | Hakeem     | 1
*
*
*/

-- DROP VIEW public.instructors_lesson_count;

CREATE OR REPLACE VIEW public.instructors_lesson_count
 AS
 SELECT instructor.instructor_id,
    person.first_name,
    person.last_name,
    count(lesson.lesson_id) AS no_of_lessons
   FROM instructor
     JOIN person ON instructor.person_id = person.person_id
     JOIN lesson ON instructor.instructor_id = lesson.instructor_id
  WHERE EXTRACT(month FROM lesson.date) = EXTRACT(month FROM CURRENT_DATE) AND EXTRACT(year FROM lesson.date) = EXTRACT(year FROM CURRENT_DATE)
  GROUP BY instructor.instructor_id, person.first_name, person.last_name
 HAVING count(lesson.lesson_id) > 0 --change this to adjust the lesson threshold.
  ORDER BY (count(lesson.lesson_id)) DESC;

ALTER TABLE public.instructors_lesson_count
    OWNER TO postgres;



-- View: public.lessons_per_month_2024
/**
* This view list the total amount of lesson for each month during a specific year,
* it also list the amount for each specific sub lesson. The output should look like this:
    month      | total_lessons | individual_lessons | ensemble_lessons
    -------------------------------------------------------------------
    2024-11    | 5             | 2                  | 0
    2024-12    | 5             | 2                  | 0
*
*
*/
-- DROP VIEW public.lessons_per_month_2024;

CREATE OR REPLACE VIEW public.lessons_per_month_2024
 AS
 SELECT to_char(date::timestamp with time zone, 'YYYY-MM'::text) AS month,
    count(*) AS total_lessons,
    sum(
        CASE
            WHEN lesson_type::text = 'individual'::text THEN 1
            ELSE 0
        END) AS individual_lessons,
    sum(
        CASE
            WHEN lesson_type::text = 'group'::text THEN 1
            ELSE 0
        END) AS group_lessons,
    sum(
        CASE
            WHEN lesson_type::text = 'ensemble'::text THEN 1
            ELSE 0
        END) AS ensemble_lessons
   FROM lesson
  WHERE EXTRACT(year FROM date) = 2024::numeric
  GROUP BY (to_char(date::timestamp with time zone, 'YYYY-MM'::text))
  ORDER BY (to_char(date::timestamp with time zone, 'YYYY-MM'::text))





-- View: public.no_siblings
/*
* This goes through the guardian_student table and creates a new table where each primary_student is
* matched to any other student_id it shares a guardian_id with, it then counts the amount of siblings each
* primary_student has. The output should look like the following:
    no_of_siblings | no_of_students
    -------------------------------
    0              | 2
    1              | 2
    2              | 1
    3              | 4
*
*
*
*/

-- DROP VIEW public.no_siblings;

CREATE OR REPLACE VIEW public.no_siblings
 AS
 SELECT no_of_siblings,
    count(*) AS no_of_students
   FROM ( SELECT shared_students.student_id,
            count(DISTINCT primary_student.student_id) - 1 AS no_of_siblings
           FROM guardian_student shared_students
             LEFT JOIN guardian_student primary_student ON shared_students.guardian_id = primary_student.guardian_id
          GROUP BY shared_students.student_id) sibling_counts
  GROUP BY no_of_siblings
  ORDER BY no_of_siblings;

ALTER TABLE public.no_siblings
    OWNER TO postgres;
