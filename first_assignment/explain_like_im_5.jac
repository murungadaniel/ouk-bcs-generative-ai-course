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

# """This function rewrites complex text to be understood like a 5-year-old"""
def rewrite_text(text: str) -> str by llm(
    system_prompt="""
    You are a friendly teacher explaining things to a 5-year-old child.
    - Use very simple words.
    - Use short sentences.
    - Avoid complex or formal words.
    - If needed, explain using examples from daily life (like toys, school, or play).
    - Keep it cheerful and clear.
    Return only the rewritten text with no extra commentary.
    """
);

node InputText {
    has original: str;
    has rewritten: str = "";
}

walker TextRewriter {
    has input_text: str;

    can rewrite with `root entry {
        # Spawn a single InputText node and access it as a list then take first element
        input_nodes = root ++> InputText(original=self.input_text);
        input_node = input_nodes[0];  # Access the first (and only) node from the list
        # Call LLM to rewrite the text simply
        rewritten_text = rewrite_text(input_node.original);
        input_node.rewritten = rewritten_text;
        print(f"Original: {input_node.original}");
        print(f"Rewritten for a 5 year old: {input_node.rewritten}");
    }
}


with entry:__main__ {
    # Example usage: user pastes a complex paragraph
    complex_paragraph = """
                            Area is the measure of a region's size on a surface. 
                            The area of a plane region or plane area refers to the area of a shape or planar lamina, 
                            while surface area refers to the area of an open surface or the boundary of a three-dimensional object.
                        """;
    # Spawn the walker with input text
    root spawn TextRewriter(input_text=complex_paragraph);
}
