FROM haskell:9.6.7-slim-bullseye

RUN apt-get update && \
    apt-get install -y \
        libpq-dev \
        pkg-config \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY haskprojeto.cabal ./

RUN cabal update
RUN cabal build --only-dependencies

COPY . .

RUN cabal build

CMD ["cabal", "run", "haskprojeto"]