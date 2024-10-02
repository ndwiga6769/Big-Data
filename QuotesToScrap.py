import requests
from bs4 import BeautifulSoup

# URL of the webpage to scrape
url = 'http://quotes.toscrape.com/'

# Send a GET request to fetch the webpage content
response = requests.get(url)

# Check if the request was successful (status code 200)
if response.status_code == 200:
    # Parse the webpage content with BeautifulSoup
    soup = BeautifulSoup(response.content, 'html.parser')

    # Find all quote elements on the page (quotes are inside <span> with class 'text')
    quotes = soup.find_all('span', class_='text')

    # Print each quote
    for idx, quote in enumerate(quotes, 1):
        print(f"{idx}. {quote.get_text()}")

else:
    print(f"Failed to retrieve the webpage. Status code: {response.status_code}")
