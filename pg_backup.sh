#!/bin/bash

# 备份存放位置
BACKUP_DIR=/var/lib/postgresql/data/backup/
# 如果不存在就创建
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi
cd $BACKUP_DIR

# 删除30天之前的备份
deleteDIR=$(date --date='30 day ago' +%Y-%m-%d)
rm -rf $deleteDIR

# 假设每天凌晨执行 备份数据文件夹名为昨日 yyyy-MM-dd 格式
dateDIR=$(date --date='1 day ago' +%Y-%m-%d)
mkdir $dateDIR

# 备份指定的数据库
backupDB=(postgres confluence)
backupDBArr=$(echo ${backupDB[@]})

# 使用压缩转储每一个数据库
for i in $backupDBArr; do
  pg_dump -U postgres $i | gzip > $BACKUP_DIR$dateDIR/${i}_${dateDIR}.gz
done
