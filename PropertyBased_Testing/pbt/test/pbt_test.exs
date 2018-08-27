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
      Pbt.biggest(x) == models_biggest(x)
    end
  end

  property "pick the last number" do
    # Generar una lista de numeros y un numero que vamos a utilizar como el último
    forall({list, known_last} <- {list(number()), number()}) do
      # Agregar el número generado a la lista como el último
      known_list = list ++ [known_last]
      # Verificar que la funcion List.last trae el número que agregamos al final
      known_last == List.last(known_list)
    end
  end

  property "a sorted list has ordered pairs" do
    forall list <- list(term()) do
      is_ordered(Enum.sort(list))
    end
  end

  property "a sorted list keeps its size" do
    forall l <- list(term()) do
      length(l) == length(Enum.sort(l))
    end
  end

  property "no element add" do
    forall l <- list(term()) do
      sorted = Enum.sort(l)
      Enum.all?(sorted, fn element -> element in l end)
    end
  end

  property "no element drop" do
    forall l <- list(term()) do
      sorted = Enum.sort(l)
      Enum.all?(l, fn element -> element in sorted end)
    end
  end

  property "symmetric encoding/decoding" do
    forall(data <- list({atom(), any()})) do
      encoded = encode(data)
      is_binary(encoded) and data == decode(encoded)
    end
  end

  # Chapter 4
  property "find all keys in a map even when dupes are used", [:verbose] do
    forall kv <- list({key(), val()}) do
      m = Map.new(kv)
      for {k, _v} <- kv, do: Map.fetch!(m, k)

      uniques =
        kv
        |> List.keysort(0)
        |> Enum.dedup_by(fn {x, _} -> x end)

      collect(true, {:dupes, to_range(5, length(kv) - length(uniques))})
    end
  end

  property "collect 1", [:verbose] do
    forall bin <- binary() do
      collect(is_binary(bin), byte_size(bin))
    end
  end

  property "collect 2", [:verbose] do
    forall bin <- binary() do
      collect(is_binary(bin), to_range(10, byte_size(bin)))
    end
  end

  property "aggregate", [:verbose] do
    suits = [:club, :diamond, :heart, :spade]

    forall(hand <- vector(5, {oneof(suits), choose(1, 13)})) do
      aggregate(true, hand)
    end
  end

  property "fake scaping test showcasing aggregation", [:verbose] do
    forall str <- utf8() do
      aggregate(escape(str), classes(str))
    end
  end

  property "resize", [:verbose] do
    forall(bin <- resize(150, binary())) do
      collect(is_binary(bin), to_range(10, byte_size(bin)))
    end
  end

  property "profile 1", [:verbose] do
    forall(profile <- [name: resize(10, utf8()), age: pos_integer(), bio: resize(350, utf8())]) do
      name_len = to_range(10, String.length(profile[:name]))
      bio_len = to_range(300, String.length(profile[:bio]))
      aggregate(true, name: name_len, bio: bio_len)
    end
  end

  property "profile 2", [:verbose] do
    forall(
      profile <- [
        name: utf8(),
        age: pos_integer(),
        bio: sized(s, resize(s * 35, utf8()))
      ]
    ) do
      name_len = to_range(10, String.length(profile[:name]))
      bio_len = to_range(300, String.length(profile[:bio]))
      aggregate(true, name: name_len, bio: bio_len)
    end
  end

  property "naive queue genetarion" do
    forall(list <- list({term(), term()})) do
      q = :queue.from_list(list)
      :queue.is_queue(q)
    end
  end

  property "queue with let macro" do
    forall(q <- queue()) do
      q = :queue.from_list(list)
      :queue.is_queue(q)
    end
  end

  # Helpers
  defp boolean(_) do
    true
  end

  defp models_biggest(list) do
    List.last(Enum.sort(list))
  end

  def is_ordered([a, b | t]) do
    a <= b and is_ordered([b | t])
  end

  def is_ordered(_) do
    true
  end

  def to_range(m, n) do
    base = div(n, m)
    {base * m, (base + 1) * m}
  end

  defp escape(_), do: true

  defp classes(str) do
    l = letters(str)
    n = numbers(str)
    p = punctuation(str)
    o = String.length(str) - (l + n + p)

    [
      {:letters, to_range(5, l)},
      {:numbers, to_range(5, n)},
      {:punctuation, to_range(5, p)},
      {:others, to_range(5, o)}
    ]
  end

  def letters(str) do
    is_letter = fn c -> (c >= ?a && c <= ?z) || (c >= ?A && c <= ?Z) end
    length(for <<c::utf8 <- str>>, is_letter.(c), do: 1)
  end

  def numbers(str) do
    is_num = fn c -> c >= ?0 && c <= ?9 end
    length(for <<c::utf8 <- str>>, is_num.(c), do: 1)
  end

  def punctuation(str) do
    is_punctuation = fn c -> c in '.,;:\'"-' end
    length(for <<c::utf8 <- str>>, is_punctuation.(c), do: 1)
  end

  # Generators
  def encode(t), do: :erlang.term_to_binary(t)
  def decode(t), do: :erlang.binary_to_term(t)

  defp(type_generator()) do
    term()
  end

  defp key(), do: oneof([range(1, 10), integer()])
  defp val(), do: term()

  def queue() do
    let(list <- list({term(), term()})) do
      :queue.from_list(list)
    end
  end
end
