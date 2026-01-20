FROM rust:1.76 as builder
WORKDIR /src
RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*
COPY . .
RUN cargo build -p epoxy-server --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /src/target/release/epoxy-server /app/epoxy-server
COPY config.template.toml /app/config.template.toml
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENV PORT=4000
ENTRYPOINT ["/app/entrypoint.sh"]
