# sql_plsql_sqlscript
Базы данных

<a name="example_01"><h2>Пример ускорения выполнения запроса в 1000 раз в MySQL.</h2></a>

В файле [sql_statement.sql](https://github.com/ArthurPronota/sql_plsql_sqlscript/blob/main/sql_statement.sql) находится большое sql выражение которое медленно работает.

В файле [get_issuelog.sql](https://github.com/ArthurPronota/sql_plsql_sqlscript/blob/main/get_issuelog.sql) находится процедура, выдающая результат, аналогичный большому sql выражению [sql_statement.sql](https://github.com/ArthurPronota/sql_plsql_sqlscript/blob/main/sql_statement.sql), но работающему в 1000 раз быстрее за счёт разделения единого запроса на множество малых и выполнения всех выражений в ядре MySQL.

Выгоды такого подхода:
  - ERP система стала работать значительно быстрее
  - Нет необходимости каждый год покупать более мощный сервер для MySQL

[example_01][#example_01]
