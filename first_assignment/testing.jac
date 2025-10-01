import from byllm.llm { Model }
import random;

glob llm = Model(model_name="gemini/gemini-2.5-flash");

enum SubjectArea {
    Mathematics,
    Physics,
    Chemistry,
    Biology,
}

# Step 1: Classify concept into subject area
 def get_subject_area(concept: str) -> SubjectArea by llm();

# Step 2: Generate a quiz question
 def generate_quiz_question(concept: str, subject: SubjectArea) -> str by llm();

# Step 3: Generate multiple-choice options with one correct answer
 # Use dict with concrete value types, avoid 'any' for schema generation
 def generate_mcq(concept: str, subject: SubjectArea) -> dict[str, object] by llm();

# Helper function to shuffle options using Python's random module
 def shuffle_list(lst: list[str]) -> list[str] {
    random.shuffle(lst);
    return lst;
}

with entry {
    let concept = input("Enter a science or math concept: ");
    let subject = get_subject_area(concept);
    let question = generate_quiz_question(concept, subject);
    let mcq = generate_mcq(concept, subject);

    # Shuffle options so the order changes every run
    let options = shuffle_list(mcq["options"]);

    print(f"\n📘 Concept: {concept}");
    print(f"📚 Subject Area: {subject}");
    print(f"❓ Question: {question}");
    print("📝 Options:");

    let i = 1;
    for opt in options {
        print(f"{i}. {opt}");
        i += 1;
    }

    let choice = int(input("\nEnter the number of your answer: "));
    let selected = options[choice - 1];

    if selected == mcq["correct"] {
        print(f"🎉 Correct! ✅ '{selected}' is the right answer.");
    } else {
        print(f"❌ Wrong. You chose '{selected}'. The correct answer is ✅ '{mcq["correct"]}'.");
    }
}