# The base class for all Hangman-related issues.
# Rescuing 'HangmanError' will catch any of the specific errors below.
class HangmanError < StandardError; end

# --- UI & Input Errors ---

# Raised when a player fails to provide a valid menu choice
# after a set number of attempts (e.g., 3 times).
class PermanentFailureError < HangmanError
  def initialize(msg = 'Maximum invalid attempts reached. Terminating session.')
    super
  end
end

# Raised when a player makes a bad choice
class BadGameChoice < HangmanError
  def initialize(msg = 'Invalid game choice')
    super
  end
end

# Raised when a player attempts to guess the full word, but the
# string length doesn't match the target word's length.
class InvalidWordLengthError < HangmanError
  def initialize(msg = 'Word guess length does not match the secret word.')
    super
  end
end

# Raised if the player enters a letter they have already guessed.
# This allows the Game class to reject the input before checking it.
class DuplicateGuessError < HangmanError
  def initialize(msg = 'This letter has already been guessed.')
    super
  end
end

# --- Data & File System Errors ---

# Raised if the Dictionary module cannot find or read
# the source text file (e.g., google-10000-english.txt).
class DictionaryNotFoundError < HangmanError
  def initialize(msg = 'The dictionary source file is missing or unreadable.')
    super
  end
end

# Raised when loading a saved game fails because the file
# is empty, improperly formatted, or contains "junk" data.
class SaveFileCorruptedError < HangmanError
  def initialize(msg = 'The save file is corrupted and cannot be loaded.')
    super
  end
end

# --- Game Control Signals ---
# These are technically exceptions, but we use them as "signals"
# to quickly break out of deep game loops when the user issues a command.

class GameSignal < StandardError; end

# Raised when the player types 'save' during gameplay.
class SaveGameSignal < GameSignal
  def initialize(msg = 'Player requested to save the game.')
    super
  end
end

# Raised when the player types 'exit' anywhere in the app.
class ExitGameSignal < GameSignal
  def initialize(msg = 'Player requested to exit the game.')
    super
  end
end

# Raised if the player chooses to continue a saved game from the main menu.
class ContinueGameSignal < GameSignal
  def initialize(msg = 'Player requested to load a saved game.')
    super
  end
end
