defmodule PbtTest do
  use ExUnit.Case
  use PropCheck
  doctest Pbt

  # Properties
  property "always work" do
    forall type <- type_generator() do
      boolean(type)
    end
  end

  property "biggest" do
    forall x <- non_empty(list(integer())) do
      biggest(x) == List.last(Enum.sort(x))
    end
  end

  # Helpers
  defp boolean(_) do
    true
  end

  defp biggest([head | tail]) do
    # Es el primero en ejecutarse, se asume la cabeza como el max
    biggest(tail, head)
  end

  defp biggest([], max) do
    max
  end

  defp biggest([head | tail], max) when head >= max do
    # Si la cabeza es mayor, ahora es el max para la próxima iteración
    biggest(tail, head)
  end

  defp biggest([head | tail], max) when head < max do
    # Si la cabeza es menor, simplemente se continua con la cola
    biggest(tail, max)
  end

  # Generators
  defp type_generator() do
    term()
  end

  test "greets the world" do
    assert Pbt.hello() == :world
  end
end
