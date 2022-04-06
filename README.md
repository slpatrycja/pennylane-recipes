# Pennylane Recipes

A simple Rails and React app as a response for https://gist.github.com/quentindemetz/2096248a1e8d362e669350700e1e6add.

# 07-04-2022 Search engine update

### Background
The first version of Pennylane Recipes was using the "AND" operator for the ingredients list. Because of that, all ingredients queried in the searchbar had to be present in a recipe, for this recipe to be returned. The search used ts_vector and ts_query to match searched ingredients with the recipes. The relevance of the results was based on the overall amount of ingredients in the recipe, because if we searched for 3 ingredients, then the recipes with 3 ingredients are more relevant than the ones with 4 ingredients, which are more relevant than the ones with 5 ingredients and so on.

### Update

The search engine update was supposed to allow users to search for recipes with **at least one** of the queried ingredients but still keep the relevance of the recipes in tact.
The search part was the easiest one - it was enough to change the "AND" operator into an "OR" operator in the ts_query. How to sort the matched recipes was another story.

### Attempt no.1 - Using ts_rank function

Already using ts_vector and ts_query, [ts_rank](https://www.postgresql.org/docs/current/textsearch-controls.html#TEXTSEARCH-RANKING) was the first idea to fulfill the required change. This, however, did not work as desired.

**Why?**

When we think about the recipes, it seems logical that when matching phrases, short recipes should be ranked higher thank longer ones, because of the proportion of matched text to the overall text. However, this becomes more complex with a list of ingredients that can contain multiple ingredients, similar in name.

Let's look at the example of the **peanut butter** ingredient. We have two recipes:

```ruby
Recipe no.1
ingredients: ["1 pound white confectioners' coating (white almond bark), broken up", "1 (18 ounce) jar peanut butter (such as Jif®)"],
ingredients_number: 2
ingredients_tsvector: "'1':1,12 '18':13 'almond':7 'bark':8 'broken':9 'butter':17 'coat':5 'confection':4 'jar':15 'jif®':20 'ounc':14 'peanut':16 'pound':2 'white':3,6"

Recipe no.2
ingredients:
   ["1 cup all-purpose flour",
    "½ cup quick-cooking oats",
    "3 tablespoons brown sugar",
    "1 teaspoon baking powder",
    "½ teaspoon baking soda",
    "½ teaspoon sea salt",
    "⅛ teaspoon ground cinnamon, or to taste",
    "½ cup peanut butter",
    "¼ cup butter",
    "1 ⅓ cups buttermilk",
    "1 large egg",
    "⅓ cup chocolate chips",
    "¼ cup peanut butter",
    "¼ cup butter",
    "¼ cup confectioners sugar, or more to taste",
    "⅛ teaspoon sea salt",
    "cooking spray",
    "⅓ cup candy-coated milk chocolate pieces (such as M&M's®)"
   ],
ingredients_number: 18,
ingredients_tsvector: "'1':1,20,52,57 '3':15 'all-purpos':3 'bake':22,27 'brown':17 'butter':46,50,69,73 'buttermilk':55 'candi':95 'candy-co':94 'chip':64 'chocol':63,98 'cinnamon':38 'coat':96 'confection':77 'cook':12,89 'cup':2,9,44,49,54,62,67,72,76,93
 'egg':59 'flour':6 'ground':37 'larg':58 'm':102,103 'milk':97 'oat':13 'peanut':45,68 'piec':99 'powder':23 'purpos':5 'quick':11 'quick-cook':10 'salt':33,87 'sea':32,86 'soda':28 'spray':90 'sugar':18,78 's®':104 'tablespoon':16 'tast
':41,82 'teaspoon':21,26,31,36,85 '¼':48,66,71,75 '½':8,25,30,43 '⅓':53,61,92 '⅛':35,84"
```
It seems obvious that when searching for **peanut butter**, recipe no.1 will be ranked higher, because it's contains less irrelevant text than the recipe no.2, and we need only one additional ingredients instead of multiple. This does not happen when using ts_rank.

![but why](https://www.memecreator.org/static/images/memes/5214613.jpg)

**Explanation**

What ts_rank does is that it takes the given ts_query and counts the how many times it appeared in the ts_vector. In this case, "peanut" and "butter" is match (in total):
* 2 times in recipe no.1 (once for "butter" and once for "peanut")
* 7 times in recipe no.2 (4 times for "butter", once for "buttermilk" and 2 times for "peanut")

As we can see, counting the matches is not entirely accurate, because it can match the query with words irrelevant to it (like "buttermilk" in this case).

**Disclaimer**

There is always a chance that there's a workaround for that which would make the ts_rank method accurate for the recipes list. However, at the moment of writing this summary, it's not something that I was able to think of or find solution to.

### Attempt no.2 - Finding intersection between recipe's ingredients and queried ingredients

After a failed attempt with the ts_rank method, I've tried to think about some alternative. I figured that if we keep searching for the recipes using the ts_vector and ts_query, we could then convert ingredients_tsvector into an array and, as well as the queried ingredient list and see how big the intersection of those two is for each matched recipe. Then, the intersection size could be divided by the total ingredients number of the recipe and that would give us the ratio in which the recipe is fulfilled by the queried ingredients.

And it worked :)

Few points to mention here:
1. The intersection part is used only for the ranking part. The searching part still uses ts_vector and ts_query, to ensure that for multiple-word ingredients we don't have any partial matches (we don't want "peanut butter" to be matched with "butter").

2. The final intersection size used for the ranking function cannot be bigger than the number of queried ingredients and is limited by the **LEAST** method. This is due to the fact, that we have to split multiple-word ingredients into separate ones to do the intersection and we don't want this to bring irrelevancy into the ranking.

3. The recipe's ingredients count has to be converted to a decimal before dividing the intersection size by it. This is to ensure that we receive rank in a decimal format.


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
