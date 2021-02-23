defmodule SketchAsciiWeb.AsciiLive.Index do
  use Phoenix.LiveView

  alias SketchAscii.Box

  def mount(_params, _session, socket) do
    rectangles = Box.list_rectangles()
    {:ok, assign(socket, :rectangles, rectangles)}
  end
end
