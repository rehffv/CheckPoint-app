FROM haskell:9.6.7

WORKDIR /app

RUN apt-get update -o Acquire::Check-Valid-Until=false && \
    apt-get install -y --fix-missing \
        pkg-config \
        zlib1g-dev && \
    apt-get install -y --fix-missing -t bullseye libpq-dev || \
    apt-get install -y --fix-missing libpq-dev

COPY haskprojeto.cabal ./

RUN cabal update
RUN cabal build --only-dependencies

COPY . .

RUN cabal build

CMD ["cabal", "run", "haskprojeto"]