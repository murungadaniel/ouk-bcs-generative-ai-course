import from byllm.llm { Model }

glob llm = Model(
    model_name="gemini/gemini-2.0-flash",
    verbose=False
);

# AI function to classify email text as spam or not spam
def classify_email(email_text: str) -> str by llm();

node Email {
    has content: str;

    can classify(visitor) with `root entry {
        result = classify_email(self.content);
        print(f"Email classification for: \"{self.content[:30]}...\" is: {result}");
    }
}

walker EmailSpamDetector {
    has emails: list[Email] = [];

    can add_email with `root entry {
        # Example emails; in practice, add dynamically
        self.emails.append(Email(content="Congratulations! You've won a prize. Click here to claim."));
        self.emails.append(Email(content="Meeting agenda for tomorrow's project update."));
        self.emails.append(Email(content="Earn money fast with this simple trick!"));
        self.emails.append(Email(content="Your invoice for last month's services attached."));
        for e in self.emails {
            root ++> e;
        }
        print("Emails added for classification.");
    }

    can classify_emails with `root entry {
        for e in self.emails {
            e.classify(self);
        }
    }
}

with entry:__main__ {
    detector = root spawn EmailSpamDetector();
    detector.add_email();
    detector.classify_emails();
}