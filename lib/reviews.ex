defmodule Reviews do
  def get_reviews() do
    [
      %{rating: 5, text: "A Great Product", date: ~D[2024-01-01]},
      %{rating: 4, text: "A Good Product", date: ~D[2024-02-01]},
      %{rating: 3, text: "A Mid Item", date: ~D[2024-03-01]},
      %{rating: 2, text: "A Not Really a good product", date: ~D[2024-04-01]},
      %{rating: 1, text: "A Meh item", date: ~D[2024-05-01]}
    ]
  end

  def get_ratings(reviews) do
    Enum.map(reviews, fn review -> review.rating end)
  end

  def get_average_rating(reviews) do
    reviews
    |> Enum.map(fn review -> review.rating end)
    |> Enum.sum()
    |> divide_reviews(reviews)
  end

  defp divide_reviews(sum, reviews) do
    sum / length(reviews)
  end

  def filter_ratings(reviews, rating) do
    Enum.filter(reviews, fn review -> review.rating >= rating end)
  end

  def date_sorted(reviews) do
    Enum.sort_by(reviews, & &1.date, :desc)
  end

  def most_common_words(reviews) do
    word_list(reviews)
    |> word_frequencies()
    |> top_five()
  end

  defp word_list(reviews) do
    Enum.flat_map(reviews, &String.split(&1.text))
    |> Enum.map(&String.downcase/1)
  end

  defp word_frequencies(word_list) do
    Enum.frequencies(word_list)
  end

  defp top_five(word_frequencies) do
    Enum.sort_by(word_frequencies, fn {_, value} -> value end, :desc)
    |> Enum.take(5)
  end
end
