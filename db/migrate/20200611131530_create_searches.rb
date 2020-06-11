class CreateSearches < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
CREATE TABLE searches (
  id int(11) AUTO_INCREMENT PRIMARY KEY,
  keyword varchar(255),
  related_table varchar(32),
  related_key varchar(255),
  FULLTEXT(keyword) WITH PARSER ngram
)
CHARACTER SET utf8mb4
    SQL
  end

  def down
    execute <<-SQL
DROP TABLE IF EXISTS searches;
    SQL
  end
end
