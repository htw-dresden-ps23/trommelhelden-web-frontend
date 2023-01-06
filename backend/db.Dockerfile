FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu
ENV ACCEPT_EULA Y
ENV sa_password trommelhelden
COPY ./Docker/init.sql .
COPY ./Docker/entrypoint.sh .
COPY ./Docker/run-initialization.sh .
EXPOSE 1433
CMD /bin/bash ./entrypoint.sh

