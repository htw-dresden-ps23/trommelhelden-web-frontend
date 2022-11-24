CONTAINER_FIRST_STARTUP="CONTAINER_FIRST_STARTUP"
if [ ! -e /$CONTAINER_FIRST_STARTUP ]; then
sleep 40
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Trommelhelden1 -d master -i init.sql 
fi