# Course notes for Pair Programming with LLMs

My notebooks for https://www.deeplearning.ai/short-courses/pair-programming-llm/.

### Useful prompts for pair programming with LLMs

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
