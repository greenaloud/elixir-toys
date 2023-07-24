defmodule UserRegTest do
  use ExUnit.Case
  doctest UserReg

  test "greets the world" do
    assert UserReg.hello() == :world
  end
end
