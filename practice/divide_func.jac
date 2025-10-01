
def divide(a:int,b:int) -> float{
    if b == 0{
        return f"ValueError: Division by zero is not allowed.";
    }
    else{
        return a / b;
    }
}

def subtract(a: int, b: int) -> int {
    return a - b;
}

with entry:__main__{
    print(divide(10,2));
    print(subtract(10,2));
}

