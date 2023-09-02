defmodule Sort do
  def descending([]), do: []
  def descending([a]), do: [a]
  def descending(list), do: merge_sort_descending(list)

  defp merge_sort_descending([]), do: []
  defp merge_sort_descending(list) do
    medium =  div(Enum.count(list), 2)
    { list_a, list_b } = Enum.split(list, medium)
    merge(descending(list_a), descending(list_b))
  end

  defp merge(list_a, []), do: list_a
  defp merge([], list_b), do: list_b
  defp merge([head_a|tail_a], list_b = [head_b|_tail_b]) when head_a > head_b do
    [head_a | merge(tail_a, list_b)]
  end
  defp merge(list_a = [head_a|_tail_a], [head_b|tail_b]) when head_a <= head_b do
    [head_b | merge(list_a, tail_b)]
  end
end
