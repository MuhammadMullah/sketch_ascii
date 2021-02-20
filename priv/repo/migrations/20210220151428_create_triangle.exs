defmodule SketchAscii.Repo.Migrations.CreateRectangle do
  use Ecto.Migration

  def change do
    create table(:rectangles, primary_key: false) do
      add :uuid, :uuid, primary_key: true, null: false
      add :width, :integer
      add :height, :integer
      add :fill, :binary
      add :outline, :binary
      add :coordinates, {:array, :integer}

      timestamps()
    end
  end
end
