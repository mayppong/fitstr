defmodule FitstrWeb.Journals.MovementControllerTest do
  use FitstrWeb.ConnCase

  alias Fitstr.Journals

  @create_attrs %{distance: "120.5", energy: "120.5", interval: "120.5", note: "some note", repetition: "120.5", time: "120.5", weight: "120.5"}
  @update_attrs %{distance: "456.7", energy: "456.7", interval: "456.7", note: "some updated note", repetition: "456.7", time: "456.7", weight: "456.7"}
  @invalid_attrs %{distance: nil, energy: nil, interval: nil, note: nil, repetition: nil, time: nil, weight: nil}

  setup %{browser: %{auth: auth, guest: guest}} do
    {:ok, %{conn: auth, guest: guest}}
  end

  def fixture(:movement) do
    {:ok, movement} = Journals.create_movement(@create_attrs)
    movement
  end

  describe "index" do
    test "lists all journal_movements", %{conn: conn} do
      conn = get conn, journals_movement_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Journal movements"
    end
  end

  describe "new movement" do
    test "renders form", %{conn: conn} do
      conn = get conn, journals_movement_path(conn, :new)
      assert html_response(conn, 200) =~ "New Movement"
    end
  end

  describe "create movement" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, journals_movement_path(conn, :create), movement: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == journals_movement_path(conn, :show, id)

      conn = get conn, journals_movement_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Movement"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, journals_movement_path(conn, :create), movement: @invalid_attrs
      assert html_response(conn, 200) =~ "New Movement"
    end
  end

  describe "edit movement" do
    setup [:create_movement]

    test "renders form for editing chosen movement", %{conn: conn, movement: movement} do
      conn = get conn, journals_movement_path(conn, :edit, movement)
      assert html_response(conn, 200) =~ "Edit Movement"
    end
  end

  describe "update movement" do
    setup [:create_movement]

    test "redirects when data is valid", %{conn: conn, movement: movement} do
      conn = put conn, journals_movement_path(conn, :update, movement), movement: @update_attrs
      assert redirected_to(conn) == journals_movement_path(conn, :show, movement)

      conn = get conn, journals_movement_path(conn, :show, movement)
      assert html_response(conn, 200) =~ "some updated note"
    end

    test "renders errors when data is invalid", %{conn: conn, movement: movement} do
      conn = put conn, journals_movement_path(conn, :update, movement), movement: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Movement"
    end
  end

  describe "delete movement" do
    setup [:create_movement]

    test "deletes chosen movement", %{conn: conn, movement: movement} do
      conn = delete conn, journals_movement_path(conn, :delete, movement)
      assert redirected_to(conn) == journals_movement_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, journals_movement_path(conn, :show, movement)
      end
    end
  end

  defp create_movement(_) do
    movement = fixture(:movement)
    {:ok, movement: movement}
  end
end
