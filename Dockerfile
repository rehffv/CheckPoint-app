FROM haskell:9.6

RUN apt-get update && \
    apt-get install -y \
        pkg-config \
        zlib1g-dev \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY haskprojeto.cabal cabal.project ./

RUN cabal update
RUN cabal build --only-dependencies

COPY . .

RUN cabal build

CMD ["cabal", "run", "haskprojeto"]