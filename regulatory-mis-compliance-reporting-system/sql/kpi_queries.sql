SELECT month, AVG(compliance_score)
FROM kpi_table
GROUP BY month;