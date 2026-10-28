# elixir_type_laws

Set-theoretic laws as data, checked against implementations of set
algebras: Elixir's own type system (`Module.Types.Descr`), a refinement
prototype on top of it, and `NxFixed.IntSet` (the integer domain of
nx_fixed's range analysis). It has found a correctness bug in Elixir
1.19.5 and slow cases in 1.18.3; 1.20.3 is clean.

## Pieces

| Module | Role |
|---|---|
| `TypeLaws.SetAlgebra` | Behaviour shaped after `Module.Types.Descr` |
| `TypeLaws.IntSet` | `NxFixed.IntSet` (integers as canonical unions of intervals) as a set algebra |
| `TypeLaws.ElixirDescr` | Adapter over Elixir's `Module.Types.Descr` |
| `TypeLaws.Refined` | Prototype: Descr with `integer()` refined to an `IntSet` |
| `TypeLaws.Expr` | Version-independent symbolic type expressions |
| `TypeLaws.Laws` | Lattice, complement, membership and congruence laws as data |
| `TypeLaws.Rewrite` | Meaning-preserving rewrites for congruence (metamorphic) tests |
| `TypeLaws.Minimize` | Delta debugging of failing cases |

A law fails if it does not hold, crashes, or exceeds the time budget
(1 s per case). Failing cases are shrunk and written as standalone scripts
to `_build/<env>/test/type_findings/`. Scripts for `ElixirDescr` only use
`Module.Types.Descr`, so they run with plain `elixir file.exs` on any
release and can be attached to an upstream issue.

## Running

```sh
mix test                          # IntSet laws only (fast)
mix test --only elixir_types      # Descr and Refined laws on the current Elixir
LAW_RUNS=1000 LAW_DEPTH=6 mix test --only elixir_types   # bigger and more cases

scripts/type_laws_matrix.sh 1.18.3-otp-27:27.3.3 1.19.5-otp-27:27.3.3 1.20.3-otp-29:29.0.2

# shrink a finding further, on the Elixir version that shows it
mix type_laws.minimize _build/test/type_findings/elixir_descr_double_negation.exs
```

`LAW_DEPTH` (default 4) bounds the nesting of generated types; at 6 they
average about 70 nodes.

## License

Apache-2.0, see `LICENSE`.
