# Recipes

## Description

Consumes the Contentful API for fetching recipes and displaying them using Ruby on Rails framework.

**User Interface**
- List view: displayes a preview of all recipes, including
  - Title
  - Image
- Detail view: display all the data for a recipe
  - Title
  - Image
  - List of Tags
  - Description
  - Chef Name

## Implementation considerations
- Contentful SDK for consuming API
  - Contentful Singleton client to avoid recreation of API client for each request
- Error handler for handling custom errors
- Backend exposes an API for retriving list and details of recipes (can be consumed via web UI interface or REST APIs)
  - Support for recipe list pagination via API using `skip` and `limit` params
- Markdown format description parsed and converted to corresponding html markup
- Separation of concerns for code extensibility and scalability
- Rspec coverage 95%+
- Bootstrap responsiveness for UI
- Integration of rubocop linter for code consistency
- Dockerfile for application containerization

---
## Setup

The project is a Ruby on Rails 5.0 app and the test framework is rspec-rails.

- Make sure Ruby 2.4.0 is installed (using `rvm` or `rbenv`) as mentioned in the `Gemfile`.
- Download the project (download the .zip file and extract it or clone the project using git).

  ```
  git clone git@github.com:tejasshah93/recipes.git
  ```
- Install the project dependencies using [`bundler`](https://bundler.io/).

  ```
  bundle install
  ```
- Set the following environment variables for consuming Contentful API
  - `CONTENTFUL_ACCESS_TOKEN`: Contentful access token (mandatory)
  - `CONTENTFUL_SPACE_ID`: Contentful space ID (mandatory)
  - `CONTENTFUL_ENVIRONMENT_ID`: Contentful environment ID (default value is `master` as configured in [`config.yml`](config/initializers/config.yml))
- Start the rails server (default port: 3000 or run on custom port using `-p` flag).
  ```
  bundle exec rails server
  ```
- Access the recipes server on http://localhost:3000

OR

**Using Docker**

- Build the docker image using the `Dockerfile` from the project root
  ```
  docker build -t recipe .
  ```
- Add the environment variables to a `.env` file in the project root
  ```
  echo 'CONTENTFUL_ACCESS_TOKEN=<access-token>' >> .env
  echo 'CONTENTFUL_SPACE_ID=<space-id>' >> .env
  echo 'CONTENTFUL_ENVIRONMENT_ID=<environment-id>' >> .env  # default: master
  ```
- Run the rails server in a docker container with these environment variables as follows:
  ```
  docker run --env-file .env -p 3000:3000 recipe
  ```
  (`-p` binds port 3000 of the container to TCP port 3000 on 127.0.0.1)
- Access the recipes server on http://localhost:3000

---

## Tests

From the project root directory,
- To execute all the tests, run:
  ```
  bundle exec rspec
  ```
- HTML report is generated in `coverage/index.html` for inspecting the percentage coverage of files.

---