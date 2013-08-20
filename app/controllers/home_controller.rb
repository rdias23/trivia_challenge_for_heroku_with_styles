class HomeController < ApplicationController
  def index
    @users = User.all

    @scoreboards_maester = Scoreboard.where("score_type = 'maester'")
    @high_score_sorted_array_of_hashes_maester = @scoreboards_maester.sort_by { |hsh| hsh[:score] }.reverse
    @count_maester = 1 
    @is_first_score_maester = "true" 
    @previous_score_maester = 9999999999

    @limit_maester_scores_to_ten = 1

    @scoreboards_archmaester = Scoreboard.where("score_type = 'archmaester'")
    @high_score_sorted_array_of_hashes_archmaester = @scoreboards_archmaester.sort_by { |hsh| hsh[:score] }.reverse
    @count_archmaester = 1
    @is_first_score_archmaester = "true"
    @previous_score_archmaester = 9999999999

    @limit_archmaester_scores_to_ten = 1
  end
end
