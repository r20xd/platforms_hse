# ДЗ2. Развертывание YARN и публикация веб-интерфейсов

## Состав кластера

| Узел | IP | Роль |
|---|---|---|
| `team-13-nn` | `10.13.0.11` | ResourceManager, JobHistoryServer |
| `team-13-en` | `10.13.0.10` | NodeManager |
| `team-13-00` | `10.13.0.12` | NodeManager |
| `team-13-01` | `10.13.0.13` | NodeManager |

## Развертывание

HDFS из ДЗ1 должен быть запущен.

Подключиться к edge-ноде со своего компьютера:

```bash
ssh team@111.88.130.231
```

На edge-ноде выполнить:

```bash
cd ~/platforms_hse/hw_2
bash deploy.sh
./start.sh
```

`deploy.sh` выдает права исполнения скриптам, копирует конфигурации на четыре узла, создает каталоги NodeManager, истории заданий и логов.

`start.sh` запускает ResourceManager и JobHistoryServer на `team-13-nn`, три NodeManager на остальных узлах.

## Веб-интерфейсы

На локальном компьютере из каталога `hw_2` открыть SSH-туннель и оставить соединение работающим:

```bash
bash tunnel.sh -i <путь к SSH-ключу>
```

Скрипт перенаправляет локальные порты через edge-ноду к интерфейсам кластера.

| Интерфейс | URL | Скриншот |
|---|---|---|
| ResourceManager | http://localhost:8088/ | ResourceManager.jpg |
| NodeManager en | http://localhost:8042/ | NodeManagerEn.png |
| NodeManager 00 | http://localhost:8043/ | NodeManager00.png |
| NodeManager 01 | http://localhost:8044/ | NodeManager01.png |
| JobHistoryServer | http://localhost:19888/ | JobHistoryServer.jpg |
| NameNode | http://localhost:9870/ | NameNode.jpg |
| SecondaryNameNode | http://localhost:9868/ | SecondaryNameNode.png |
| DataNode en | http://localhost:9864/ | DataNodeEn.png |
| DataNode 00 | http://localhost:9865/ | DataNode00.png |
| DataNode 01 | http://localhost:9866/ | DataNode01.png |

## Проверка

На edge-ноде выполнить:

```bash
./status.sh
```

В списках процессов должны присутствовать ResourceManager и JobHistoryServer на `team-13-nn`, NodeManager на `team-13-en`, `team-13-00` и `team-13-01`. В отчете YARN — три узла со статусом `RUNNING`.