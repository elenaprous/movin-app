class Search < ApplicationRecord
  belongs_to :user
  belongs_to :location
  
  after_save :compute_score_and_rank

  def compute_score_and_rank
    compute_score!()
    compute_rank!()
  end

  private

  def compute_rank!
    columns = Search.columns.select { |col| col.name.include?("score") }
    total   = 0

    columns.each do |col|
      column = col.name
      value = self.send(column)

      total += value
    end

    self.update(ranking: total)
  end

  def compute_score!
    columns = Search.columns.select { |col| col.name.include?("score") }
    columns.each do |col|
      col = col.name

      score_from_user     = self.user.send(col) || 1
      score_from_location = self.location.send(col) || 1

      self.update(col => score_from_user * score_from_location)
    end
  end
end
