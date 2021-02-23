defmodule SketchAsciiWeb.TestingLive do
  use Phoenix.LiveView


  def mount(_session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
      <h1>LiveView Is Awesome</h1>
    """
  end
end
