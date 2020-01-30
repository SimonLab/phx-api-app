defmodule MyAppWeb.TaskController do
  use MyAppWeb, :controller

  alias MyApp.Todos
  alias MyApp.Todos.Task

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    tasks = Todos.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Todos.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Todos.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Todos.get_task!(id)

    with {:ok, %Task{} = task} <- Todos.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Todos.get_task!(id)

    with {:ok, %Task{}} <- Todos.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
