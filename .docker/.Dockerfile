FROM rust:latest as builder

WORKDIR /app

COPY Cargo.toml Cargo.lock ./
COPY build.rs ./
COPY src/ src/
COPY .husky/ .husky/

RUN cargo build --release

FROM debian:bullseye-slim

COPY --from=builder /app/target/release/bin /usr/local/bin/dev

ENTRYPOINT ["/usr/local/bin/your_binary"]
CMD ["--help"]