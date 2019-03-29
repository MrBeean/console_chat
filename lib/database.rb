require 'sqlite3'

class DataBase
  def initialize(db_path)
    @db = SQLite3::Database.open(db_path)
  end

  def action_with_db(query, boolean = false)
    @db.results_as_hash = boolean
    @db.execute(query)
  end
end
