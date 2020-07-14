<!-- markdownlint-disable -->
## Extending `build-harness` with targets from another repo

It is possible to extend the `build-harness` with targets and entire modules of your own, without having to fork or modify `build-harness` itself.
This might be useful if, for example, you wanted to maintain some tooling that was specific to your environment that didn't have enough general applicability to be part of the main project.
This makes it so you don't necessarily need to fork `build-harness` itself - you can place a repo defined by the environment variable `BUILD_HARNESS_EXTENSIONS_PATH` (a filesystem peer of `build-harness` named `build-harness-extensions` by default) and populate it with tools in the same `Makefile` within `module` structure as `build-harness` has.
Modules will be combined and available with a unified `make` command. 
<!-- markdownlint-restore -->
