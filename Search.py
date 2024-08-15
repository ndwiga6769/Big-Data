import re

state = 'kenya is a good country'

look = r"kenya"

results = re.search(look, state)

if results:
    print "r{look} is found"
else:
    print "r{look} is not found"