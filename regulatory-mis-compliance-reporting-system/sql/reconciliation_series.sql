SELECT *
FROM source_data s
LEFT JOIN final_report f
ON s.id=f.id
WHERE s.amount<>f.amount;