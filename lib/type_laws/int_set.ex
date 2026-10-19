defmodule TypeLaws.IntSet do
  @moduledoc """
  `NxFixed.IntSet` (sets of integers as unions of intervals, the domain of
  NxFixed's range analysis) as a `TypeLaws.SetAlgebra`, so the law suites
  check it like any other set algebra. Every function delegates.
  """
  @behaviour TypeLaws.SetAlgebra

  for {name, arity} <- NxFixed.IntSet.__info__(:functions) do
    args = Macro.generate_arguments(arity, __MODULE__)

    def unquote(name)(unquote_splicing(args)),
      do: NxFixed.IntSet.unquote(name)(unquote_splicing(args))
  end
end
