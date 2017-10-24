defmodule Fitstr.Activities.WorkoutsTest do
  use Fitstr.DataCase

  alias Fitstr.Activities.Workouts

  describe "movements" do
    alias Fitstr.Activities.Workouts.Movement

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def movement_fixture(attrs \\ %{}) do
      {:ok, movement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Workouts.create_movement()

      movement
    end

    test "list_movements/0 returns all movements" do
      movement = movement_fixture()
      assert Workouts.list_movements() == [movement]
    end

    test "get_movement!/1 returns the movement with given id" do
      movement = movement_fixture()
      assert Workouts.get_movement!(movement.id) == movement
    end

    test "create_movement/1 with valid data creates a movement" do
      assert {:ok, %Movement{} = movement} = Workouts.create_movement(@valid_attrs)
      assert movement.description == "some description"
      assert movement.name == "some name"
    end

    test "create_movement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Workouts.create_movement(@invalid_attrs)
    end

    test "update_movement/2 with valid data updates the movement" do
      movement = movement_fixture()
      assert {:ok, movement} = Workouts.update_movement(movement, @update_attrs)
      assert %Movement{} = movement
      assert movement.description == "some updated description"
      assert movement.name == "some updated name"
    end

    test "update_movement/2 with invalid data returns error changeset" do
      movement = movement_fixture()
      assert {:error, %Ecto.Changeset{}} = Workouts.update_movement(movement, @invalid_attrs)
      assert movement == Workouts.get_movement!(movement.id)
    end

    test "delete_movement/1 deletes the movement" do
      movement = movement_fixture()
      assert {:ok, %Movement{}} = Workouts.delete_movement(movement)
      assert_raise Ecto.NoResultsError, fn -> Workouts.get_movement!(movement.id) end
    end

    test "change_movement/1 returns a movement changeset" do
      movement = movement_fixture()
      assert %Ecto.Changeset{} = Workouts.change_movement(movement)
    end
  end

  describe "workouts" do
    alias Fitstr.Activities.Workouts.Workout

    @valid_attrs %{description: "some description", distance: "120.5", energy: "120.5", interval: "120.5", name: "some name", order: 42, repetition: "120.5", round: "120.5", time: "120.5", weight: "120.5"}
    @update_attrs %{description: "some updated description", distance: "456.7", energy: "456.7", interval: "456.7", name: "some updated name", order: 43, repetition: "456.7", round: "456.7", time: "456.7", weight: "456.7"}
    @invalid_attrs %{description: nil, distance: nil, energy: nil, interval: nil, name: nil, order: nil, repetition: nil, round: nil, time: nil, weight: nil}

    def workout_fixture(attrs \\ %{}) do
      {:ok, workout} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Workouts.create_workout()

      workout
    end

    test "list_workouts/0 returns all workouts" do
      workout = workout_fixture()
      assert Workouts.list_workouts() == [workout]
    end

    test "get_workout!/1 returns the workout with given id" do
      workout = workout_fixture()
      assert Workouts.get_workout!(workout.id) == workout
    end

    test "create_workout/1 with valid data creates a workout" do
      assert {:ok, %Workout{} = workout} = Workouts.create_workout(@valid_attrs)
      assert workout.description == "some description"
      assert workout.distance == Decimal.new("120.5")
      assert workout.energy == Decimal.new("120.5")
      assert workout.interval == Decimal.new("120.5")
      assert workout.name == "some name"
      assert workout.order == 42
      assert workout.repetition == Decimal.new("120.5")
      assert workout.round == Decimal.new("120.5")
      assert workout.time == Decimal.new("120.5")
      assert workout.weight == Decimal.new("120.5")
    end

    test "create_workout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Workouts.create_workout(@invalid_attrs)
    end

    test "update_workout/2 with valid data updates the workout" do
      workout = workout_fixture()
      assert {:ok, workout} = Workouts.update_workout(workout, @update_attrs)
      assert %Workout{} = workout
      assert workout.description == "some updated description"
      assert workout.distance == Decimal.new("456.7")
      assert workout.energy == Decimal.new("456.7")
      assert workout.interval == Decimal.new("456.7")
      assert workout.name == "some updated name"
      assert workout.order == 43
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
