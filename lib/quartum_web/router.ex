defmodule QuartumWeb.Router do
  use QuartumWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", QuartumWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/establishments", EstablishmentController
    resources "/addresses", AddressController
    resources "/guests", GuestController
    resources "/payments", PaymentController
    resources "/rooms", RoomController
    resources "/reservations", ReservationController
  end

  # Other scopes may use custom stacks.
  # scope "/api", QuartumWeb do
  #   pipe_through :api
  # end
end
