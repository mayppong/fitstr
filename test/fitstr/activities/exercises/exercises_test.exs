defmodule Fitstr.Activities.ExercisesTest do
  use Fitstr.DataCase

  alias Fitstr.Activities.Exercises

  describe "movements" do
    alias Fitstr.Activities.Exercises.Movement

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def movement_fixture(attrs \\ %{}) do
      {:ok, movement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Exercises.create_movement()

      movement
    end

    test "list_movements/0 returns all movements" do
      movement = movement_fixture()
      assert Exercises.list_movements() == [movement]
    end

    test "get_movement!/1 returns the movement with given id" do
      movement = movement_fixture()
      assert Exercises.get_movement!(movement.id) == movement
    end

    test "create_movement/1 with valid data creates a movement" do
      assert {:ok, %Movement{} = movement} = Exercises.create_movement(@valid_attrs)
      assert movement.description == "some description"
      assert movement.name == "some name"
    end

    test "create_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exercises.create_movement(@invalid_attrs)
    end

    test "update_movement/2 with valid data updates the movement" do
      movement = movement_fixture()
      assert {:ok, movement} = Exercises.update_movement(movement, @update_attrs)
      assert %Movement{} = movement
      assert movement.description == "some updated description"
      assert movement.name == "some updated name"
    end

    test "update_movement/2 with invalid data returns error changeset" do
      movement = movement_fixture()
      assert {:error, %Ecto.Changeset{}} = Exercises.update_movement(movement, @invalid_attrs)
      assert movement == Exercises.get_movement!(movement.id)
    end

    test "delete_movement/1 deletes the movement" do
      movement = movement_fixture()
      assert {:ok, %Movement{}} = Exercises.delete_movement(movement)
      assert_raise Ecto.NoResultsError, fn -> Exercises.get_movement!(movement.id) end
    end

    test "change_movement/1 returns a movement changeset" do
      movement = movement_fixture()
      assert %Ecto.Changeset{} = Exercises.change_movement(movement)
    end
  end

  describe "workouts" do
    alias Fitstr.Activities.Exercises.Workout

    @valid_attrs %{description: "some description", interval: "120.5", name: "some name", note: "some note", round: 42, time: "120.5"}
    @update_attrs %{description: "some updated description", interval: "456.7", name: "some updated name", note: "some updated note", round: 43, time: "456.7"}
    @invalid_attrs %{description: nil, interval: nil, name: nil, note: nil, round: nil, time: nil}

    def workout_fixture(attrs \\ %{}) do
      {:ok, workout} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Exercises.create_workout()

      workout
    end

    test "list_workouts/0 returns all workouts" do
      workout = workout_fixture()
      assert Exercises.list_workouts() == [workout]
    end

    test "get_workout!/1 returns the workout with given id" do
      workout = workout_fixture()
      assert Exercises.get_workout!(workout.id) == workout
    end

    test "create_workout/1 with valid data creates a workout" do
      assert {:ok, %Workout{} = workout} = Exercises.create_workout(@valid_attrs)
      assert workout.description == "some description"
      assert workout.interval == Decimal.new("120.5")
      assert workout.name == "some name"
      assert workout.note == "some note"
      assert workout.round == 42
      assert workout.time == Decimal.new("120.5")
    end

    test "create_workout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exercises.create_workout(@invalid_attrs)
    end

    test "update_workout/2 with valid data updates the workout" do
      workout = workout_fixture()
      assert {:ok, workout} = Exercises.update_workout(workout, @update_attrs)
      assert %Workout{} = workout
      assert workout.description == "some updated description"
      assert workout.interval == Decimal.new("456.7")
      assert workout.name == "some updated name"
      assert workout.note == "some updated note"
      assert workout.round == 43
      assert workout.time == Decimal.new("456.7")
    end

    test "update_workout/2 with invalid data returns error changeset" do
      workout = workout_fixture()
      assert {:error, %Ecto.Changeset{}} = Exercises.update_workout(workout, @invalid_attrs)
      assert workout == Exercises.get_workout!(workout.id)
    end

    test "delete_workout/1 deletes the workout" do
      workout = workout_fixture()
      assert {:ok, %Workout{}} = Exercises.delete_workout(workout)
      assert_raise Ecto.NoResultsError, fn -> Exercises.get_workout!(workout.id) end
    end

    test "change_workout/1 returns a workout changeset" do
      workout = workout_fixture()
      assert %Ecto.Changeset{} = Exercises.change_workout(workout)
    end
  end

  describe "workout_movements" do
    alias Fitstr.Activities.Exercises.WorkoutMovement

    @valid_attrs %{distance: "120.5", energy: "120.5", interval: "120.5", order: 42, repetition: "120.5", time: "120.5", weight: "120.5"}
    @update_attrs %{distance: "456.7", energy: "456.7", interval: "456.7", order: 43, repetition: "456.7", time: "456.7", weight: "456.7"}
    @invalid_attrs %{distance: nil, energy: nil, interval: nil, order: nil, repetition: nil, time: nil, weight: nil}

    def workout_movement_fixture(attrs \\ %{}) do
      {:ok, workout_movement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Exercises.create_workout_movement()

      workout_movement
    end

    test "list_workout_movements/0 returns all workout_movements" do
      workout_movement = workout_movement_fixture()
      assert Exercises.list_workout_movements() == [workout_movement]
    end

    test "get_workout_movement!/1 returns the workout_movement with given id" do
      workout_movement = workout_movement_fixture()
      assert Exercises.get_workout_movement!(workout_movement.id) == workout_movement
    end

    test "create_workout_movement/1 with valid data creates a workout_movement" do
      assert {:ok, %WorkoutMovement{} = workout_movement} = Exercises.create_workout_movement(@valid_attrs)
      assert workout_movement.distance == Decimal.new("120.5")
      assert workout_movement.energy == Decimal.new("120.5")
      assert workout_movement.interval == Decimal.new("120.5")
      assert workout_movement.order == 42
      assert workout_movement.repetition == Decimal.new("120.5")
      assert workout_movement.time == Decimal.new("120.5")
      assert workout_movement.weight == Decimal.new("120.5")
    end

    test "create_workout_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Exercises.create_workout_movement(@invalid_attrs)
    end

    test "update_workout_movement/2 with valid data updates the workout_movement" do
      workout_movement = workout_movement_fixture()
      assert {:ok, workout_movement} = Exercises.update_workout_movement(workout_movement, @update_attrs)
      assert %WorkoutMovement{} = workout_movement
      assert workout_movement.distance == Decimal.new("456.7")
      assert workout_movement.energy == Decimal.new("456.7")
      assert workout_movement.interval == Decimal.new("456.7")
      assert workout_movement.order == 43
      assert workout_movement.repetition == Decimal.new("456.7")
      assert workout_movement.time == Decimal.new("456.7")
      assert workout_movement.weight == Decimal.new("456.7")
    end

    test "update_workout_movement/2 with invalid data returns error changeset" do
      workout_movement = workout_movement_fixture()
      assert {:error, %Ecto.Changeset{}} = Exercises.update_workout_movement(workout_movement, @invalid_attrs)
      assert workout_movement == Exercises.get_workout_movement!(workout_movement.id)
    end

    test "delete_workout_movement/1 deletes the workout_movement" do
      workout_movement = workout_movement_fixture()
      assert {:ok, %WorkoutMovement{}} = Exercises.delete_workout_movement(workout_movement)
      assert_raise Ecto.NoResultsError, fn -> Exercises.get_workout_movement!(workout_movement.id) end
    end

    test "change_workout_movement/1 returns a workout_movement changeset" do
      workout_movement = workout_movement_fixture()
      assert %Ecto.Changeset{} = Exercises.change_workout_movement(workout_movement)
    end
  end
end
