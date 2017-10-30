defmodule Fitstr.Import do
  alias Fitstr.Activities.Workouts.Movement
  alias Fitstr.Repo

  def insert(move, parent_id \\ nil)
  def insert({name, desc}, parent_id) do
    %Movement{}
    |> Movement.changeset(%{name: name, description: desc, parent_id: parent_id})
    |> Repo.insert!
  end
  def insert({name, desc, children}, parent_id) do
    parent = insert({name, desc}, parent_id)
    children = children
    |> Enum.each(&insert(&1, parent.id))

    [parent, children]
  end
end

[
  {"Chest Press", "", [
    {"Bench Press", "", []}
  ]},
  {"Clean", "", [
    {"Power Clean", "", [
      {"Hang Power Clean", "", []},
      {"Paused Power Clean", "", []}
    ]},
    {"Squat Clean", "", [
      {"Hang Squat Clean", "", []},
      {"Paused Squat Clean", "", []},
    ]}
  ]},
  {"Deadlift", "", [
    {"Conventional Deadlift", "", []},
    {"Romanian Deadlift", "", []},
    {"Sumo Deadlift", "", []}
  ]},
  {"Jump", "", [
    {"Box Jump", "", []},
    {"Broad Jump", "", []}
  ]},
  {"Jerk", "", [
    {"Push Jerk", "", []},
    {"Split Jerk", "", []},
  ]},
  {"Push Press", "", []},
  {"Shoulder Press", "", []},
  {"Pull-up", "", []},
  {"Push-up", "", []},
  {"Rowing", "", []},
  {"Running", "", [
    {"Jog", "", []},
    {"Sprint", "", []}
  ]},
  {"Snatch", "", [
    {"Power Snatch", "", [
      {"Hang Power Snatch", "", []}
    ]},
    {"Squat Snatch", "", [
      {"Hang Squat Snatch", "", []}
    ]}
  ]},
  {"Squat", "", [
    {"Back Squat", "", []},
    {"Front Squat", "with the bar in the rack position, squat down until your hips is at knee's level or below", []},
    {"Overhead Squat", "", []}
  ]},
  {"Thruster", "", []}
]
|> Enum.each(&Fitstr.Import.insert/1)