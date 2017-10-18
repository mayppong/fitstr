defmodule FitstrWeb.API.V1.Journals.WorkoutControllerTest do
  use FitstrWeb.ConnCase

  alias Fitstr.Journals
  alias Fitstr.Journals.Workout

  @create_attrs %{interval: "120.5", note: "some note", repetition: 42, round: "120.5", time: "120.5"}
  @update_attrs %{interval: "456.7", note: "some updated note", repetition: 43, round: "456.7", time: "456.7"}
  @invalid_attrs %{interval: nil, note: nil, repetition: nil, round: nil, time: nil}

  def fixture(:workout) do
    {:ok, workout} = Journals.create_workout(@create_attrs)
    workout
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all journal_workouts", %{conn: conn} do
      conn = get conn, api_v1_journals_workout_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create workout" do
    test "renders workout when data is valid", %{conn: conn} do
      conn = post conn, api_v1_journals_workout_path(conn, :create), workout: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, api_v1_journals_workout_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "interval" => "120.5",
        "note" => "some note",
        "repetition" => 42,
        "round" => "120.5",
        "time" => "120.5"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, api_v1_journals_workout_path(conn, :create), workout: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update workout" do
    setup [:create_workout]

    test "renders workout when data is valid", %{conn: conn, workout: %Workout{id: id} = workout} do
      conn = put conn, api_v1_journals_workout_path(conn, :update, workout), workout: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, api_v1_journals_workout_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "interval" => "456.7",
        "note" => "some updated note",
        "repetition" => 43,
        "round" => "456.7",
        "time" => "456.7"}
    end

    test "renders errors when data is invalid", %{conn: conn, workout: workout} do
      conn = put conn, api_v1_journals_workout_path(conn, :update, workout), workout: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete workout" do
    setup [:create_workout]

    test "deletes chosen workout", %{conn: conn, workout: workout} do
      conn = delete conn, api_v1_journals_workout_path(conn, :delete, workout)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, api_v1_journals_workout_path(conn, :show, workout)
      end
    end
  end

  defp create_workout(_) do
    workout = fixture(:workout)
    {:ok, workout: workout}
  end
end
