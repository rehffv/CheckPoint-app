FROM haskell:9.6

RUN apt-get update && \
    apt-get install -y pkg-config zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY haskprojeto.cabal ./

RUN cabal update
RUN cabal build --only-dependencies --constraint="postgresql-libpq +bundled-libpq"

COPY . .

RUN cabal build --constraint="postgresql-libpq +bundled-libpq"

CMD ["cabal", "run", "haskprojeto"]