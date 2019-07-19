defmodule CodebattleWeb.Factory do
  use ExMachina.Ecto, repo: Codebattle.Repo

  alias Codebattle.{User, Game, Task, UserGame}
  alias Codebattle.Bot.Playbook
  alias Ueberauth.Auth

  def user_factory do
    %User{
      name: sequence(:username, &"User #{&1}"),
      email: sequence(:username, &"test#{&1}@test.io"),
      rating: 123,
      github_id: :rand.uniform(9_999_999)
    }
  end

  def game_factory do
    %Game{state: "waiting_opponent", task: insert(:task)}
  end

  def user_game_factory do
    %UserGame{
      result: "won",
      user: build(:user)
    }
  end

  def task_factory do
    %Task{
      name: Base.encode16(:crypto.strong_rand_bytes(2)),
      description: "test sums",
      level: "easy",
      asserts: "{\"arguments\":[[[1,1]]],\"expected\":{\"1\": 2}}\n{\"arguments\":[[[2,2], [3, 1]]],\"expected\":{\"1\": 4, \"2\": 4}}\n{\"arguments\":[[[1,3]]],\"expected\":{\"1\": 4}}\n",
      input_signature: [
        %{"argument-name" => "arr", "type" =>
          %{"name" => "array", "nested" =>
            %{"name" => "array", "nested" => %{"name" => "integer"}}
          }
        },
      ],
      output_signature: %{"type" => %{"name" => "hash", "nested" => %{"name" => "integer"}}}
    }
  end

  def bot_playbook_factory do
    %Playbook{}
  end

  def auth_factory do
    %Auth{
      provider: :github,
      uid: :rand.uniform(100_000),
      extra: %{
        raw_info: %{
          user: :user
        }
      }
    }
  end
end
