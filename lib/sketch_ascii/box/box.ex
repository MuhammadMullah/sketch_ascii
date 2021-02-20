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


  def get_rectangle_by_uuid(uuid) when is_binary(uuid) do
    case Repo.get(Rectangle, uuid) do
      %Rectangle{} = rectangle ->
        {:ok, rectangle}
      _ ->
        {:error, "No rectangle with id: #{uuid} exists"}
    end
  end
end
