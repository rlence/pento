defmodule PentoWeb.HeroComponent do

  use PentoWeb, :component

  def hero(assigns) do
    ~H"""
      <h2>
        content: <%= @content %>
      </h2>
    """
  end
end
