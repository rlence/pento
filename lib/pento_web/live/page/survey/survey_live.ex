defmodule PentoWeb.SurveyLive do

  use PentoWeb, :live_view
  alias PentoWeb.HeroComponent
  alias PentoWeb.DemographicLive.Show
  alias PentoWeb.RatingLive.Index
  alias Pento.Survey
  alias Pento.Catalog

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket,
      :demographic,
      Survey.get_demographic_by_user(current_user))
  end

  def assign_products(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :products, list_products(current_user))
  end

  defp list_products(user) do
    Catalog.list_products_with_user_rating(user)
  end

  def handle_demographic_created(socket, demographic) do
    socket
      |> put_flash(:info, "Demographic created successfully")
      |> assign(:demographic, demographic)
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def mount(_params, _session, socket) do
    {:ok, socket
    |> assign_demographic
    |> assign_products }
  end
end
