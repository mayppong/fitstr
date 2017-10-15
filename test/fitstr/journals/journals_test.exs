defmodule Fitstr.JournalsTest do
  use Fitstr.DataCase

  alias Fitstr.Journals

  describe "journal_workouts" do
    alias Fitstr.Journals.Workout

    @valid_attrs %{interval: "120.5", note: "some note", repetition: 42, round: "120.5", time: "120.5"}
    @update_attrs %{interval: "456.7", note: "some updated note", repetition: 43, round: "456.7", time: "456.7"}
    @invalid_attrs %{interval: nil, note: nil, repetition: nil, round: nil, time: nil}

    def workout_fixture(attrs \\ %{}) do
      {:ok, workout} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journals.create_workout()

      workout
    end

    test "list_journal_workouts/0 returns all journal_workouts" do
      workout = workout_fixture()
      assert Journals.list_journal_workouts() == [workout]
    end

    test "get_workout!/1 returns the workout with given id" do
      workout = workout_fixture()
      assert Journals.get_workout!(workout.id) == workout
    end

    test "create_workout/1 with valid data creates a workout" do
      assert {:ok, %Workout{} = workout} = Journals.create_workout(@valid_attrs)
      assert workout.interval == Decimal.new("120.5")
      assert workout.note == "some note"
      assert workout.repetition == 42
      assert workout.round == Decimal.new("120.5")
      assert workout.time == Decimal.new("120.5")
    end

    test "create_workout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journals.create_workout(@invalid_attrs)
    end

    test "update_workout/2 with valid data updates the workout" do
      workout = workout_fixture()
      assert {:ok, workout} = Journals.update_workout(workout, @update_attrs)
      assert %Workout{} = workout
      assert workout.interval == Decimal.new("456.7")
      assert workout.note == "some updated note"
      assert workout.repetition == 43
      assert workout.round == Decimal.new("456.7")
      assert workout.time == Decimal.new("456.7")
    end

    test "update_workout/2 with invalid data returns error changeset" do
      workout = workout_fixture()
      assert {:error, %Ecto.Changeset{}} = Journals.update_workout(workout, @invalid_attrs)
      assert workout == Journals.get_workout!(workout.id)
    end

    test "delete_workout/1 deletes the workout" do
      workout = workout_fixture()
      assert {:ok, %Workout{}} = Journals.delete_workout(workout)
      assert_raise Ecto.NoResultsError, fn -> Journals.get_workout!(workout.id) end
    end

    test "change_workout/1 returns a workout changeset" do
      workout = workout_fixture()
      assert %Ecto.Changeset{} = Journals.change_workout(workout)
    end
  end

  describe "journal_movements" do
    alias Fitstr.Journals.Movement

    @valid_attrs %{distance: "120.5", energy: "120.5", interval: "120.5", note: "some note", repetition: "120.5", time: "120.5", weight: "120.5"}
    @update_attrs %{distance: "456.7", energy: "456.7", interval: "456.7", note: "some updated note", repetition: "456.7", time: "456.7", weight: "456.7"}
    @invalid_attrs %{distance: nil, energy: nil, interval: nil, note: nil, repetition: nil, time: nil, weight: nil}

    def movement_fixture(attrs \\ %{}) do
      {:ok, movement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Journals.create_movement()

      movement
    end

    test "list_journal_movements/0 returns all journal_movements" do
      movement = movement_fixture()
      assert Journals.list_journal_movements() == [movement]
    end

    test "get_movement!/1 returns the movement with given id" do
      movement = movement_fixture()
      assert Journals.get_movement!(movement.id) == movement
    end

    test "create_movement/1 with valid data creates a movement" do
      assert {:ok, %Movement{} = movement} = Journals.create_movement(@valid_attrs)
      assert movement.distance == Decimal.new("120.5")
      assert movement.energy == Decimal.new("120.5")
      assert movement.interval == Decimal.new("120.5")
      assert movement.note == "some note"
      assert movement.repetition == Decimal.new("120.5")
      assert movement.time == Decimal.new("120.5")
      assert movement.weight == Decimal.new("120.5")
    end

    test "create_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Journals.create_movement(@invalid_attrs)
    end

    test "update_movement/2 with valid data updates the movement" do
      movement = movement_fixture()
      assert {:ok, movement} = Journals.update_movement(movement, @update_attrs)
      assert %Movement{} = movement
      assert movement.distance == Decimal.new("456.7")
      assert movement.energy == Decimal.new("456.7")
      assert movement.interval == Decimal.new("456.7")
      assert movement.note == "some updated note"
      assert movement.repetition == Decimal.new("456.7")
      assert movement.time == Decimal.new("456.7")
      assert movement.weight == Decimal.new("456.7")
    end

    test "update_movement/2 with invalid data returns error changeset" do
      movement = movement_fixture()
      assert {:error, %Ecto.Changeset{}} = Journals.update_movement(movement, @invalid_attrs)
      assert movement == Journals.get_movement!(movement.id)
    end

    test "delete_movement/1 deletes the movement" do
      movement = movement_fixture()
      assert {:ok, %Movement{}} = Journals.delete_movement(movement)
      assert_raise Ecto.NoResultsError, fn -> Journals.get_movement!(movement.id) end
    end

    test "change_movement/1 returns a movement changeset" do
      movement = movement_fixture()
      assert %Ecto.Changeset{} = Journals.change_movement(movement)
    end
  end
end
