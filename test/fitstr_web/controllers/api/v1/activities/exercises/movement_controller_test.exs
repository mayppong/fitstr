defmodule FitstrWeb.API.V1.Activities.Exercises.MovementControllerTest do
  use FitstrWeb.ConnCase

  alias Fitstr.Activities.Exercises
  alias Fitstr.Activities.Exercises.Movement

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:movement) do
    {:ok, movement} = Exercises.create_movement(@create_attrs)
    movement
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all movements", %{conn: conn} do
      conn = get conn, api_v1_activities_exercises_movement_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create movement" do
    test "renders movement when data is valid", %{conn: conn} do
      conn = post conn, api_v1_activities_exercises_movement_path(conn, :create), movement: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, api_v1_activities_exercises_movement_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, api_v1_activities_exercises_movement_path(conn, :create), movement: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update movement" do
    setup [:create_movement]

    test "renders movement when data is valid", %{conn: conn, movement: %Movement{id: id} = movement} do
      conn = put conn, api_v1_activities_exercises_movement_path(conn, :update, movement), movement: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, api_v1_activities_exercises_movement_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, movement: movement} do
      conn = put conn, api_v1_activities_exercises_movement_path(conn, :update, movement), movement: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete movement" do
    setup [:create_movement]

    test "deletes chosen movement", %{conn: conn, movement: movement} do
      conn = delete conn, api_v1_activities_exercises_movement_path(conn, :delete, movement)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, api_v1_activities_exercises_movement_path(conn, :show, movement)
      end
    end
  end

  defp create_movement(_) do
    movement = fixture(:movement)
    {:ok, movement: movement}
  end
end
