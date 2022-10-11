# WPPass

WordPress Password Check for elixir

Password generator is not included

## Installation

The package can be installed by adding `:wp_pass` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:wp_pass, "~> 0.1.1"}
  ]
end
```

## Environment:
Latest environment is as below.

* Erlang 25.0
* Elixir 1.14.0


Programing environment is as below.

* Erlang 23.0
* Elixir 1.13

## Operating Instructions:
### Usage:
    WPPass.check_password(<plain_password>, <stored_password>)
	
return Boolean (true or flase)

### convert Authentication Logic on Phoenix

When login, user input the plain password.
```
if Bcrypt checkpass OK
      login
else
	if WordPress checkpass OK
		Save encrypted password using Bcrypt
		Login
	else
		Authentication Failure
```

## Test:
### Unit Test:
    mix test
	
### Acceptance Test:
    mix white_bread.run

## Licence:

[MIT]

## Author:

[Katsuyoshi Yabe](https://github.com/kay1759)

