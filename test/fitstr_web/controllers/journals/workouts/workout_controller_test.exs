defmodule FitstrWeb.Journals.Workouts.WorkoutControllerTest do
  use FitstrWeb.ConnCase

  alias Fitstr.Journals.Workouts

  @create_attrs %{distance: "120.5", energy: "120.5", interval: "120.5", note: "some note", repetition: "120.5", round: "120.5", time: "120.5", weight: "120.5"}
  @update_attrs %{distance: "456.7", energy: "456.7", interval: "456.7", note: "some updated note", repetition: "456.7", round: "456.7", time: "456.7", weight: "456.7"}
  @invalid_attrs %{user_id: nil, distance: nil, energy: nil, interval: nil, note: nil, repetition: nil, round: nil, time: nil, weight: nil}

  setup %{browser: %{auth: conn, guest: guest}} do
    {:ok, %{conn: conn, guest: guest}}
  end

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

  describe "index" do
    test "lists all journal_workouts", %{conn: conn} do
      conn = get conn, journals_workouts_workout_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Journal workouts"
    end
  end

  describe "new workout" do
    test "renders form", %{conn: conn} do
      conn = get conn, journals_workouts_workout_path(conn, :new)
      assert html_response(conn, 200) =~ "New Workout"
    end
  end

  describe "create workout" do
    test "redirects to show when data is valid", %{conn: conn} do
      user = fixture(:user)
      movement = fixture(:movement)
      attrs = @create_attrs
      |> Map.put(:user_id, user.id)
      |> Map.put(:movement_id, movement.id)
      conn = post conn, journals_workouts_workout_path(conn, :create), workout: attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == journals_workouts_workout_path(conn, :show, id)

      conn = get conn, journals_workouts_workout_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Workout"
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, journals_workouts_workout_path(conn, :create), workout: @invalid_attrs
      assert html_response(conn, 200) =~ "New Workout"
    end
  end

  describe "edit workout" do
    setup [:create_workout]

    test "renders form for editing chosen workout", %{conn: conn, workout: workout} do
      conn = get conn, journals_workouts_workout_path(conn, :edit, workout)
      assert html_response(conn, 200) =~ "Edit Workout"
    end
  end

  describe "update workout" do
    setup [:create_workout]

    test "redirects when data is valid", %{conn: conn, workout: workout} do
      conn = put conn, journals_workouts_workout_path(conn, :update, workout), workout: @update_attrs
      assert redirected_to(conn) == journals_workouts_workout_path(conn, :show, workout)

      conn = get conn, journals_workouts_workout_path(conn, :show, workout)
      assert html_response(conn, 200) =~ "some updated note"
    end

    test "renders errors when data is invalid", %{conn: conn, workout: workout} do
      conn = put conn, journals_workouts_workout_path(conn, :update, workout), workout: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Workout"
    end
  end

  describe "delete workout" do
    setup [:create_workout]

    test "deletes chosen workout", %{conn: conn, workout: workout} do
      conn = delete conn, journals_workouts_workout_path(conn, :delete, workout)
      assert redirected_to(conn) == journals_workouts_workout_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, journals_workouts_workout_path(conn, :show, workout)
      end
    end
  end

  defp create_workout(_) do
    workout = fixture(:workout)
    {:ok, workout: workout}
  end
end
