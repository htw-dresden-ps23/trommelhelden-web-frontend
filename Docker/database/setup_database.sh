#!/usr/bin/env bash
# Wait for database to startup 
sleep 40
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Tromm3lh€ld€n -d master -i start.sql