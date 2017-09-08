CREATE ROLE read_only_access;

BEGIN
  FOR x IN (SELECT t.*
      FROM dba_tables t
        LEFT OUTER JOIN dba_external_tables et
          ON (t.owner = et.owner
          AND t.table_name = et.table_name)
      WHERE t.owner = '&&SCHEMA'
        AND t.iot_name IS NULL
        AND et.owner IS NULL)
  LOOP
    EXECUTE IMMEDIATE 'grant select on ' || x.owner || '.' || x.table_name || ' to read_only_access';
  END LOOP;
END;
/

BEGIN
  FOR x IN (SELECT *
      FROM dba_objects
      WHERE owner = '&&SCHEMA'
        AND object_type IN ('view'))
  LOOP
    EXECUTE IMMEDIATE 'grant select on ' || x.owner || '.' || x.object_name || ' to read_only_access';
  END LOOP;
END;
/
