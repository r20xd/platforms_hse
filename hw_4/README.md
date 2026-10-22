# ДЗ4. Apache Spark под управлением YARN

## Развертывание

HDFS, YARN, Metastore и HiveServer2 должны работать.

Подключиться к edge-ноде:

```bash
ssh team@111.88.130.231
```

На edge-ноде выполнить:

```bash
cd ~/platforms_hse/hw_4
bash deploy.sh
./start.sh
```

`deploy.sh` скачивает и распаковывает Spark. `start.sh` запускает приложение на YARN и после успешной записи регистрирует результат в Hive через Beeline.

## Обработка данных

`transform.py` создает SparkSession, читает CSV из `hdfs://team-13-nn:8020/user/hive/warehouse-external/hw_3/sales`, получает дату из каталогов партиций и выполняет:

- Преобразование суммы в INT, даты — в STRING.
- Удаление пробелов и приведение названий товаров к верхнему регистру.
- Фильтрацию продаж с положительной суммой.
- Агрегацию суммы и количества продаж по дате и товару.

Результат сохраняется в Parquet по пути `/user/team/hw_4/sales_summary` с партиционированием по `sale_date`. `table.sql` создает внешнюю таблицу `hw_4.sales_summary` и регистрирует партиции.

## Проверка

В выводе Spark должно быть YARN-приложение `application_...`, успешно завершившее запись. Проверить его статус:

```bash
~/hadoop-3.4.0/bin/yarn application -status <ID приложения>
```

Ожидаются состояние `FINISHED` и итоговый статус `SUCCEEDED`.

`start.sh` выполняет `SHOW PARTITIONS` и SELECT через стандартный клиент Hive — Beeline. Ожидаются две партиции и пять строк:

| sale_date | product | total_amount | sales_count |
|---|---|---|---|
| 2026-10-01 | BOOK | 300 | 2 |
| 2026-10-01 | PEN | 50 | 1 |
| 2026-10-02 | BOOK | 300 | 1 |
| 2026-10-02 | NOTEBOOK | 150 | 1 |
| 2026-10-02 | PEN | 70 | 1 |

Проверить каталоги партиций в HDFS:

```bash
~/hadoop-3.4.0/bin/hdfs dfs -ls -R /user/team/hw_4/sales_summary
```