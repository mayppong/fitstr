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
end
