defmodule Sort do
  def ascending([]), do: []
  def ascending([a]), do: [a]
  def ascending(list) do
    half_size = div(Enum.count(list), 2)
    {list_a, list_b} = Enum.split(list, half_size) # We need to sort list_a and list_b
    sorted_a = ascending(list_a)
    sorted_b = ascending(list_b)
    merge(sorted_a, sorted_b)
  end

  defp merge(list_a, list_b) do
    get_sorted_from_two_lists([], list_a, list_b)
  end

  defp get_sorted_from_two_lists(sorted, [], []) do
    sorted
  end
  defp get_sorted_from_two_lists(sorted, [head|tail], []) do
    get_sorted_from_two_lists(sorted ++ [head], tail, [])
  end
  defp get_sorted_from_two_lists(sorted, [], [head|tail]) do
    get_sorted_from_two_lists(sorted ++ [head], [], tail)
  end
  defp get_sorted_from_two_lists(sorted, list_a=[head_a|tail_a], list_b=[head_b|tail_b]) do
    case head_a <= head_b do
      true -> get_sorted_from_two_lists(sorted ++ [head_a], tail_a, list_b)
      _ -> get_sorted_from_two_lists(sorted ++ [head_b], list_a, tail_b)
    end
  end
end
