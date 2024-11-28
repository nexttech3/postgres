FROM postgres:16

# Instala extensões necessárias
RUN apt-get update && apt-get install -y \
    build-essential \
    postgresql-plpython3-16 \
    git && \
    git clone https://github.com/pgvector/pgvector.git /pgvector && \
    cd /pgvector && make && make install

# Adiciona script de inicialização
COPY init-db.sh /docker-entrypoint-initdb.d/

# Exposição da porta padrão do PostgreSQL
EXPOSE 5432
