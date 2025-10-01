"""A Number Guessing Game"""

import from dotenv {load_dotenv as ld}
import os;
import random;
import from byllm.llm { Model }

# glob llm = Model(model_name="gpt-4o",verbose=False);
glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

def load_and_cache_api_key(){
    # Load variables from .env into the environment
    ld();
    # Retrieve the key
    api_key = os.getenv("GEMINI_API_KEY");
    if not api_key{
        raise ValueError("GEMINI_API_KEY not found in .env file");
    }
    # Optionally cache it into the current terminal session
    os.environ["GEMINI_API_KEY"] = api_key;  
    return api_key;
}

with entry{
    key = load_and_cache_api_key();
    print("API Key loaded and cached.");
}


"""Provide a fun hint if guess is incorrect"""
def give_hint(guess: int, correct_number: int) -> str by llm();

walker GuessGame {
    has guess: int;

    can start with `root entry;
    can process_guess with turn entry;
}

node turn {
    has correct_number: int = random.randint(1, 10);
}

# Will run when in CLI mode (not in cloud)
 with entry:__main__ {
    root spawn GuessGame(3);
    root spawn GuessGame(4);
    root spawn GuessGame(5);
    root spawn GuessGame(6);
}