WITH MatriculasPorDia AS (
    SELECT
        s.name AS nome_escola,
        students.enrolled_at AS dia_matricula,
        COUNT(students.id) AS quantidade_alunos
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
        students.enrolled_at DESC
)
SELECT
    nome_escola,
    dia_matricula,
    quantidade_alunos,
    SUM(quantidade_alunos) OVER (PARTITION BY nome_escola ORDER BY dia_matricula ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS soma_acumulada,
    AVG(quantidade_alunos) OVER (PARTITION BY nome_escola ORDER BY dia_matricula ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS media_movel_7dias,
    AVG(quantidade_alunos) OVER (PARTITION BY nome_escola ORDER BY dia_matricula ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS media_movel_30dias
FROM
    MatriculasPorDia;