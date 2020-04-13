defmodule ApaAdd do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - Addition - ApaAdd.
  """

  @doc """
  Addition - internal function - please call Apa.add(left, right)
  In reference to bcmath I call this functions bc_add
  """

  @spec bc_add(String.t(), String.t(), integer) :: String.t()
  def bc_add(left, right, scale \\ 0)

  def bc_add(left, right, scale) when is_binary(left) and is_binary(right) do
    {left_int, left_dec} = ApaNumber.from_string(left)
    {right_int, right_dec} = ApaNumber.from_string(right)

    bc_add({left_int, left_dec}, {right_int, right_dec}, scale)
  end

  @spec bc_add({integer, integer}, {integer, integer}, integer) :: String.t()
  def bc_add({left_int, left_dec}, {right_int, right_dec}, _scale)
      when left_dec > right_dec do
    {shifted_right_int, shifted_dec} = ApaNumber.shift({right_int, right_dec}, left_dec)

    ApaNumber.to_string({left_int + shifted_right_int, shifted_dec})
  end

  @spec bc_add({integer, integer}, {integer, integer}, integer) :: String.t()
  def bc_add({left_int, left_dec}, {right_int, right_dec}, _scale)
      when left_dec < right_dec do
    {shifted_left_int, shifted_dec} = ApaNumber.shift({left_int, left_dec}, right_dec)

    ApaNumber.to_string({shifted_left_int + right_int, shifted_dec})
  end

  @spec bc_add({integer, integer}, {integer, integer}, integer) :: String.t()
  def bc_add({left_int, left_dec}, {right_int, _right_dec}, _scale) do
    ApaNumber.to_string({left_int + right_int, left_dec})
  end

  def bc_add(left, right, scale) do
    raise(ArgumentError, "No string input.\n
    left: #{inspect(left)}
    right: #{inspect(right)}
    scale: #{inspect(scale)}
    ")
  end

  ################################################################################
  # first naive impl only with integers using reverse digit list like in school
  # its working in most cases but not very elegant and extensible

  @doc """
  Addition - internal function - please call Apa.add(left, right)
  """
  def bc_add_naive(left, right) when is_binary(left) and is_binary(right) do
    left = ApaNumber.clean(left)
    right = ApaNumber.clean(right)

    left_diff_count = ApaNumber.diff_count(left, right)
    right_diff_count = ApaNumber.diff_count(right, left)

    left_list =
      left
      |> ApaNumber.fill_up_string_leading_zeros(left_diff_count)
      |> ApaNumber.digits_list_reverse()

    right_list =
      right
      |> ApaNumber.fill_up_string_leading_zeros(right_diff_count)
      |> ApaNumber.digits_list_reverse()

    calc_partly(left_list, right_list, "")
  end

  def bc_add_naive(left, right) do
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
    "#{acc}#{Kernel.to_string(append_sum)}"
  end
end
