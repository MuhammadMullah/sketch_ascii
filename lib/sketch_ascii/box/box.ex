defmodule SketchAscii.Box do
  @moduledoc """
    Box Contexts. Holds the business logic of working with the rectangle schema and function to draw a canvas
  """
  import Ecto.Query, warn: false

  alias SketchAscii.Repo
  alias SketchAscii.Box.Rectangle

  @doc """
    Create a new rectangle

    ## Example
        iex> create_rectangle(%{field: value})
        {:ok, %Rectangle{}}
        iex> create_rectangle(%{bad_field: value})
        {:error, %Ecto.Changeset{}}
  """
  @spec create_rectangle(map) :: {:error, atom | Ecto.Changeset.t()} | {:ok, Rectangle.t()}
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
  @spec update_rectangle(Rectangle.t(), %{optional(atom) => binary}) ::
          {:error, Ecto.Changeset.t()} | {:ok, Rectangle.t()}
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
  @spec get_rectangle_by_uuid(binary) :: {:error, any} | {:ok, Rectangle.t()}
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
  @spec list_rectangles() :: [Rectangle.t()]
  def list_rectangles, do: Rectangle |> Repo.all()

  @doc """
    Returns a drawing canvas for a rectangle
  """
  @spec draw(Rectangle.t()) :: binary()
  def draw(%Rectangle{} = rect) do
    # Get the vertical start coordinate
    [_, y] = rect.coordinates

    y_cord = duplicate("\n", y)

    # Loop for each row (x-axis)
    1..rect.height
    |> Enum.reduce(y_cord, fn row, acc_row ->
      # Calc the horizontal (x-axis) start coordinate
      current_x_cord = calc_x_start_point(rect)
      # Loop for each column (y-axis)
      current_row =
        1..rect.width
        |> Enum.reduce(current_x_cord, fn column, acc_col ->
          acc_col <> get_char(rect, row, column)
        end)

      # save current row
      acc_row <> current_row <> "\n"
    end)
  end

  defp calc_x_start_point(%Rectangle{coordinates: [x, _]}), do: duplicate(" ", x)

  defp get_char(%Rectangle{outline: outline, fill: fill}, _row, _column)
       when is_nil(outline) or outline == "",
       do: fill

  defp get_char(%Rectangle{outline: outline, fill: fill} = rect, row, column) do
    edge? = row == 1 or row == rect.height or column == 1 or column == rect.width

    if edge?, do: outline, else: fill
  end

  defp duplicate(char, times) do
    Enum.reduce(1..times, "", fn _, acc -> acc <> char end)
  end
end
