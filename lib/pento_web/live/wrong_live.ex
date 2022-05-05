defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>
      <h2>
        <%= @message %>
      </h2>
      <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
      <% end %>
    </h2>

    <pre>
      <%= @current_user.email %>
      <%= @session_id %>
    </pre>

    <%= if @is_win do %>
      <button phx-click="restart" > Restart the game  </button>
    <% end %>
    """

    end

  def initial_state(socket, session_id) do
    number_to_win = Enum.random(1..10)
    IO.inspect number_to_win
    {:ok, assign(socket, score: 0, message: "Guess a number.", win: number_to_win, is_win: false, session_id: session_id)}
  end


  def mount(_params, session, socket) do
    session_id = session["live_socket_id"]
    initial_state socket, session_id
  end

  def handle_event("guess", %{"number" => guess}=data, socket) do
    {select_number, _} = Integer.parse guess

     {_, message, score, is_win} = cond do
      select_number == socket.assigns.win -> {:ok, "Your guess: #{guess}. Win. Trai again", socket.assigns.score + 1, true}
      select_number != socket.assigns.win -> {:ok, "Your guess: #{guess}. Win. Wrong again", socket.assigns.score - 1, false}
    end

    { :noreply, assign(socket, message: message, score: score, is_win: is_win) }
  end

  def handle_event("restart", _, socket) do
    number_to_win = Enum.random(1..10)
    IO.inspect number_to_win
    {:noreply, assign(socket, score: socket.assigns.score, message: "Guess a number.", win: number_to_win, is_win: false )}
  end
end
