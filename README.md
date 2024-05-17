# Dog Image Fetcher Service

This is a simple application that allows users to fetch random dog images associated with specific breeds. It consists of a Ruby on Rails backend for handling dog creation requests and a DogImageFetcher service for fetching dog images from a Dog API. Additionally, there is a React application for viewing and interacting with the dog images.

## Features

- **Dog Creation:** Users can submit a dog breed, and the application fetches a random dog image associated with that breed using the DogImageFetcher service.

- **Search Dog During Creation:** Users can submit a dog breed, and the application searches for the dog with breed and if it exists in the database then it fetches dog image associated with that breed from the database.

- **Error Handling:** The application gracefully handles errors during the Dog API request and form submission.

- **React Application:** The React application provides a simple form for users to submit a dog breed and view the associated random dog image.

## Rails Setup

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/akhil2109kumar/dog-image-fetcher.git
   cd dog-image-fetcher
   ```
2. **Install Dependencies:**
* Ruby version
  3.0.0

* Rails version
  7.0.8

* bundle install command
  ```
  bundle install
  ```
* Create database
  ```
  rake db:create
  ```
  
* Run migration
  ```
  rake db:migrate
  ```

* Copy application.yml.sample in application.yml 
  ```
  cp config/application.yml.sample config/application.yml
  ```

* To start the server
  ```
  rails server -p 3001
  ```

* To run the rspecs
  ```
  rspec
  ```

# TOOLS USED

* Rspecs for test cases.
* Sqlite3 Database Used
