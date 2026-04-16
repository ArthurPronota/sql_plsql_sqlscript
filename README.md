# sql_plsql_sqlscript
Базы данных

## Пример ускорения выполнения запроса в 1000 раз в MySQL.

В файле [sql_statement.sql](https://github.com/ArthurPronota/sql_plsql_sqlscript/blob/main/sql_statement.sql) находится большое sql выражение которое медленно работает.

В файле [get_issuelog.sql](https://github.com/ArthurPronota/sql_plsql_sqlscript/blob/main/get_issuelog.sql) находится процедура выдающая результат аналогичный большому sql выражению [sql_statement.sql](https://github.com/ArthurPronota/sql_plsql_sqlscript/blob/main/sql_statement.sql) но работающему в 1000 раз быстрее за счёт разделения единого запроса на множество малых и выполнения всех выражений в ядре MySQL.

