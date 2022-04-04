# Pennylane Recipes

A simple Rails and React app as a response for https://gist.github.com/quentindemetz/2096248a1e8d362e669350700e1e6add.

# Deliverable
## Demo

The demo app is accessible at https://pennylane-recipes-slpatrycja.herokuapp.com/. Please note that the demo app is running
on a Hobby Heroku instance, which becomes inactive after 30 minutes of no traffic.
For this reason, the first few requests may take longer than they should.
It is recommended to refresh the page a couple of times upon first entry.

## Database structure

![Database structure](https://i.ibb.co/0fMzFjb/Zrzut-ekranu-2022-04-4-o-22-12-36.png)

## User stories
1) As a user, I want to find recipes with all ingredients given in the searchbar
2) As a user, I want to be able to see what the dish looks like when looking at the recipes
3) As a user, I want to be able to choose recipes from a category that interests me
4) As a user, I want to see recipes with the smallest number of additional ingredients as the first ones

# Installation

## Requirements

- Ruby 3.0.1 (using http://rvm.io/)
  ```
  rvm install 3.0.1
  rvm use 3.0.1
  ```
- Node 14.18.0 or higher (using nvm)
  ```
  nvm install 14.18.0
  nvm use 14.18.0
  nvm alias default 14.18.0 -- makes it a default node version
  ```
- Yarn
  ```
  npm install --global yarn
  ```
- Redis
- PostgreSQL

## Setup

Run:
```
bundle install
yarn install
rails db:create db:migrate
rake oneoffs:02042022_fill_database_from_json_file
```

# Development

## Code conventions
- Rubocop (Ruby code analyzer)
  ```
  bundle exec rubocop path/to/file.rb
  ```

## React
The app is using React 18.

## Starting app
Run
```
./bin/dev
```
to run a development server on localhost:3000.

# Testing

## Rspec
```
bundle exec rspec
```

# Production

## Rails console
```
heroku run bundle exec rails c --remote production
```
