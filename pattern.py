import re

name = "Michael Jackson"
pattern = r"Jackson"

result = re.search(pattern, name)

if result:
    print(f"The pattern '{pattern}' was found in the name '{name}'.")
else :
    print(f"The pattern '{pattern}' was Not found in the name '{name}'.")

