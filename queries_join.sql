1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name` AS nome_corso 
FROM `students`
INNER JOIN `degrees`
ON `students`.`degree_id` = `degrees`.id
WHERE `degrees`.`name` = "Corso di Laurea in Economia"

2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze
SELECT `degrees`.`id`, `degrees`.`name`AS nome_corso_di_laurea, `departments`.`name` AS nome_dipartimento
FROM `degrees`
INNER JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = "Dipartimento di Neuroscienze"

3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `teachers`.`name`, `teachers`.`surname`, `courses`.`name` AS nome_corso, `courses`.`description`, `courses`.`period`, `courses`.`year`, `courses`.`cfu` FROM `teachers`
INNER JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
WHERE `teachers`.`name` = "Fulvio"
AND `teachers`.`surname` = "Amato"

4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il
relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT `students`.`name`, `students`.`surname`, `degrees`.`name` AS nome_corsolaurea, `degrees`.`level`, `departments`.`name` AS nome_dipartimento 
FROM `students`
INNER JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
INNER JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`name`, `students`.`surname` ASC


5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT DISTINCT `teachers`.`name`, `teachers`.`surname`, `degrees`.`name` AS nome_corsolaurea, `courses`.`name` AS nome_materia 
FROM `teachers`
INNER JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`


6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
SELECT DISTINCT `teachers`.`name`, `teachers`.`surname`, `degrees`.`name` AS nome_corsolaurea, `courses`.`name` AS nome_materia 
FROM `teachers`
INNER JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
INNER JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
INNER JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
INNER JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = "Dipartimento di Matematica"
ORDER BY `teachers`.`name`, `teachers`.`surname`

7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per
superare ciascuno dei suoi esami

SELECT `students`.`name`, `students`.`surname`, `courses`.`name` AS nome_materia, `degrees`.`name` AS nome_corsolaurea, COUNT(`exam_student`.`vote`) AS tentativi
FROM `exams`
INNER JOIN `exam_student`
ON `exams`.`id` = `exam_student`.`exam_id`
INNER JOIN `students`
ON `students`.`id` = `exam_student`.`student_id`
INNER JOIN `degrees` 
ON `degrees`.`id` = `students`.`degree_id`
INNER JOIN `courses`
ON `courses`.`id` = `exams`.`course_id`
WHERE `exam_student`.`vote` < 18
GROUP BY `students`.`name`, `students`.`surname`, `courses`.`name`, `degrees`.`name`
ORDER BY tentativi DESC