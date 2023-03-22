FROM mysql:latest 
RUN chown -R mysql:mysql /docker-entrypoint-initdb.d/:ro
COPY ./BucketList.sql / docker-entrypoint-initdb.d/
