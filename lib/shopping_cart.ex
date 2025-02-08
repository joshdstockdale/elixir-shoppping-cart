defmodule ShoppingCart do
  @moduledoc """
  Documentation for `ShoppingCart`.
  """

  def add_item(cart, product_name, amount, inventory) do
    # Does item exist?
    case InventoryManager.get_product(inventory, product_name) do
      nil ->
        {:error, :product_not_found}

      product when product.quantity >= amount ->
        new_cart = [{product.name, amount} | cart]
        new_inventory = InventoryManager.remove_inventory(inventory, product.name, amount)
        {:ok, new_cart, new_inventory}

      _ ->
        {:error, :insufficient_stock}
    end
  end

  def remove_item(cart, product_name, amount, inventory) do
    case InventoryManager.get_product(inventory, product_name) do
      nil -> {:error, :product_not_found}

      product when cart.quantity >= amount ->
        new_cart = [{product.name, cart.quantity - amount}]
        new_inventory = InventoryManager.add_inventory(intentory, product.name, amount)
        {:ok, new_cart, new_inventory}

        _ ->
          {:error, :insufficient_cart}
    end
  end

  def remove_first([_head | tail]) do
    tail
  end

  def get_first(cart) do
    List.first(cart)
  end

  def get_last(cart) do
    List.last(cart)
  end

  def get_total(cart, discount \\ 0) do
    List.foldl(cart, 0, fn item, total -> item.price + total end)
    |> subtract_discount(discount)
  end

  defp subtract_discount(total, discount) do
    total * (100 - discount) / 100
  end
end
