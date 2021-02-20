defmodule SketchAscii.Box.Rectangle do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, Ecto.UUID, autogenerate: true}
  @all_fields [:width, :height, :fill, :outline]
  @required_fields [:width, :height]

  schema "rectangles" do
    field :width, :integer
    field :height, :integer
    field :fill, :binary
    field :outline, :binary
    field :coordinates, {:array, :integer}

    timestamps()
  end

  @doc false
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
  end
end
