FROM debian:11

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

COPY mariadb.cnf /etc/mysql/my.cnf

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT [ "./docker-entrypoint.sh", "mysqld_safe"]