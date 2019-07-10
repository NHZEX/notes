## 数据备份

```bash
# gitea
echo $(date +%Y%m%d-%H%M%S) backup gitea start
docker exec -it gitea chown git:git /backup
docker exec -it -w /backup gitea su git -c "gitea dump"
find /backup/gitea -name "*.zip" -mtime +10 -exec rm -v {} \;

# yapi-mongo
echo $(date +%Y%m%d-%H%M%S) backup yapi-mongo start
docker exec -it mongo mongodump -h 127.0.0.1:27017 -d yapi --gzip --archive=/backup/yapi_$(date +%Y%m%d_%H%M%S).dump.gz
find /backup/mongo -name "*.dump.gz" -mtime +10  -exec rm -v {} \;

```