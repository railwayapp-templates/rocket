# Build Stage
FROM rust:1.69 as builder
WORKDIR /usr/src/

# Create new rust project
RUN USER=root cargo new rust-rocket
WORKDIR /usr/src/rust-rocket

# Copy your Cargo.toml file
COPY ./Cargo.toml ./

# Copy the source code
COPY ./src ./src

# Build for release. 
RUN cargo build --release

# Runtime Stage
FROM debian:buster-slim

# Copy the binary from the build stage to the runtime stage
COPY --from=builder /usr/src/rust-rocket/target/release/rust-rocket /rust-rocket

# Run the binary.
CMD ["/rust-rocket"]
