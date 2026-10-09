# Changelog

All notable changes to this project are documented here. Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/); versions follow [SemVer](https://semver.org/).

## [Unreleased]

### Added
- Repository skeleton: datapack and resource pack (`pack.mcmeta` for 26.3, formats 121.0 / 97.1).
- Idempotent `euchre:load`, near-zero-cost `euchre:tick`, `euchre:selftest`.
- `tools/gen.py` (generated card table, hotbar helpers), `tools/lint.py`, `tools/build.py`.
- CI: lint, PackTest suite on Fabric 26.3, vanilla server smoke test. Tag-triggered release workflow.
