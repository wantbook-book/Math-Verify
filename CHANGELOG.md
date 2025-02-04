# Changelog
## [0.4.2]
- Bump latex2sympy2_extended to 1.0.2

## [0.4.1]

### Added
- Fix bug with \boxed expressions. Boxed expression have no ending stopped so they will extract until }. This is fine as normalization will then extract the content. Issue was that if we have multiple of them, it would take all of them no matter whether they are connected or not. So "\boxed{1} ahhh no it's \boxed{2}" would be parsed as "\boxed{1,2}. This is now fixed.

## [0.4.0]

### Added
- Support for multiple expressions joined by "and"/"or" in latex parsing
- Support for comparing expressions with different variable names in non-strict mode
- Support for comparing E (euler's number) with symbol 'e'
- Support for comparing concatenated symbols (e.g., 'abc' vs 'a*b*c')
- Support for comparing relations with sets (e.g., '1 < x < 2' equals '(1,2)')
- Support for comparing tuples with sets
- Support for unwrapping function calls to their arguments
- Added new test files:
  - `test_numina_cases.py` for specific test cases
  - `test_open_thoughts.py` for additional test scenarios
  - `test_strict.py` for testing strict vs non-strict comparison modes

### Changed
- Improved latex parsing to handle multiple expressions
- Enhanced set comparison logic to handle more edge cases
- Renamed `sympy_deep_compare_finite_set` to `sympy_deep_compare_set_and_tuple`
- Updated `verify` function to support strict/non-strict comparison modes
- Modified timeout handling in parsing functions
- Improved documentation and type hints

### Fixed
- Fixed handling of percentage notation
- Fixed comparison of intervals with finite sets
- Fixed handling of boxed expressions with multiple values
- Fixed handling of text in latex expressions

### Removed
- Removed redundant `sympy_compare_set_interval` function
- Removed unnecessary string comparison in some cases 