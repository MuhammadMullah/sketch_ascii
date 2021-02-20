defmodule SketchAsciiWeb.PageController do
  use SketchAsciiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
