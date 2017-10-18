defmodule FitstrWeb.Activities.Exercises.WorkoutControllerTest do
  use FitstrWeb.ConnCase

  alias Fitstr.Activities.Exercises

  @create_attrs %{description: "some description", interval: "120.5", name: "some name", note: "some note", round: 42, time: "120.5"}
  @update_attrs %{description: "some updated description", interval: "456.7", name: "some updated name", note: "some updated note", round: 43, time: "456.7"}
  @invalid_attrs %{description: nil, interval: nil, name: nil, note: nil, round: nil, time: nil}

  setup %{browser: %{auth: auth, guest: guest}} do
    {:ok, %{conn: auth, guest: guest}}
  end

  def fixture(:workout) do
    {:ok, workout} = Exercises.create_workout(@create_attrs)
    workout
  end

  describe "index" do
    test "lists all workouts", %{conn: conn} do
      conn = get conn, activities_exercises_workout_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Workouts"
    end
  end

  describe "new workout" do
    test "renders form", %{conn: conn} do
      conn = get conn, activities_exercises_workout_path(conn, :new)
      assert html_response(conn, 200) =~ "New Workout"
    end
  end

  describe "create workout" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, activities_exercises_workout_path(conn, :create), workout: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == activities_exercises_workout_path(conn, :show, id)

      conn = get conn, activities_exercises_workout_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Workout"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, activities_exercises_workout_path(conn, :create), workout: @invalid_attrs
      assert html_response(conn, 200) =~ "New Workout"
    end
  end

  describe "edit workout" do
    setup [:create_workout]

    test "renders form for editing chosen workout", %{conn: conn, workout: workout} do
      conn = get conn, activities_exercises_workout_path(conn, :edit, workout)
      assert html_response(conn, 200) =~ "Edit Workout"
    end
  end

  describe "update workout" do
    setup [:create_workout]

    test "redirects when data is valid", %{conn: conn, workout: workout} do
      conn = put conn, activities_exercises_workout_path(conn, :update, workout), workout: @update_attrs
      assert redirected_to(conn) == activities_exercises_workout_path(conn, :show, workout)

      conn = get conn, activities_exercises_workout_path(conn, :show, workout)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, workout: workout} do
      conn = put conn, activities_exercises_workout_path(conn, :update, workout), workout: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Workout"
    end
  end

  describe "delete workout" do
    setup [:create_workout]

    test "deletes chosen workout", %{conn: conn, workout: workout} do
      conn = delete conn, activities_exercises_workout_path(conn, :delete, workout)
      assert redirected_to(conn) == activities_exercises_workout_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, activities_exercises_workout_path(conn, :show, workout)
      end
    end
  end

  defp create_workout(_) do
    workout = fixture(:workout)
    {:ok, workout: workout}
  end
end
