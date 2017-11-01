defmodule FitstrWeb.API.V1.Journals.Workouts.WorkoutControllerTest do
  use FitstrWeb.ConnCase

  alias Fitstr.Journals.Workouts
  alias Fitstr.Journals.Workouts.Workout

  @create_attrs %{distance: "120.5", energy: "120.5", interval: "120.5", note: "some note", repetition: "120.5", round: "120.5", time: "120.5", weight: "120.5"}
  @update_attrs %{distance: "456.7", energy: "456.7", interval: "456.7", note: "some updated note", repetition: "456.7", round: "456.7", time: "456.7", weight: "456.7"}
  @invalid_attrs %{user_id: nil, distance: nil, energy: nil, interval: nil, note: nil, repetition: nil, round: nil, time: nil, weight: nil}

  def fixture(model, attrs \\ %{})
  def fixture(:workout, attrs) do
    user = fixture(:user)
    movement = fixture(:movement)
    attrs =
      attrs
      |> Map.put(:user_id, user.id)
      |> Map.put(:movement_id, movement.id)
      |> Enum.into(@create_attrs)
    {:ok, workout} = Workouts.create_workout(attrs)
    workout
  end

  def fixture(:movement, attrs) do
    {:ok, movement} =
      attrs
      |> Enum.into(%{name: "some move"})
      |> Fitstr.Activities.Workouts.create_movement()
    movement
  end

  def fixture(:user, attrs) do
    {:ok, user} =
      attrs
      |> Enum.into(%{email: "some email", handler: "some handler"})
      |> Fitstr.Accounts.create_user()
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all journal_workouts", %{conn: conn} do
      conn = get conn, api_v1_journals_workouts_workout_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create workout" do
    test "renders workout when data is valid", %{conn: conn} do
      user = fixture(:user)
      movement = fixture(:movement)
      attrs = @create_attrs
      |> Map.put(:user_id, user.id)
      |> Map.put(:movement_id, movement.id)
      conn = post conn, api_v1_journals_workouts_workout_path(conn, :create), workout: attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, api_v1_journals_workouts_workout_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "distance" => "120.5",
        "energy" => "120.5",
        "interval" => "120.5",
        "note" => "some note",
        "repetition" => "120.5",
        "round" => "120.5",
        "time" => "120.5",
        "weight" => "120.5"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, api_v1_journals_workouts_workout_path(conn, :create), workout: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update workout" do
    setup [:create_workout]

    test "renders workout when data is valid", %{conn: conn, workout: %Workout{id: id} = workout} do
      conn = put conn, api_v1_journals_workouts_workout_path(conn, :update, workout), workout: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, api_v1_journals_workouts_workout_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "distance" => "456.7",
        "energy" => "456.7",
        "interval" => "456.7",
        "note" => "some updated note",
        "repetition" => "456.7",
        "round" => "456.7",
        "time" => "456.7",
        "weight" => "456.7"}
    end

    test "renders errors when data is invalid", %{conn: conn, workout: workout} do
      conn = put conn, api_v1_journals_workouts_workout_path(conn, :update, workout), workout: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete workout" do
    setup [:create_workout]

    test "deletes chosen workout", %{conn: conn, workout: workout} do
      conn = delete conn, api_v1_journals_workouts_workout_path(conn, :delete, workout)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, api_v1_journals_workouts_workout_path(conn, :show, workout)
      end
    end
  end

  defp create_workout(_) do
    workout = fixture(:workout)
    {:ok, workout: workout}
  end
end
