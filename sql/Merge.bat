del dist\*.sql
copy src\Create\CreateDatabase.sql + src\Create\DatabaseOptions.sql + src\Create\Use.sql dist\000-create.sql
copy src\DDL\*.sql dist\100-ddl.sql
copy src\FKS\*.sql dist\200-fks.sql
copy src\Code\Functions\*.sql + src\Code\Views\*.sql + src\Code\*.sql dist\300-code.sql
copy src\Data\InitialData\*.sql + src\Data\*.sql dist\400-data.sql
copy dist\*.sql dist\production.sql