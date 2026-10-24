## 0.3.2

- No GitHub dependencies. The Mops registry no longer accepts them, and `encoding` (aviate-labs, v0.4.1) imported `mo:base-0.7.3`, which `mops sources` does not emit: every project that depended on candy needed a `--package base-0.7.3 ...` alias to build.
- `Hex.encode` from `encoding` is replaced by `src/hex.mo` (lowercase, two characters per byte, the same output).
- `map9` (GitHub v9.0.1) is now the Mops package `map` 9.0.1, whose source is identical. Imports are `mo:map/Map` and `mo:map/Set`.
- The libraries that exist on GitHub only are vendored under `src/vendored/`, unchanged except for their import paths (licenses in NOTICE): StableBuffer v1.3.0 (canscale) and v0.2.0 (skilesare), motoko-hash-map v7.0.0, motoko_candid v1.0.1 (`Type`, `Value`, `Arg` and what they import), motoko_numbers v1.0.2 (`FloatX`, `NatX`, `Util`), and the `types` modules of candy 0.1.12 and 0.2.0 that `upgrade.mo` converts from. The public types are structurally identical, so values and stable variables typed with 0.3.1 remain compatible.
- Dropped the unused `matchers` and `xtendedNumbers` dependencies (the legacy dfx test runner in `tests/` still imports `matchers`; the `mops test` suite in `test/` does not).
- Output is byte-identical to 0.3.1: 4,118 lines of test vectors (every single byte and longer byte strings through all ten hex call sites, plus 53 values covering every `CandyShared` variant through conversion, icrc16 conversion, JSON, Candid, hashing, cloning, workspace sizing, properties and the 0.1.12 -> 0.2.0 -> 0.3.0 upgrade paths) match under moc 2.0.0, interpreted and compiled. `mops test` passes 170/170 (moc 1.16.1), the same as 0.3.1.

## v0.3.1

- Added the /icrc16 folder and the conversions.mo file there to begin conversion to icrc16 reference.
- Conversions in /icrc16/conversion.mo generally return result types and should not throw.
- Added tests for /icrc16/conversion.mo
- Update Base

## v0.3.0

- Added the ValueShared type for dumping a Candy and CandyShared to an ICRC3 style Value type.
- Added many tests.