defmodule BidtaitesWeb.AuctionsController do
  use BidtaitesWeb, :controller

  alias Bidtaites.Interactors.{
    CreateAuction,
    ListAuctions,
    GetAuction
  }

  def create(conn, params) do
    auction = %{
      email: params["email"],
      title: params["title"],
      description: params["description"],
      price: params["price"],
      photo: params["photo"],
      phone_number: params["phone_number"],
      end_at: params["end_at"]
    }

    json(conn, CreateAuction.call(auction))
  end

  def list(conn, _) do
    json(conn, ListAuctions.call())
  end

  require Logger

  def fetch(conn, params) do
    case GetAuction.call(params["id"]) do
      nil ->
        put_status(conn, :not_found)
        |> json(%{error: "auction not found"})

      val ->
        Logger.info("#{inspect val}")
        json(conn, val)
    end
  end
end
