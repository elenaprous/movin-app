class Search < ApplicationRecord
  belongs_to :user
  belongs_to :location

  #after_save :compute_score!, :compute_rank

  def compute_score!
    columns = Search.columns.select { |col| col.name.include?("score") }
    columns.each do |col|
      col = col.name

      score_from_user     = self.user.send(col) || 1
      score_from_location = self.location.send(col) || 1

      puts "#{col} - #{score_from_user} - #{score_from_location}"

      self.update(col => score_from_user * score_from_location)
      self.save!
    end
  end

  def compute_rank
    columns = Search.columns.select { |col| col.name.include?("score") }
    total   = 0

    columns.each do |col|
      column = col.name
      value = self.send(column)
      total += value
    end

    self.update(ranking: total)
    self.save!
  end
end
