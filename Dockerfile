
##FROM haskell:9.6.7

##WORKDIR /app

# Copia os arquivos de configuração primeiro
##COPY haskprojeto.cabal ./
##COPY cabal.project.local ./

# Atualiza o cabal e baixa dependências
##RUN cabal update
##RUN cabal build --only-dependencies

# Copia o resto do projeto
##COPY . .

# Compila o projeto
##RUN cabal build

# Roda o servidor
##CMD cabal run

FROM haskell:9.6.7

WORKDIR /app

# Dependências necessárias para postgresql-simple
RUN apt-get update && apt-get install -y \
    libpq-dev \
    postgresql-client \
    pkg-config \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY haskprojeto.cabal ./
COPY cabal.project.local ./

RUN cabal update
RUN cabal build --only-dependencies

COPY . .

RUN cabal build

EXPOSE 8080

CMD ["cabal", "run", "haskprojeto"]
