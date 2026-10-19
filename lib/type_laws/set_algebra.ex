defmodule TypeLaws.SetAlgebra do
  @moduledoc """
  The interface of a set-theoretic type domain, shaped after Elixir's
  `Module.Types.Descr`.

  Implementations:

    * `TypeLaws.IntSet` - sets of integers (the domain of the range analysis)
    * `TypeLaws.ElixirDescr` - adapter over Elixir's own type representation
    * `TypeLaws.Refined` - Elixir's types with `integer()` refined to an `IntSet`

  All of them are checked against the same algebraic laws
  (`test/types/set_laws_test.exs`). Because the suite is generic, it doubles
  as a test harness for Elixir's type system implementation.

  `member?/2` is the semantic oracle: types denote sets of values, and the
  laws relate the operations to set membership of concrete values.
  """

  @type t :: term()

  @doc "Builds a leaf of an `TypeLaws.Expr` type expression."
  @callback leaf(TypeLaws.Expr.t()) :: t
  @callback none() :: t
  @callback term() :: t
  @callback union(t, t) :: t
  @callback intersection(t, t) :: t
  @callback difference(t, t) :: t
  @callback negation(t) :: t
  @callback empty?(t) :: boolean()
  @callback subtype?(t, t) :: boolean()
  @callback equal?(t, t) :: boolean()
  @callback member?(t, value :: term()) :: boolean()
  @callback to_quoted_string(t) :: String.t()
end
