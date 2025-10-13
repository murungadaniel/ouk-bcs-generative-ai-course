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

def generate_question(difficulty: int) -> str by llm();
def check_answer(question: str, answer: str) -> bool by llm();

node Student {
has name: str;
has current_difficulty: int = 1;  # 1=Easy, 2=Intermediate, 3=Hard
has score: int = 0;
has total_questions: int = 0;
has consecutive_correct: int = 0;
}

node Question {
has difficulty: int;
has prompt: str;
has correct_answer: str;
}

node AssessmentFlow {
has session_active: bool = True;
}
edge delivers {}
edge answered_by {}

walker AssessmentWalker {
has student: Student;
has flow: AssessmentFlow;
has current_question: Question = None;
has ongoing: bool = True;

can start with `root entry {
    print(f"Starting assessment for {self.student.name}");
    self.next_question();
}

def next_question {
    if not self.ongoing {
        print("Assessment ended.");
        disengage;
    }

    # Generate a new question using LLM based on current difficulty
    question_prompt = generate_question(self.student.current_difficulty);

    # Create Question node dynamically with LLM generated prompt
    self.current_question = Question(difficulty=self.student.current_difficulty, prompt=question_prompt, correct_answer="");

    print(f"Question (Difficulty {self.current_question.difficulty}): {self.current_question.prompt}");
    let answer = input("Your answer: ");

    # Check correctness using LLM
    correct = check_answer(self.current_question.prompt, answer);

    self.flow +>:answered_by:+> self.current_question;

    self.process_answer(correct);
}

def process_answer(correct: bool) {
    self.student.total_questions += 1;

    if correct {
        print("Correct!");
        self.student.score += 1;
        self.student.consecutive_correct += 1;

        # Increase difficulty if 3 consecutive correct and not at max difficulty
        if self.student.consecutive_correct >= 3 and self.student.current_difficulty < 3 {
            self.student.current_difficulty += 1;
            print(f"Difficulty increased to {self.student.current_difficulty}.");
            self.student.consecutive_correct = 0;
        }
    } else {
        print("Incorrect.");
        self.student.consecutive_correct = 0;
    }

    # Stop after 10 questions
    if self.student.total_questions >= 10 {
        print(f"Assessment completed. Final score: {self.student.score}/{self.student.total_questions}");
        self.ongoing = False;
        disengage;
    } else {
        self.next_question();
    }
}
}

with entry {
flow = AssessmentFlow();
student = Student(name="Student1");
student ++>:delivers:+> flow;
AssessmentWalker(student=student, flow=flow) spawn root;
}