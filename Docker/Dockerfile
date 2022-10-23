FROM mcr.microsoft.com/mssql/server

COPY start.sql start.sql
COPY setup_database.sh setup_database.sh
COPY entrypoint.sh entrypoint.sh

CMD /bin/bash ./entrypoint.sh