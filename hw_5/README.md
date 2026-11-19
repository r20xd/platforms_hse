# ДЗ5.
## Развертывание

Используются работающие HDFS и YARN из ДЗ1–ДЗ2, Hive из ДЗ3 и установленный Spark из ДЗ4. CSV таблицы `hw_3.sales` должны быть загружены в HDFS.

Подключиться к edge-ноде:

```bash
ssh team@111.88.130.231
```

На edge-ноде выполнить:

```bash
cd ~/platforms_hse/hw_5
bash deploy.sh && ./start.sh
```

`deploy.sh` устанавливает Prefect в `~/.venvs/hw_5`. `start.sh` берет настройки окружения из ДЗ4 и запускает поток `hw_5` с временным локальным сервером Prefect.

## Поток обработки

1. `spark-transform` запускает SparkSession через `spark-submit --master yarn`. Spark читает CSV из `hdfs://team-13-nn:8020/user/hive/warehouse-external/hw_3/sales`, приводит названия товаров к верхнему регистру, преобразует суммы в целые числа и отбирает положительные суммы. Затем считает сумму и количество продаж по каждому товару и записывает Parquet в `/user/team/hw_5/sales_by_product` в HDFS.
2. `publish-hive-table` после успешного завершения Spark создает через Beeline внешнюю таблицу `hw_5.sales_by_product` и выполняет `SELECT`.
