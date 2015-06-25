# Game Review Database

## Description:

We've got a few different tables we want to create for this:
- A game table, listing the game being reviewed, and the genre of the game
- A "genre" table, listing the type of game (fantasy, RPG, etc)
- A user table, listing the user's name
- A medium table, listing the medium the game is produced for (video game, card game, board game, etc)
- A review table, listing the user posting the review, and the review of the game.

We've got some one-to-many relationships, namely Genre(one) -> Game(many), User(one) -> Review(many)
and we've got a many-to-many relationship:  Game -> Review <- User.

###"Should" Cases
- Should be able to add new users/games/genres/reviews/mediums to a database 
- Should be able to modify existing data points in our database
  (i.e. Should be able to change a user's name, a review number, etc.)
- Should be able to delete from all tables in our database
- Should be able to read all contents of a table, and also data relating to data between two tables
  (i.e. Should be able to pull all reviews for a specific game, all games in a genre, etc.)
- Should be able to create multiple reviews for a user, or a game


### "Should Not" Cases
- Should not be able to add a game review without a rating value, corresponding user, or game to review
- Should not be able to add a game that is already listed, nor a game without a genre
- Should not be able to add a user or genre that are empty
- Should not be able to delete a game or user with a review connected
- Should not be able to delete a game with a genre or medium connected

###Additional Requirements
- Unit tests for all business logic
- Ability to fully interact with the application from the browser