CONNECTION = SQLite3::Database.new("gamereviewrepos.db")

CONNECTION.execute("CREATE TABLE IF NOT EXISTS genres (id INTEGER PRIMARY KEY, name TEXT);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, name TEXT);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS formats (id INTEGER PRIMARY KEY, name TEXT);")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS games (id INTEGER PRIMARY KEY, name TEXT, genres_id INTEGER, formats_id INTEGER, FOREIGN KEY(genres_id) REFERENCES genres(id), FOREIGN KEY(formats_id) REFERENCES formats(id) );")
CONNECTION.execute("CREATE TABLE IF NOT EXISTS reviews (id INTEGER PRIMARY KEY, games_id INTEGER, users_id INTEGER, score INTEGER, FOREIGN KEY(games_id) REFERENCES games(id), FOREIGN KEY(users_id) REFERENCES users(id) );")

CONNECTION.results_as_hash = true