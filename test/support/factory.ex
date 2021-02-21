defmodule SketchAscii.Factory  do
  @moduledoc """
    Our factory definitions
  """

  alias SketchAscii.Repo
  alias SketchAscii.Box.Rectangle


  def build(:rectangle) do
    %Rectangle{
      width: 10,
      height: 12,
      fill: "&",
      outline: "*",
      coordinates: [5, 2]
    }
  end

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
