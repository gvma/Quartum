defmodule Quartum.Repo do
  use Ecto.Repo,
    otp_app: :quartum,
    adapter: Ecto.Adapters.Postgres
end
