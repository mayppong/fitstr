defmodule FitstrWeb.Activities.Workouts.WorkoutControllerTest do
  use FitstrWeb.ConnCase

  alias Fitstr.Activities.Workouts

  @create_attrs %{description: "some description", distance: "120.5", energy: "120.5", interval: "120.5", name: "some name", order: 42, repetition: "120.5", round: "120.5", time: "120.5", weight: "120.5"}
  @update_attrs %{description: "some updated description", distance: "456.7", energy: "456.7", interval: "456.7", name: "some updated name", order: 43, repetition: "456.7", round: "456.7", time: "456.7", weight: "456.7"}
  @invalid_attrs %{description: nil, distance: nil, energy: nil, interval: nil, name: nil, order: nil, repetition: nil, round: nil, time: nil, weight: nil}

  setup %{browser: %{auth: conn, guest: guest}} do
    {:ok, %{conn: conn, guest: guest}}
  end

  def fixture(:workout) do
    {:ok, workout} = Workouts.create_workout(@create_attrs)
    workout
  end

  describe "index" do
    test "lists all workouts", %{conn: conn} do
      conn = get conn, activities_workouts_workout_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Workouts"
    end
  end

  describe "new workout" do
    test "renders form", %{conn: conn} do
      conn = get conn, activities_workouts_workout_path(conn, :new)
      assert html_response(conn, 200) =~ "New Workout"
    end
  end

  describe "create workout" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, activities_workouts_workout_path(conn, :create), workout: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == activities_workouts_workout_path(conn, :show, id)

      conn = get conn, activities_workouts_workout_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Workout"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, activities_workouts_workout_path(conn, :create), workout: @invalid_attrs
      assert html_response(conn, 200) =~ "New Workout"
    end
  end

  describe "edit workout" do
    setup [:create_workout]

    test "renders form for editing chosen workout", %{conn: conn, workout: workout} do
      conn = get conn, activities_workouts_workout_path(conn, :edit, workout)
      assert html_response(conn, 200) =~ "Edit Workout"
    end
  end

  describe "update workout" do
    setup [:create_workout]

    test "redirects when data is valid", %{conn: conn, workout: workout} do
      conn = put conn, activities_workouts_workout_path(conn, :update, workout), workout: @update_attrs
      assert redirected_to(conn) == activities_workouts_workout_path(conn, :show, workout)

      conn = get conn, activities_workouts_workout_path(conn, :show, workout)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, workout: workout} do
      conn = put conn, activities_workouts_workout_path(conn, :update, workout), workout: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Workout"
    end
  end

  describe "delete workout" do
    setup [:create_workout]

    test "deletes chosen workout", %{conn: conn, workout: workout} do
      conn = delete conn, activities_workouts_workout_path(conn, :delete, workout)
      assert redirected_to(conn) == activities_workouts_workout_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, activities_workouts_workout_path(conn, :show, workout)
      end
    end
  end

  defp create_workout(_) do
    workout = fixture(:workout)
    {:ok, workout: workout}
  end
end
