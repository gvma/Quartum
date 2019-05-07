defmodule QuartumWeb.PageController do
  use QuartumWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
