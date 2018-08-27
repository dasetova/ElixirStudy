defmodule Pbt do
  def biggest([head | tail]) do
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
end
