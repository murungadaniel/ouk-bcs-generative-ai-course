import from byllm.llm { Model }
import from dotenv { load_dotenv as ld }
import os;

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

glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

def get_answer(question: str)-> str by llm (
    # AI-generated answer placeholder
    # return "Answer";
);

# with entry {
#     let user_input = input("Ask any question (type 'exit' to quit): ");
#     if user_input.lower() == "exit" {
#         print("Goodbye!");
#     } else {
#         let response = get_answer(user_input);
#         print("AI says:", response);
#     }
# }

with entry {
    while True {
        let user_input = input("Ask any question (type 'exit' to quit): ");
        if user_input.lower() == "exit" {
            print("Goodbye!");
            break;
        } else {
            let response = get_answer(user_input);
            print("AI says:", response);
        }
    }
}