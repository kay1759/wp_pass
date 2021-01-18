defmodule WPPassTest do
  use ExUnit.Case
  doctest WPPass

  test "right password return true" do
    assert WPPass.check_password("pass1234", "$P$B1k/CclpMTBLGiWTbdf9eQnLIyQZBr/") === true
  end
  
  test "wrong password return false" do
    assert WPPass.check_password("pass1234", "$P$B1234567890AaBbCcDdEeFfGgHhIiJj") === false
  end

  test "right password return a string the same as the second argument" do
    assert WPPass.test_crypt_private("pass1234", "$P$B1k/CclpMTBLGiWTbdf9eQnLIyQZBr/") === "$P$B1k/CclpMTBLGiWTbdf9eQnLIyQZBr/"
  end

  test "wrong password return a string different from the second argument" do
    assert WPPass.test_crypt_private("pass1234", "$P$B1234567890AaBbCcDdEeFfGgHhIiJj") !== "$P$B1234567890AaBbCcDdEeFfGgHhIiJj"
  end

  test "encrypted not start with '$P$' nor '$H$'" do
    assert WPPass.test_crypt_private("pass1234", "$A$B1k/CclpMTBLGiWTbdf9eQnLIyQZBr/") === "*0"
  end

  test "B is at 13th postion in itoa64" do
    assert WPPass.test_strpos("B") === 13
  end

  test "postion in itoa64" do
    assert WPPass.test_itoa64_at(0) === "."
    assert WPPass.test_itoa64_at(1) === "/"
    assert WPPass.test_itoa64_at(10) === "8"
    assert WPPass.test_itoa64_at(20) === "I"
    assert WPPass.test_itoa64_at(63) === "z"
    assert WPPass.test_itoa64_at(64) === "."
    assert WPPass.test_itoa64_at(128) === "."
    assert WPPass.test_itoa64_at(74) === "8"
  end

end
