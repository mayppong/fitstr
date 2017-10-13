defmodule FitstrWeb.MovementControllerTest do
  use FitstrWeb.ConnCase

  alias Fitstr.Activities.Exercises

  @create_attrs %{description: "some description", name: "some name"}
  @update_attrs %{description: "some updated description", name: "some updated name"}
  @invalid_attrs %{description: nil, name: nil}

  def fixture(:movement) do
    {:ok, movement} = Exercises.create_movement(@create_attrs)
    movement
  end

  describe "index" do
    test "lists all movements", %{conn: conn} do
      conn = get conn, movement_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Movements"
    end
  end

  describe "new movement" do
    test "renders form", %{conn: conn} do
      conn = get conn, movement_path(conn, :new)
      assert html_response(conn, 200) =~ "New Movement"
    end
  end

  describe "create movement" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, movement_path(conn, :create), movement: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == movement_path(conn, :show, id)

      conn = get conn, movement_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Movement"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, movement_path(conn, :create), movement: @invalid_attrs
      assert html_response(conn, 200) =~ "New Movement"
    end
  end

  describe "edit movement" do
    setup [:create_movement]

    test "renders form for editing chosen movement", %{conn: conn, movement: movement} do
      conn = get conn, movement_path(conn, :edit, movement)
      assert html_response(conn, 200) =~ "Edit Movement"
    end
  end

  describe "update movement" do
    setup [:create_movement]

    test "redirects when data is valid", %{conn: conn, movement: movement} do
      conn = put conn, movement_path(conn, :update, movement), movement: @update_attrs
      assert redirected_to(conn) == movement_path(conn, :show, movement)

      conn = get conn, movement_path(conn, :show, movement)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, movement: movement} do
      conn = put conn, movement_path(conn, :update, movement), movement: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Movement"
    end
  end

  describe "delete movement" do
    setup [:create_movement]

    test "deletes chosen movement", %{conn: conn, movement: movement} do
      conn = delete conn, movement_path(conn, :delete, movement)
      assert redirected_to(conn) == movement_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, movement_path(conn, :show, movement)
      end
    end
  end

  defp create_movement(_) do
    movement = fixture(:movement)
    {:ok, movement: movement}
  end
end
