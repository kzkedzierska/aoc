# This file contains helper functions

__all__ = ["verify_answer"]


def verify_answer(
    f: callable, example_input: str, expected_answer: int
) -> None:
    """Verify the answer"""
    result = f(example_input)
    if result == expected_answer:
        print(f"✔️ That's right! The answer is {expected_answer}.")
    else:
        print(f"❌ Expected {expected_answer}, but got {result}.")
