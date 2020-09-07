# Écarté
A classic game of Écarté

This is a learning project that allows the user to play a classic game of Écarté, an old French trick-taking game.

Notable features are:

  * Procedurally generating the deck of cards (trivially expanded to use different suits, higher/lower values, etc)
  * User input validation. No answer the user gives can cause a crash or unexpected behavior; instead, the program simply asks for different input
  * Strong scoring logic to determine which of two cards should be the 'winner'. Multiple criteria are considered
  * Deliberate object-oriented approach to design. Player and team objects are passed around between discreet, simple functions to complete tasks
  * Well thought-out variable names. One could conceivably learn to play this game just by reading the code
  * Thoughtful UI. It's only only the terminal, but that doesn't mean it has to be ugly. Careful consideration has been put in to spacing and layout.

It should be noted that the user has to play both sides of the game. Adding a bot player is v2.
