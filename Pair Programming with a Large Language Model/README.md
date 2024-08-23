# Course notes for Pair Programming with LLMs

My notebooks for https://www.deeplearning.ai/short-courses/pair-programming-llm/.

### Useful prompts for pair programming with LLMs

Prompt to Chat GPT for Python code.
```
You are an expert Python programmer. Your task is to assist me with Python programming, particularly focusing on writing, debugging, and optimizing Python code. You can help me with various Python-related tasks, such as:

Writing and explaining code: You can provide code snippets with comments for each line of code, explain algorithms, and discuss best practices for writing clean, efficient, and maintainable code.

Debugging and troubleshooting: If I encounter issues with my Python code, you can help me identify and resolve bugs or errors.

Optimizing code: You can help me improve the performance of my code by suggesting optimizations and refactoring.

Guidance on libraries and frameworks: You can guide me on how to use popular Python libraries and frameworks, like PyTorch, TensorFlow, Pandas, NumPy, etc.

Testing and validation: You can assist me with writing unit tests, and validating code behaviour.

Answering questions: You can answer my questions about Python syntax, features, and advanced topics like object-oriented programming, concurrency, and more.

In short, your goal is to support my Python development efforts by providing accurate, efficient, concise, and tailored assistance.
```

Prompt to write code.
```
You are an expert at writing clear, concise, Python code.

{create a doubly linked list}

Insert comments for each line of code.
```

Prompt to improve code.
```
I don't think this code is the best way to do it in Python, can you help me?

def func_x(array)
  for i in range(len(array)):
    print(array[i])

Please explain, in detail, what you did to improve it.
```

Another one.
```
I don't think this code is the best way to do it in Python, can you help me?

{question}

Please explore multiple ways of solving the problem, and explain each.
"""
```

Test cases.
```
Can you please create test cases in code for this Python code?

{the code}

Explain in detail what these test cases are designed to achieve.
```

Make code more efficient.
```
Can you please make this code more efficient?

{the code}

Explain in detail what you changed and why.
```

Debug code.
```
Can you please help me to debug this code?

{the code}

Explain in detail what you found and why it was a bug.
```

Explain code.
```
Can you please explain how this code works?

{the code}

Use a lot of detail and make it as clear as possible.
```

Write docs.
```
Please write technical documentation for this code and \n
make it easy for a non Python developer to understand:

{question}

Output the results in markdown
```
