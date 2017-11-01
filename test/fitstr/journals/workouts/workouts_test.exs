defmodule Fitstr.Journals.WorkoutsTest do
  use Fitstr.DataCase

  alias Fitstr.Journals.Workouts

  describe "journal_workouts" do
    alias Fitstr.Journals.Workouts.Workout

    @valid_attrs %{distance: "120.5", energy: "120.5", interval: "120.5", note: "some note", repetition: "120.5", round: "120.5", time: "120.5", weight: "120.5"}
    @update_attrs %{distance: "456.7", energy: "456.7", interval: "456.7", note: "some updated note", repetition: "456.7", round: "456.7", time: "456.7", weight: "456.7"}
    @invalid_attrs %{user_id: nil, distance: nil, energy: nil, interval: nil, note: nil, repetition: nil, round: nil, time: nil, weight: nil}

    def workout_fixture(attrs \\ %{}) do
      user = user_fixture()
      attrs = Map.put(attrs, :user_id, user.id)
      movement = movement_fixture()
      attrs = Map.put(attrs, :movement_id, movement.id)
      {:ok, workout} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Workouts.create_workout()

      workout
    end

    def movement_fixture(attrs \\ %{}) do
      {:ok, movement} =
        attrs
        |> Enum.into(%{name: "some move"})
        |> Fitstr.Activities.Workouts.create_movement()
      movement
    end

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(%{email: "some email", handler: "some handler"})
        |> Fitstr.Accounts.create_user()
      user
    end

    test "list_journal_workouts/0 returns all journal_workouts" do
      workout = workout_fixture()
      assert Workouts.list_journal_workouts() == [workout]
    end

    test "get_workout!/1 returns the workout with given id" do
      workout = workout_fixture()
      assert Workouts.get_workout!(workout.id) == workout
    end

    test "create_workout/1 with valid data creates a workout" do
      user = user_fixture()
      attrs = Map.put(@valid_attrs, :user_id, user.id)
      movement = movement_fixture()
      attrs = Map.put(attrs, :movement_id, movement.id)
      assert {:ok, %Workout{} = workout} = Workouts.create_workout(attrs)
      assert workout.distance == Decimal.new("120.5")
      assert workout.energy == Decimal.new("120.5")
      assert workout.interval == Decimal.new("120.5")
      assert workout.note == "some note"
      assert workout.repetition == Decimal.new("120.5")
      assert workout.round == Decimal.new("120.5")
      assert workout.time == Decimal.new("120.5")
      assert workout.weight == Decimal.new("120.5")
    end

    test "create_workout/1 with invalid data returns error changeset" do
      {:error, changeset} = Workouts.create_workout(@invalid_attrs)
      refute changeset.valid?
      assert Keyword.get(changeset.errors, :user_id) == {"can't be blank", [validation: :required]}
      assert Keyword.get(changeset.errors, :movement_id) == {"can't be blank", [validation: :required]}
    end

    test "update_workout/2 with valid data updates the workout" do
      workout = workout_fixture()
      assert {:ok, workout} = Workouts.update_workout(workout, @update_attrs)
      assert %Workout{} = workout
      assert workout.distance == Decimal.new("456.7")
      assert workout.energy == Decimal.new("456.7")
      assert workout.interval == Decimal.new("456.7")
      assert workout.note == "some updated note"
      assert workout.repetition == Decimal.new("456.7")
      assert workout.round == Decimal.new("456.7")
      assert workout.time == Decimal.new("456.7")
      assert workout.weight == Decimal.new("456.7")
    end

    test "update_workout/2 with invalid data returns error changeset" do
      workout = workout_fixture()
      assert {:error, %Ecto.Changeset{}} = Workouts.update_workout(workout, @invalid_attrs)
      assert workout == Workouts.get_workout!(workout.id)
    end

    test "delete_workout/1 deletes the workout" do
      workout = workout_fixture()
      assert {:ok, %Workout{}} = Workouts.delete_workout(workout)
      assert_raise Ecto.NoResultsError, fn -> Workouts.get_workout!(workout.id) end
    end

    test "change_workout/1 returns a workout changeset" do
      workout = workout_fixture()
      assert %Ecto.Changeset{} = Workouts.change_workout(workout)
    end
  end
end
