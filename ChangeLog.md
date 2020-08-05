# Changelog for bf

## Unreleased changes

## 0.1.1.0 - 2020-08-05
### Added
- Ability to recognize command-line args
- Ability to run under non-default configurations
- Ability to read program from a file
### Changed
- `Config` now has a field `source :: Maybe FilePath`
- `BF.brainfuck` now takes a `Config` as a first argument
- Changlog now lists changes from initial commit

## 0.1.0.0 - 2020-08-04
### Added
- Ability to parse and interpret brainfuck supplied on stdin
