defmodule SketchAscii.Box do
  @moduledoc """
    Rectangle Contexts
  """
  import Ecto.Query, warn: false

  alias SketchAscii.Repo
  alias SketchAscii.Box.Rectangle

  @spec create_rectangle(map) :: {:error, atom | Ecto.Changeset.t()} | {:ok, Rectangle.t()}
  @spec update_rectangle(Rectangle.t(), %{optional(atom) => binary}) ::
          {:error, Ecto.Changeset.t()} | {:ok, Rectangle.t()}
  @spec get_rectangle_by_uuid(binary) :: {:error, any} | {:ok, Rectangle.t()}
  @spec list_rectangles() :: [Rectangle.t()]

  # TODO: refactor

  @doc """
    Create a new rectangle

    ## Example
        iex> create_rectangle(%{field: value})
        {:ok, %Rectangle{}}
        iex> create_rectangle(%{bad_field: value})
        {:error, %Ecto.Changeset{}}
  """
  def create_rectangle(attrs) do
    %Rectangle{}
    |> Rectangle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    Update a rectangle

    ## Example
        iex> update_rectangle(rectangle, %{field: new_value})
        {:ok, %Rectangle{}}
        iex> update_rectangle(rectangle, %{field: bad_value})
        {:error, %Ecto.Changeset{}}
  """
  def update_rectangle(rectangle, attrs) do
    rectangle
    |> Rectangle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
    Fetch a rectangle from the database by its uuid

    ## Example
      iex> get_rectangle_by_uuid("existing_uuid")
      {:ok, %Rectangle{}}
      iex> get_rectangle_by_uuid("non_existing_uuid")
      {:error, "error"}
  """
  def get_rectangle_by_uuid(uuid) when is_binary(uuid) do
    case Repo.get(Rectangle, uuid) do
      %Rectangle{} = rectangle ->
        {:ok, rectangle}

      _ ->
        {:error, "No rectangle with id: #{uuid} exists"}
    end
  end

  @doc """
    Fetches all rectangles in the database and returns a list of rectangle structs
  """
  def list_rectangles, do: Rectangle |> Repo.all()

  def draw(%Rectangle{} = rect) do
    # Get the vertical start coordinate
    [x, _] = rect.coordinates

    for _ <- 1..x, do: new_line()

    # Loop for each row (x-axis)
    for row <- 1..rect.height do
      # Calc the horizontal (x-axis) start coordinate
      calc_x_start_point(rect)
      # Loop for each column (y-axis)
      1..rect.width
      |> Enum.reduce("", fn column, acc ->
        acc <> get_char(rect, row, column)
      end)
      |> print()

      # Begin a new row
      new_line()
    end
  end

  defp calc_x_start_point(%Rectangle{coordinates: [_, y]}) do
    for _ <- 1..y, do: print()
  end

  defp new_line, do: IO.write("\n")

  defp print(text \\ " "), do: IO.write(text)

  defp get_char(%Rectangle{outline: outline, fill: fill}, _row, _column)
       when is_nil(outline) or outline == "",
       do: fill

  defp get_char(%Rectangle{outline: outline, fill: fill} = rect, row, column) do
    edge? = row == 1 or row == rect.height or column == 1 or column == rect.width
    if edge?, do: outline, else: fill
  end

  defp get_char(%Rectangle{fill: fill}, _row, _column), do: fill
end
