defmodule SketchAscii.Box.BoxTest do
  @moduledoc """
    Tests for all our box context functionality
  """
  use SketchAscii.DataCase

  alias SketchAscii.Box, as: Box
  alias SketchAscii.Box.Rectangle

  @valid_attrs %{width: 10, height: 12, fill: "&", outline: "^", coordinates: [5, 2]}
  @updated_attrs %{width: 3, height: 7, fill: "#", outline: "%", coordinates: [8, 8]}

  describe "" do
    test "create_rectangle/1 with valid data creates a rectangle" do
      assert {:ok, %Rectangle{} = rectangle} = Box.create_rectangle(@valid_attrs)
    end

    test "list_rectangles/0 returns the list of all rectangles" do
      rectangle = insert!(:rectangle)
      assert Box.list_rectangles() == [rectangle]
    end

    test "update_rectangle/2 with valid data updates the rectangle with new data" do
      rectangle = insert!(:rectangle)
      assert {:ok, rectangle} = Box.update_rectangle(rectangle, @updated_attrs)
      assert %Rectangle{} = rectangle
      assert rectangle.width == 3
    end

    test "get_user_by_uuid/1 returns a user struct when provided with correct uuid" do
      rectangle = insert!(:rectangle)
      assert Box.get_rectangle_by_uuid(rectangle.uuid) == {:ok, %Rectangle{} = rectangle}
      assert is_binary(rectangle.uuid)
    end
  end
end
