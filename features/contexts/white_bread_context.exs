defmodule WhiteBreadContext do
  use WhiteBread.Context

  feature_starting_state fn()  ->
    %{}
  end

  scenario_starting_state fn(state) ->
    state
  end

  scenario_finalize fn(_status, state) ->
  end

  given_ ~r/^I start password checker$/, fn state ->
    {:ok, state}
  end

  when_ ~r/^I input plain password "(?<password>[^"]+)"$/,
  fn(state, %{password: password}) ->
    {:ok, state |> Map.merge(%{password: password})}
  end

  and_ ~r/^encrypted password is "(?<encrypted>[^"]+)"$/,
   fn(state, %{encrypted: encrypted}) ->
     {:ok, state |> Map.merge(%{encrypted: encrypted})}
  end

  then_ ~r/^I should see "(?<result>[^"]+)"$/,
  fn(state, %{result: result}) ->
    password = state[:password]
    encrypted = state[:encrypted]
    assert WPPass.check_password(password, encrypted) === (result == "true")

    {:ok, :whatever}
  end


end
