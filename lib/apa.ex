defmodule Apa do
  @moduledoc """
  APA : Arbitrary Precision Arithmetic - pure Elixir implementation.

  For arbitrary precision mathematics - which supports numbers of any size and precision
  up to nearly unlimited of decimals (internal Elixir integer math), represented as strings.
  This is especially useful when working with floating-point numbers,
  as these introduce small but in some case significant rounding errors.
  Inspired by BCMath/PHP.
  I started this project to learn for myself - so the focus was on learning and have fun!
  You could use it if you like - there are some test coverage -
  but for production I would recomend the Decimal (https://github.com/ericmj/decimal) package!

  The 'precision' of a ApaNumber is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point.
  The 'scale' of a ApaNumber is the count of decimal digits in the fractional part, to the right of the decimal point

  You are welcome to read the code and if you find something that could be done better, please let me know.
  """
  import Kernel, except: [abs: 1, max: 2, min: 2, rem: 2, round: 1]

  @precision_default Application.get_env(:apa, :precision_default, -1)
  @scale_default Application.get_env(:apa, :scale_default, -1)

  @doc """
  Creates a new ApaNumber tuple from an integer, string, float, or existing ApaNumber.
  See specific functions for documentation:
  from_string/1
  from_float/1
  from_integer/1

  ## Examples

    iex> Apa.new("3")
    {3, 0}
  """
  @spec new(term) :: {integer(), integer()} | :error
  def new(number) do
    Apa.parse(number)
  end

  @doc """
  Creates a new ApaNumber tuple from an integer, string, float, or existing ApaNumber.
  See specific functions for documentation:
  from_string/1
  from_float/1
  from_integer/1

  ## Examples

    iex> Apa.cast("3")
    {:ok, {3, 0}}

    iex> Apa.cast(:test_error)
    {:error, :test_error}
  """
  @spec cast(binary()) :: {:ok, {integer(), integer()}} | {:error, term()}
  def cast(number) when is_binary(number) do
    case from_string(number) do
      :error -> {:error, number}
      num -> {:ok, num}
    end
  end

  def cast(number) when is_integer(number) do
    case from_integer(number) do
      :error -> {:error, number}
      num -> {:ok, num}
    end
  end

  def cast(number) when is_float(number) do
    case from_float(number) do
      :error -> {:error, number}
      num -> {:ok, num}
    end
  end

  def cast({int, exp}) when is_integer(int) and is_integer(exp) do
    {:ok, {int, exp}}
  end

  def cast(any_input) do
    {:error, any_input}
  end

  @doc """
  Parses a new ApaNumber tuple from an integer, string, float, or existing ApaNumber.
  See specific functions for documentation:
  from_string/1
  from_float/1
  from_integer/1

  ## Examples

    iex> Apa.parse("3")
    {3, 0}
  """
  @spec parse(binary()) :: {integer(), integer()} | :error
  def parse(number) when is_binary(number) do
    Apa.from_string(number)
  end

  def parse(number) when is_integer(number) do
    from_integer(number)
  end

  def parse(number) when is_float(number) do
    from_float(number)
  end

  def parse({int, exp}) when is_integer(int) and is_integer(exp) do
    {int, exp}
  end

  def parse(any_input) do
    raise(ArgumentError, "Wrong input:
    input: #{inspect(any_input)}
    ")
  end

  # @spec parse(number) :: {integer, integer} | :error
  # def parse(number) do
  #   ApaNumber.parse(number)
  # end

  @doc """
  Creates a new ApaNumber tuple from an integer.
  signed integer are parsed.

  ## Examples

    iex> Apa.parse(3)
    {3, 0}
  """
  @spec from_integer(integer()) :: {integer(), integer()} | :error
  def from_integer(int) when is_integer(int) do
    {int, 0}
  end

  def from_integer(_int) do
    :error
  end

  @doc """
  Creates a new ApaNumber tuple from an float.
  Float first converted via Kernel.to_string/1 and then parsedIO.inspect(binding(), label: "### binding")
  Thats includes a precision limit during Kernel.to_string/1 - please look at docs there.

  ## Examples

    iex> Apa.from_float(-3.21)
    {-321, -2}
  """
  @spec from_float(float()) :: {integer(), integer()} | :error
  def from_float(float) when is_float(float) do
    Apa.parse(Kernel.to_string(float))
  end

  def from_float(_float) do
    :error
  end

  @doc """
  Parses a binary (number string) into an ApaNumber tuple.

  It works with signs, leading and trailing zeros and additional chars will be ignored.
  If successful, returns a tuple in the form of `{integer_value, exponent}`:

  Apa.from_string("+0003.00e+00000 Dollar")
  {3, 0}

  When the binary cannot be parsed, the atom `:error` will be returned.

  The limit only depends on the internal integers - because of Elixir "unlimited" integers  I would say "arbitrary".

  Used elixir source from Float module for parsing - nice source of inspiration! Thank you José!

  ## Examples

    iex> Apa.from_string("0003")
    {3, 0}

    iex> Apa.from_string("+0003")
    {3, 0}

    iex> Apa.from_string("-0003")
    {-3, 0}

    iex> Apa.from_string("-0000120.1200")
    {-12012, -2}

    iex> Apa.from_string("-0000120.1200")
    {-12012, -2}

    iex> Apa.from_string("-03 Euro")
    {-3, 0}

    iex> Apa.from_string("-0003e-2")
    {-3, -2}

    iex> Apa.from_string("-3e-0002")
    {-3, -2}

    iex> Apa.from_string("3e-12")
    {3, -12}

    iex> Apa.from_string("+0003e+12")
    {3, 12}

    iex> Apa.from_string("+0003e+00000")
    {3, 0}

    iex> Apa.from_string("+0003.00e+00000 Dollar")
    {3, 0}
  """
  @spec from_string(binary()) :: {integer(), integer()} | :error
  def from_string(binary) do
    ApaNumber.parse(binary)
  end

  @doc """
  Output an ApaNumber tuple as a binary (number string).

  ## Examples

    iex> Apa.to_string({3, 0})
    "3"

    iex> Apa.to_string({-3, -1})
    "-0.3"

  """
  @spec to_string({integer(), integer()}) :: binary() | :error
  def to_string({int, exp}) do
    ApaNumber.to_string({int, exp})
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Addition

  ## Examples

    iex> Apa.add("1", "2")
    "3"

    iex> Apa.add("1", "-2")
    "-1"

    iex> Apa.add("-1", "2")
    "1"

    iex> Apa.add("-1", "-2")
    "-3"

    iex> Apa.add("999989", "222222")
    "1222211"

    iex> Apa.add("222222", "999989")
    "1222211"

    iex> Apa.add("999", "999989")
    "1000988"

    iex> Apa.add("000000999", "0999989")
    "1000988"

    iex> "1" |> Apa.add("2") |> Apa.add("3.3") |> Apa.add("-3")
    "3.3"

    Compared to standard Elixir - wrong value 6.6!
    iex> 3.30000000000000004 + 3.30000000000000003
    6.6

    Correct with APA:
    iex> Apa.add("3.30000000000000004", "3.30000000000000003")
    "6.60000000000000007"

    iex> Apa.add("3.304","3.300003")
    "6.604003"

    iex> Apa.add("-3.304","-3.300003")
    "-6.604003"

    iex> Apa.add("-3.304","3.300003")
    "-0.003997"

    iex> Apa.add("3.304","-3.300003")
    "0.003997"

    iex> Apa.add("3","3.303")
    "6.303"

    iex> Apa.add("3.303","3")
    "6.303"

    iex> Apa.add("3.303","+003")
    "6.303"

    iex> Apa.add("1","+00120.000")
    "121"

    iex> Apa.add("1.0e2", "1.1")
    "101.1"
  """
  @spec add(String.t(), String.t(), integer(), integer()) :: String.t()
  def add(left, right, precision \\ @precision_default, scale \\ @scale_default)

  def add(left, right, precision, scale) do
    ApaAdd.bc_add(left, right, precision, scale)
  end

  @spec String.t() + String.t() :: String.t()
  def left + right when is_binary(left) and is_binary(right) do
    Apa.add(left, right)
  end

  @spec {integer(), integer()} + {integer(), integer()} :: {integer(), integer()}
  def {left_int, left_exp} + {right_int, right_exp}
      when is_integer(left_int) and is_integer(left_exp) and is_integer(right_int) and
             is_integer(right_exp) do
    ApaAdd.bc_add_apa_number(
      {left_int, left_exp},
      {right_int, right_exp}
    )
  end

  def left + right do
    Kernel.+(left, right)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Subtraction

  ## Examples

    iex> Apa.sub("3", "2")
    "1"

    iex> Apa.sub("2", "3")
    "-1"

    iex> Apa.sub("2", "+3")
    "-1"

    iex> Apa.sub("2", "-3")
    "5"

    iex> Apa.sub("-2", "3")
    "-5"

    iex> "1" |> Apa.sub("2") |> Apa.add("3.30") |> Apa.sub("2.40")
    "-0.1"

    Compared to standard Elixir - wrong value 0.0!
    iex> 3.30000000000000004 - 3.30000000000000003
    0.0

    this is fixed with APA:
    iex> Apa.sub("3.30000000000000004", "3.30000000000000003")
    "0.00000000000000001"
  """
  @spec sub(String.t(), String.t(), integer(), integer()) :: String.t()
  def sub(left, right, precision \\ @precision_default, scale \\ @scale_default)

  def sub(left, right, precision, scale) do
    ApaSub.bc_sub(left, right, precision, scale)
  end

  @spec String.t() - String.t() :: String.t()
  def left - right when is_binary(left) and is_binary(right) do
    Apa.sub(left, right)
  end

  @spec {integer(), integer()} - {integer(), integer()} :: {integer(), integer()}
  def {left_int, left_exp} - {right_int, right_exp}
      when is_integer(left_int) and
             is_integer(left_exp) and
             is_integer(right_int) and
             is_integer(right_exp) do
    ApaSub.bc_sub_apa_number(
      {left_int, left_exp},
      {right_int, right_exp}
    )
  end

  def left - right do
    Kernel.-(left, right)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Multiplication

  ## Examples

    iex> Apa.mul("3", "2")
    "6"

    iex> Apa.mul("2", "3")
    "6"

    iex> Apa.mul("2", "-3")
    "-6"

    iex> Apa.mul("-2", "3")
    "-6"

    iex> Apa.mul("-2", "-3")
    "6"

    iex> "1" |> Apa.mul("2") |> Apa.mul("3")
    "6"
  """
  @spec mul(String.t(), String.t(), integer(), integer()) :: String.t()
  def mul(left, right, precision \\ @precision_default, scale \\ @scale_default)

  def mul(left, right, precision, scale) do
    ApaMul.bc_mul(left, right, precision, scale)
  end

  @spec String.t() * String.t() :: String.t()
  def left * right when is_binary(left) and is_binary(right) do
    Apa.mul(left, right)
  end

  @spec {integer(), integer()} * {integer(), integer()} :: {integer(), integer()}
  def {left_int, left_exp} * {right_int, right_exp}
      when is_integer(left_int) and
             is_integer(left_exp) and
             is_integer(right_int) and
             is_integer(right_exp) do
    ApaMul.bc_mul_apa_number(
      {left_int, left_exp},
      {right_int, right_exp}
    )
  end

  @spec integer * integer :: integer
  @spec float * float :: float
  @spec integer * float :: float
  @spec float * integer :: float
  def left * right do
    Kernel.*(left, right)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Division

  ## Examples

    iex> Apa.div("6", "2")
    "3"

    iex> Apa.div("6", "3")
    "2"

    iex> Apa.div("6", "-3")
    "-2"

    iex> Apa.div("-6", "3")
    "-2"

    iex> Apa.div("-6", "-3")
    "2"

    iex> "18" |> Apa.div("2") |> Apa.div("3")
    "3"

    iex> Apa.div("222.2001", "2222.001")
    "0.1"
  """
  @spec div(String.t(), String.t(), integer(), integer()) :: String.t()
  def div(left, right, precision \\ @precision_default, scale \\ @scale_default)

  def div(left, right, precision, scale) do
    ApaDiv.bc_div(left, right, precision, scale)
  end

  @spec String.t() / String.t() :: String.t()
  def left / right when is_binary(left) and is_binary(right) do
    Apa.div(left, right)
  end

  @spec {integer(), integer()} / {integer(), integer()} :: {integer(), integer()}
  def {left_int, left_exp} / {right_int, right_exp}
      when is_integer(left_int) and
             is_integer(left_exp) and
             is_integer(right_int) and
             is_integer(right_exp) do
    ApaDiv.bc_div_apa_number(
      {left_int, left_exp},
      {right_int, right_exp}
    )
  end

  # @spec number / number :: float
  def left / right do
    Kernel./(left, right)
  end

  #
  @doc """
  APA : Arbitrary Precision Arithmetic - Comparison - ApaComp

  Compares the left_operand to the right_operand and returns the result as an integer.

  left - the left operand, as a string.
  right - the right operand, as a string.

  The 'precision' of a ApaNumber is the total count of significant digits in the whole number, that is, the number of digits to both sides of the decimal point.
  The 'scale' of a ApaNumber is the count of decimal digits in the fractional part, to the right of the decimal point

  Returns:
   0 if the two operands are equal,
   1 if the left_operand is larger than the right_operand,
   -1 otherwise.

  ## Examples

    iex> Apa.comp("9", "3")
    1

    iex> Apa.comp("3", "9")
    -1

    iex> Apa.comp("999999999999999999999999999","999999999999999999999999999")
    0

    iex> Apa.comp("0","0")
    0

    iex> Apa.comp("+0","-0")
    0

    iex> Apa.comp("-0","-0")
    0

    iex> Apa.comp("+1","-1")
    1

    iex> Apa.comp("1.0","1.0")
    0

    iex> Apa.comp("-1","-1.0")
    0

    Compared to standard Elixir this is fixed with APA - it is -1 !!!
    iex> Apa.comp("12","12.0000000000000001")
    -1

    Compared to standard Elixir this is fixed with APA - it is 1 !!!
    iex> Apa.comp("3.30000000000000004", "3.30000000000000003")
    1

    iex> Apa.comp("1.1", "1.0")
    1

    iex> Apa.comp("1.0", "1.1")
    -1

    iex> Apa.comp("1.0", "1.1", 0, 1)
    -1

    iex> Apa.comp("1.0", "1.1", 0, 0)
    0
  """
  @spec comp(String.t(), String.t(), integer(), integer()) :: integer() | Exception
  def comp(left, right, precision \\ @precision_default, scale \\ @scale_default)

  def comp(left, right, precision, scale) do
    ApaComp.bc_comp(left, right, precision, scale)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - absolut value

  ## Examples

    iex> Apa.abs({3, 0})
    {3, 0}

    iex> Apa.abs({-3, 0})
    {3, 0}

    iex> Apa.abs({-3, -3})
    {3, -3}
  """
  @spec abs({integer(), integer()}) :: {integer(), integer()}
  def abs({int, exp}) when is_integer(int) and is_integer(exp) do
    {abs(int), exp}
  end

  @spec abs(integer()) :: integer()
  @spec abs(float()) :: float()
  def abs(value) do
    Kernel.abs(value)
  end

  @doc """
  APA : Arbitrary Precision Arithmetic - Homage to Douglas Adams

  The Answer to the Ultimate Question of Life, the Universe, and Everything

  ## Examples

    iex> Apa.answer("Ultimate Question of Life, the Universe, and Everything")
    "42"

    iex> Apa.answer("Das Leben, das Universum und der ganze Rest")
    "42"

    iex> Apa.answer("six by nine")
    "forty two"
  """
  @spec answer(String.t()) :: String.t()
  def answer("Ultimate Question of Life, the Universe, and Everything") do
    "42"
  end

  def answer("Das Leben, das Universum und der ganze Rest") do
    "42"
  end

  def answer("six by nine") do
    "forty two"
  end
end
