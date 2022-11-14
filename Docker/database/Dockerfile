FROM mcr.microsoft.com/mssql/server:latest-ubuntu
ENV ACCEPT_EULA Y
ENV sa_password trommelhelden

COPY ./start.sql .
COPY ./setup_database.sh .
COPY ./entrypoint.sh .
EXPOSE 1433

CMD /bin/bash ./entrypoint.sh