SELECT
    d.nome AS "Nome do Departamento",
    COUNT(e.matr) AS "Quantidade de Empregados",
    ROUND(COALESCE(AVG(v.valor), 0), 2) AS "Média Salarial",
    MAX(v.valor) AS "Maior Salário",
    MIN(v.valor) AS "Menor Salário"
FROM
    departamento d
LEFT JOIN empregado e ON d.cod_dep = e.lotacao
LEFT JOIN emp_venc ev ON e.matr = ev.matr
LEFT JOIN vencimento v ON ev.cod_venc = v.cod_venc
GROUP BY
    d.nome
ORDER BY
    "Média Salarial" DESC;