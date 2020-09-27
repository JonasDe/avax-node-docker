FROM ubuntu:18.04
RUN apt-get update && apt-get install -y wget
WORKDIR /app
RUN wget https://github.com/ava-labs/avalanchego/releases/download/1.0.0-d/avalanchego-linux-1.0.0-d.tar.gz -O /app/avalanche.tar.gz
RUN tar -xzf /app/avalanche.tar.gz --one-top-level=/app/avalanche --strip-components=1
EXPOSE 9651 9650
CMD ["/app/avalanche/avalanchego", "-http-host", "0.0.0.0"]
