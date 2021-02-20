defmodule SketchAscii.Repo do
  use Ecto.Repo,
    otp_app: :sketch_ascii,
    adapter: Ecto.Adapters.Postgres
end
