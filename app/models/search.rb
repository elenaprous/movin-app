class Search < ApplicationRecord
  belongs_to :user
  belongs_to :location

  def compute_score!
    columns = Search.columns.select { |col| col.name.include?("score") }
    columns.each do |col|
      col = col.name

      score_from_user     = self.user.send(col) || 0
      score_from_location = self.location.send(col) || 0

      puts "#{col} - #{score_from_user} - #{score_from_location}"

      self.update(col => score_from_user * score_from_location)
      self.save!
    end
  end
end
