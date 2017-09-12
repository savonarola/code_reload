defmodule CodeReloadTest do
  use ExUnit.Case
  doctest CodeReload

  test "greets the world" do
    assert CodeReload.hello() == :world
  end
end
