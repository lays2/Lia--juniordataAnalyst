SELECT
    s.name AS nome_escola,
    students.enrolled_at AS dia_matricula,
    COUNT(students.id) AS quantidade_alunos,
    SUM(courses.price) AS valor_total_matriculas
FROM
    students
JOIN
    courses ON students.course_id = courses.id
JOIN
    schools s ON courses.school_id = s.id
WHERE
    courses.name LIKE 'data%'
GROUP BY
    s.name, students.enrolled_at
ORDER BY
    students.enrolled_at DESC;