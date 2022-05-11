defmodule PentoWeb.DemographicLive.Form do

  use PentoWeb, :live_component
  alias Pento.Survey
  alias Pento.Survey.Demographic

  defp assign_demographic(%{assigns:  %{user: user }} = socket) do
      assign(socket, :demographic, %Demographic{user_id: user.id})
  end

  defp assign_changeset(%{assigns: %{demographic: demographic}} = socket) do
    assign(socket, :changeset, Survey.change_demographic(demographic))
  end

  def handle_event("validate",  %{"demographic" => demographic }, socket) do
    {:noreply, assign(socket, :demographic, demographic)}
  end

  defp save_demographic(socket, demographic_params) do
    case Survey.create_demographic(demographic_params) do
      {:ok, demographic} ->
        send(self(), {:created_demographic, demographic})
        socket
      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, changeset: changeset)
    end
  end

  def handle_event("save", %{"demographic" => demographic_params}, socket) do
    {:noreply, save_demographic(socket, demographic_params)}
  end

  def update(assigns, socket) do
    {
    :ok,
      socket
      |> assign(assigns)
      |> assign_demographic()
      |> assign_changeset()
    }
    end
end
