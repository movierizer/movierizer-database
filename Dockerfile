FROM postgres:16

EXPOSE 5432

COPY planDatabase.sql /docker-entrypoint-initdb.d/