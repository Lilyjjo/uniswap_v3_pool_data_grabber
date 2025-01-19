default:
  @just --list

set dotenv-load
set fallback

default_env := 'local'
copy-env type=default_env:
  cp {{ type }}.env.example .env

# formatting command
fmt:
  cargo +nightly-2025-01-13 fmt --all

clippy:
 cargo clippy --all-targets --all-features \
          -- --warn clippy::pedantic --warn clippy::arithmetic-side-effects \
          --warn clippy::allow_attributes --warn clippy::allow_attributes_without_reason \
          --deny warnings

# Default log level
log_level := "info"

single_block block_number level=log_level:
  RUST_LOG={{level}} cargo run single-block --block-number {{ block_number }}

blocks_from start_block end_block level=log_level:
  RUST_LOG={{level}} cargo run blocks-from --start-block {{ start_block }} --end-block {{ end_block }}

live_blocks level=log_level:
  RUST_LOG={{level}} cargo run live-blocks
