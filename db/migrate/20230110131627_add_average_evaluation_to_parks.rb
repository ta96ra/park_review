class AddAverageEvaluationToParks < ActiveRecord::Migration[6.1]
  def change
    add_column :parks, :average_evaluation, :float
  end
end
