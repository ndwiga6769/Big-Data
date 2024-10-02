import requests
from bs4 import BeautifulSoup

# URL of the webpage to scrape
url = 'https://example.com'

# Send a GET request to the website
response = requests.get(url)

# Parse the webpage content with BeautifulSoup
soup = BeautifulSoup(response.content, 'html.parser')

# Find all article titles (assuming they are inside <h2> tags with class 'title')
titles = soup.find_all('h2', class_='title')

# Print each article title
for idx, title in enumerate(titles, 1):
    print(f"{idx}. {title.get_text()}")
