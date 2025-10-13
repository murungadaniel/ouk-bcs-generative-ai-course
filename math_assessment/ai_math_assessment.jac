# -------------------------------
# IMPORT LLM MODEL
# -------------------------------
import from byllm.llm { Model }

# Initialize the Model
glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

# -------------------------------
# LLM FUNCTIONS
# -------------------------------

def generate_question(difficulty: int) -> str by llm();

def check_answer(question: str, answer: str) -> bool by llm();

# -------------------------------
# NODE DEFINITIONS
# -------------------------------

node Student {
    has name: str;
    has current_difficulty: int = 1;
    has score: int = 0;
    has total_questions: int = 0;
    has consecutive_correct: int = 0;
}

node Question {
    has difficulty: int;
    has prompt: str;
    has correct_answer: str;  # Placeholder only, answer is verified by llm
}

node AssessmentFlow {
    has session_active: bool = True;
}

# -------------------------------
# EDGE DEFINITIONS
# -------------------------------

edge delivers {}
edge answered_by {}

# -------------------------------
# WALKER
# -------------------------------

walker AssessmentWalker {
    has student: Student;
    has flow: AssessmentFlow;
    has current_question: Question = None;
    has ongoing: bool = True;

    can start {
        print("Starting assessment for " + self.student.name);
        self.next_question();
    }

    def next_question {
        if not self.ongoing {
            print("Assessment ended.");
            disengage;
        }

        # Generate question using LLM
        let question_prompt = generate_question(self.student.current_difficulty);

        # Create Question node dynamically
        self.current_question = Question(
            difficulty=self.student.current_difficulty,
            prompt=question_prompt,
            correct_answer=""
        );

        print("Question (Difficulty " + str(self.current_question.difficulty) + "): " + self.current_question.prompt);
        let answer = input("Your answer: ");

        # LLM checks correctness
        let correct = check_answer(self.current_question.prompt, answer);

        self.flow +>:answered_by:+> self.current_question;

        self.process_answer(correct);
    }

    def process_answer(correct: bool) {
        self.student.total_questions += 1;

        if correct {
            print("Correct!");
            self.student.score += 1;
            self.student.consecutive_correct += 1;

            if self.student.consecutive_correct >= 3 and self.student.current_difficulty < 3 {
                self.student.current_difficulty += 1;
                print("Difficulty increased to " + str(self.student.current_difficulty));
                self.student.consecutive_correct = 0;
            }
        } else {
            print("Incorrect.");
            self.student.consecutive_correct = 0;
        }

        if self.student.total_questions >= 10 {
            print("Assessment completed. Final score: "
                + str(self.student.score) + "/" + str(self.student.total_questions));
            self.ongoing = False;
            disengage;
        } else {
            self.next_question();
        }
    }
}

# -------------------------------
# ENTRY POINT
# -------------------------------

with entry {
    spawn AssessmentWalker(
        student=Student(name="Student1"),
        flow=AssessmentFlow()
    );
}

