CONNECTION = SQLite3::Database.new("gamereviewrepos.db")

CONNECTION.execute("CREATE TABLE IF NOT EXISTS genres (id INTEGER PRIMARY KEY, name TEXT);")

CONNECTION.results_as_hash = true