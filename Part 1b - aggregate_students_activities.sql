WITH clean_students_activities AS
(
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
  )
  
Select resource_type, 
count(DISTINCT student_id) as num_students,
ROUND(avg(score),2) as mean_score,
min(etl_last_updated_ts) as min_etl_update,
max(etl_last_updated_ts) as max_etl_update
from clean_students_activities
Group by resource_type
  
  
