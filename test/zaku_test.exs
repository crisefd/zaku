defmodule ZakuTest do
  use ExUnit.Case
  doctest Zaku

  test "greets the world" do
    assert Zaku.hello() == :world
  end
end
