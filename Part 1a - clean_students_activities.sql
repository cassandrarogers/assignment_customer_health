SELECT id
, student_id
,account_id
, resource_type
,score
,quiz_id
,etl_last_updated_ts
FROM (
 SELECT *
  , ROW_NUMBER() OVER (PARTITION BY
 id ORDER BY etl_last_updated_ts, account_id) AS row_number
 FROM students_activities
) AS ordered_data
WHERE ordered_data.row_number = 1
