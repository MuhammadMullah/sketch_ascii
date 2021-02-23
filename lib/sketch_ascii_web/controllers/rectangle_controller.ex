defmodule SketchAsciiWeb.RectangleController do
  @moduledoc false
  use SketchAsciiWeb, :controller

  alias Plug.Conn
  alias SketchAscii.Box

  def create(conn, params) do
    case Box.create_rectangle(params) do
      {:ok, rectangle} ->
        data = Box.draw(rectangle)

        conn
        |> Conn.put_resp_content_type("text/plain")
        |> Conn.send_resp(201, data)
    end
  end
end
