FROM haskell:9.6.7

WORKDIR /app

RUN apt-get update && apt-get install -y \
    libpq-dev \
    postgresql-client \
    pkg-config \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY haskprojeto.cabal ./

RUN cabal update
RUN cabal build --only-dependencies

COPY . .

RUN cabal build

CMD ["cabal", "run", "haskprojeto"]