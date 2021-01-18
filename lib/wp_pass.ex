use Bitwise

defmodule WPPass do
  @moduledoc """
  Wordpress Password Check
  Based on 'wp-includes/class-phpass.php'
  """

  @itoa64 "./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  @count 16
  @invalid "*0"
  
  @doc """
  equivalent CheckPassword

  WPPass.check_password(<password>, <stored_hash>)
  return true or false

  """
  def check_password(password, stored_hash) do
    if String.length(password) > 4096 do
      false
    else
      hash = crypt_private(password, stored_hash)

      if String.slice(hash, 0, 1) == "*" do
	false
      else
	hash === stored_hash
      end
    end
  end
  
  @doc """
  equivalent crypt_private
  """
  defp crypt_private(password, setting) do
    id = String.slice(setting, 0, 3)

    shift_count = String.slice(setting, 3, 1)
    |> strpos

    count = 1 <<< shift_count
    salt = String.slice(setting, 4, 8)

    cond do
      id != "$P$" && id != "$H$" ->
	@invalid
      shift_count < 7 || shift_count > 30 ->
	@invalid
      String.length(salt) != 8 ->
	@invalid
      true ->   
	hash = get_hash(password, salt, count)
	|> :binary.bin_to_list()

	String.slice(setting, 0, 12) <> encode64(hash, 0)
    end
  end
 
  @doc """
  equivalent code below
    $hash = md5($salt . $password, TRUE);
    do {
      $hash = md5($hash . $password, TRUE);
    } while (--$count);
  """
  defp get_hash(password, hashed, count) do
    case count do
      -1 -> hashed
      _ -> get_hash(password, :crypto.hash(:md5 , hashed <> password), count - 1)
    end
  end
  
  @doc """
  equivalent strpos($this->itoa64, $str)
  """
  defp strpos(str) do
    case :binary.match(@itoa64, str) do
      {count, _} -> count
      _ -> 0
    end
  end

  @doc """
  encode64, encude64_2, encode_3 equivalent encode64 in PHP
  """
  defp encode64(input, i) do
    if i >= @count do
      ""
    else
      value = Enum.at(input, i)
      value2 = if i + 1 >= @count do
        value
      else
	value ||| (Enum.at(input, i + 1) <<< 8)
      end
      itoa64_at(value) <> itoa64_at(value2 >>> 6) <> encode64_2(input, i + 2, value2)        	
    end
  end

  @doc """
  encode64, encude64_2, encode_3 equivalent encode64 in PHP
  """
  defp encode64_2(input, i, value) do
    if i >= @count do
      ""
    else
      value2 = value ||| (Enum.at(input, i) <<< 16)
      itoa64_at(value2 >>> 12) <> encode64_3(input, i + 1, value2)        	
    end
  end

  @doc """
  encode64, encude64_2, encode_3 equivalent encode64 in PHP
  """
  defp encode64_3(input, i, value) do
    if i >= @count do
      ""
    else
      itoa64_at(value >>> 18) <> encode64(input, i)        	
    end
  end
  
  @doc """
  equivalent $this->itoa64[$value & 0x3f] in PHP
  """
  defp itoa64_at(pos) do
    String.slice(@itoa64, rem(pos, 64), 1)
  end

  if Mix.env == :test do
    def test_crypt_private(password, setting) do
      crypt_private(password, setting)
    end

    def test_strpos(str) do
      strpos(str)
    end
 
    def test_itoa64_at(pos) do
      itoa64_at(pos)
    end
  end

end

