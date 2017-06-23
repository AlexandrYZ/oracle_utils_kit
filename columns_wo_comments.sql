set pagesize 5000
set linesize 300

select OWNER || '.' || TABLE_NAME || '.' || column_name "Columns without comments"
  from all_col_comments
 where owner = '&&OWNER'
   and comments is null
   and table_name not like 'BIN$%'
 order by table_name, column_name;
