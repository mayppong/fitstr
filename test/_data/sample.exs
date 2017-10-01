# Alternative structure for the lifts with modifier and different weight
# implementations.
#[
#  {"Squat", "", [
#    {"Front Squat", "with the bar in the rack position, squat down until your hips is at knee's level or below", ["Paused"]},
#    {"Back Squat", ""},
#    {"Overhead Squat", ""}
#  ], ["Paused", "Banded", "Chained"], ["Barbell", "Dumbbell", "Kettlebell"]},
#  {"Snatch", "", [
#    {"Squat Snatch", ""},
#    {"Power Snatch", ""},
#    {"Drop Snatch", ""}
#  ], ["Hang", "Paused"]},
#  {"Clean", "", [
#    {"Squat Clean", ""},
#    {"Power Clean", ""}
#  ], ["Hang", "Paused"]},
#  {"Jerk", "", [
#    {"Push Jerk", ""},
#    {"Split Jerk", ""},
#  ], []},
#  {"Press", "", [
#    {"Shoulder Press", "", []},
#    {"Push Press", "", []},
#    {"Bench Press", "", []}
#  ], []},
#  {"Deadlift", "", [
#    {"Conventional Deadlift", ""}
#    {"Romanian Deadlift", ""}
#  ], ["Banded", "Chained"], []}
#]

[
  {"weight_training", "Weight Training"},
  {"olympic_lifting", "Olympic Lifting"},
  {"power_lifting", "Power Lifting"},
  {"gymnastic", "Gymnastic"},
  {"calisthenic", "Calisthenic"},
  {"aerobic", "Aerobic"}
]

# routine
[
  {%{name: "Cindy", time: 20}, [
    %{name: "Pull up", repitition: 5},
    %{name: "Push up", repitition: 10},
    %{name: "Squat", repetition: 15}
  ]},
  {%{name: "Nurwor", round: 5}, [
    %{name: "Run", distance: 500},
    %{name: "Row", distance: 500}
  ]},
  {%{name: "Newspaper Boy"}, [
    %{name: "Run", distance: 800},
    {%{round: 5}, [ # need parent_id from Newspaper Boy
      %{name: "Wallball", repetition: 10},
      %{name: "Toes to Bar", repetition: 10},
      %{name: "Power Clean", repetition: 10}
    ]}
  ]}
]

# record movement
[
  %{user_id: 1, movement: "Paused Power Clean", weight: 100, repetition: 5},
  %{user_id: 1, movement: "Squat Snatch", weight: 85, round: 3, repetition: 5}
]

# record routine
[
  {%{user_id: 1, routine: "Cindy", round: 15, repetition: 12}, [
    %{user_id: 1, record_routine_id: 1, movement: "Pull up", repetition: 5},
    %{user_id: 1, record_routine_id: 1, movement: "Push up", repetition: 10},
    %{user_id: 1, record_routine_id: 1, movement: "Squat", repetition: 15}
  ]},
  {%{user_id: 1, routine: "Newspaper Boy", time: 23}, [ # record_routine_id 2
    %{user_id: 1, record_routine_id: 2, movement: "Run", distance: 800},
    {%{user_id: 1, routine: "", round: 5}, [ # record_routine_id 3
      %{user_id: 1, record_routine_id: 3 movement: "Wallball", repetition: 10},
      %{user_id: 1, record_routine_id: 3 movement: "Toes to Bar", repetition: 10},
      %{user_id: 1, record_routine_id: 3 movement: "Power Clean", repetition: 10},
    ]}
  ]}
]
