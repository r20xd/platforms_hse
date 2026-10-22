# ДЗ3. Развертывание Apache Hive

## Состав

Hive 4.0.0-alpha-2, Metastore, HiveServer2 и PostgreSQL размещаются на `team-13-en`. Метаданные хранятся в PostgreSQL, данные таблиц — в HDFS. Клиенты Beeline подключаются к общему HiveServer2, который обращается к отдельному Metastore по Thrift. Embedded Derby не используется.

## Развертывание

HDFS и YARN из ДЗ1 и ДЗ2 должны работать.

Подключиться к edge-ноде:

```bash
ssh team@111.88.130.231
```

На edge-ноде выполнить:

```bash
cd ~/platforms_hse/hw_3
bash deploy.sh
./start.sh
```

`deploy.sh` скачивает Hive, устанавливает PostgreSQL и JDBC-драйвер, копирует конфигурацию, создает каталоги HDFS, роль `hive`, базу `metastore` и схему метаданных.

`start.sh` запускает Metastore и HiveServer2. Проверить запуск:

```bash
./status.sh
```

Ожидаются процессы Metastore и HiveServer2, порты PostgreSQL 5432, Metastore 9083, HiveServer2 10000 и успешный вывод `SHOW DATABASES`.

## Загрузка данных

На edge-ноде из каталога `hw_3` выполнить:

```bash
./load.sh
```

Скрипт копирует два CSV-файла из `data/` в HDFS, создает внешнюю таблицу `hw_3.sales` с колонками `id`, `product`, `amount` и партицией `sale_date`, загружает данные командой `LOAD DATA`.

Ожидаются две партиции: `sale_date=2026-10-01` и `sale_date=2026-10-02`, по три строки в каждой.

## Несколько клиентов

Открыть два терминала, в каждом подключиться к edge-ноде и выполнить:

```bash
cd ~/platforms_hse/hw_3
source env.sh
beeline -u jdbc:hive2://team-13-en:10000/default -n team -p ''
```

Оставить обе сессии открытыми. В первой выполнить:

```sql
SELECT * FROM hw_3.sales WHERE sale_date='2026-10-01';
```

Во второй выполнить:

```sql
SELECT * FROM hw_3.sales WHERE sale_date='2026-10-02';
```

Оба клиента должны получить по три строки, оставаясь подключенными к одному HiveServer2.
