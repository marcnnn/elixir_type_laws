defmodule TypeLaws.ElixirDescrLawsTest do
  @moduledoc """
  Runs the set-theoretic law suite against Elixir's own type representation
  (`Module.Types.Descr`, compiler-internal). A failure here is either a bug
  in the generators or a finding to report upstream.
  """
  use ExUnit.Case, async: true
  # Must come before `use SetLaws`: tags are captured when tests are defined.
  @moduletag :elixir_types
  use TypeLaws.Test.SetLaws, algebra: TypeLaws.ElixirDescr, max_runs: 100

  def types, do: TypeLaws.Test.TypeGen.descr_expr()
  def values, do: TypeLaws.Test.TypeGen.value()
end
