class AddMatchCountToChampionship < ActiveRecord::Migration
  def change
    add_column :championships, :matches_count, :integer, default: 0
    ids = Set.new
    Match.all.each { |c| ids << c.championship_id }
    ids.each do |championship_id|
      Championship.reset_counters(championship_id, :matches)
    end
  end
end
