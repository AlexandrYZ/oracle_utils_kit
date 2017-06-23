set pagesize 5000
set linesize 300

select OWNER || '.' || TABLE_NAME "Tables without comments"
from all_tab_comments
where owner = '&&OWNER'
  and comments is null
  and table_name not like 'BIN$%'
ORDER BY TABLE_NAME;
