defmodule PentoWeb.Admin do

  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
      socket
      |> assign(:survey_results_component_id, "survey-results")
      |>assign(:products_with_average_ratings, [])}
  end
end
