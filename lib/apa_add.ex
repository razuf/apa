defmodule ApaAdd do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Addition - ApaAdd.
  """
  import ApaNumber

  @doc """
  Addition - internal function - please call Apa.add(left, right)
  In reference to bcmath I call this functions bc_add
  """

  # first naiv impl only wiht integers
  def bc_add(left, right) when is_binary(left) and is_binary(right) do
    left = clean(left)
    right = clean(right)

    left_diff_count = diff_count(left, right)
    right_diff_count = diff_count(right, left)

    # TODO: take care about signs
    # first_left = String.first(left)
    # first_right = String.first(right)

    left_list =
      left
      |> fill_up_string_leading_zeros(left_diff_count)
      |> digits_list_reverse()

    right_list =
      right
      |> fill_up_string_leading_zeros(right_diff_count)
      |> digits_list_reverse()

    calc_partly(left_list, right_list, "")
  end

  def bc_add(left, right) do
    raise(ArgumentError, "No string input.\n
    left: #{inspect(left)}
    right: #{inspect(right)}
    ")
  end

  defp calc_partly(left_list, right_list, acc, overflow \\ 0)

  defp calc_partly([left_head | left_tail], [right_head | right_tail], acc, overflow) do
    part_sum = String.to_integer(left_head) + String.to_integer(right_head) + overflow

    calc_partly_part_sum(left_tail, right_tail, acc, part_sum)
  end

  defp calc_partly([], [], acc, overflow) when overflow > 0 do
    "#{overflow}#{String.reverse(acc)}"
  end

  defp calc_partly([], [], acc, _overflow) do
    "#{String.reverse(acc)}"
  end

  defp calc_partly_part_sum(left_tail, right_tail, acc, part_sum) when part_sum > 9 do
    calc_partly(left_tail, right_tail, append_acc(acc, part_sum - 10), 1)
  end

  defp calc_partly_part_sum(left_tail, right_tail, acc, part_sum) do
    calc_partly(left_tail, right_tail, append_acc(acc, part_sum), 0)
  end

  defp append_acc(acc, append_sum) do
    "#{acc}#{to_string(append_sum)}"
  end
end
