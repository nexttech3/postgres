# Use a imagem oficial do PostgreSQL como base
FROM postgres:16

# Instale o TimescaleDB
RUN apt-get update && \
    apt-get install -y gnupg && \
    echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/timescaledb.list && \
    curl -L https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add - && \
    apt-get update && \
    apt-get install -y timescaledb-2-postgresql-16

# Instale o pgvector
RUN git clone https://github.com/pgvector/pgvector.git /pgvector && \
    cd /pgvector && \
    make && make install

# Instale o PL/Python3
RUN apt-get install -y postgresql-plpython3-16

# Copie o script de inicialização para o contêiner
COPY init-db.sh /docker-entrypoint-initdb.d/
