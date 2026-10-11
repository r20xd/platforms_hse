# ДЗ1. Развертывание кластера hdfs


## Состав кластера

| Узел | IP | Роль |
|---|---|---|
| `team-13-nn` | `10.13.0.11` | NameNode |
| `team-13-en` | `10.13.0.10` | DataNode, SecondaryNameNode |
| `team-13-00` | `10.13.0.12` | DataNode |
| `team-13-01` | `10.13.0.13` | DataNode |

## Развертывание

Подключиться к edge-ноде со своего компьютера:

```bash
ssh team@111.88.130.231
```

На edge-ноде выполнить:

```bash
cd ~/platforms_hse/hw_1
bash deploy.sh
./start.sh
```

`deploy.sh` выдает права исполнения скриптам, скачивает и распаковывает Hadoop, устанавливает Java 11, настраивает имена узлов и конфигурацию на всех четырех машинах. NameNode форматируется только при отсутствии ранее созданных метаданных.

`start.sh` запускает NameNode, три DataNode и SecondaryNameNode.

## Проверка

На edge-ноде в каталоге проекта выполнить:

```bash
./status.sh
```

Если все выполняется успешно, то в списках процессов должны присутствовать NameNode на `team-13-nn`, SecondaryNameNode и DataNode на `team-13-en`, по одному DataNode на `team-13-00` и `team-13-01`, в отчете hdfs будет `Live datanodes (3)`, у всех узлов `Decommission Status : Normal`.