# Hangman – a terminal game

I built this as part of [The Odin Project](https://www.theodinproject.com/) Ruby track.  
It’s not perfect. But it works, and I learned more from this version than from the three messy attempts before it.

**Watch a demo:**  
[![asciicast](https://asciinema.org/a/gncN8MM59IVIN3JZ.svg)](https://asciinema.org/a/gncN8MM59IVIN3JZ)

---

## What this is

A classic Hangman game in your terminal.  
You guess letters (or the whole word) against a random 5‑12 letter word.  
8 wrong guesses and the session closes. Type `save` to pause, `exit` to quit.

---

## What I wanted to learn

- How to split code into modules and classes without over‑engineering  
- Custom exceptions (and using them for control flow – maybe too clever, but fun)  
- Save/load with YAML  
- A UI that doesn't feel like a school assignment (hence the cinematic vibe)  

---

## How to run it

```bash
git clone https://github.com/yourusername/hangman
cd hangman
bundle install
ruby main.rb

## What still nags me

- The save‑before‑game edge case is handled, but the message is misleading (it says “archived” even when nothing saved).  
- The UI modules mix instance and class methods in a way that future me will probably refactor.  
- Some error messages are more dramatic than helpful.  

But I’m calling it done. I need to move on to Rails.

## Credits

- Word list: [google-10000-english](https://github.com/first20hours/google-10000-english) (filtered to 5‑12 letters)  
- ASCII art header: custom, because why not  
- Colors: [`colorize`](https://github.com/fazibear/colorize) gem  
- Inspiration: The Odin Project community