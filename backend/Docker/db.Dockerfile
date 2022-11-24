FROM mcr.microsoft.com/mssql/server:2017-latest-ubuntu
ENV ACCEPT_EULA Y
ENV sa_password trommelhelden
COPY ./init.sql .
COPY ./entrypoint.sh .
COPY ./run-initialization.sh .
EXPOSE 1433
CMD /bin/bash ./entrypoint.sh

