# Pari-magique

Rails Web site for users to predict the result of soccer games.

### Background

I had this idea in 2008. With a small group of friends we decided to predict the result of games during major competitions (Euro and World Cup). I was using a static html page. Users were sending me their guesses by email and I modified the html page manually. It was a lot of work.
In 2012, more friends joined and it would have been to much work to do everything manually so I created a more dynamic PHP Web site (using [Yii framework](www.yiiframework.com/)) where people could log in and enter their guesses. 
In 2017, I decided to switch to Rails because it is my favorite Web framework and I could add more features.

### Development process 

* design database 
* add authentication
* create relationships between models (ActiveRecord) 
* create sample forms (views) for all the models 
* add basic authorization 
* implements quickly some basic features (to have a better idea of the final project, kind of prototype) 
* review all features one by one and improve them and create tests
* improve design

### Deployment

The goal is to use github with [Heroku](https://www.heroku.com/) for easy deployment.

Ruby version **2.3.4** (latest version supported by Heroku)

#### Instructions 

TODO

### Tests

How to run the test suite. TODO



### Database

For a better understanding of the relations between the models, please have a look to the diagram ```db/DatabaseSchema.png```.

To create the database run: ```rake db:migrate```

To insert data run: ```rake db:seed```


### Roles and authorization

#### Site wide

##### admin

* manage all
* promote members to manager or admin

##### manager

* manage games (set result)

##### member

* see leagues
* create a league (and becomes coach)
* send a request to join a league (and becomes player)

##### unregistered user

* create an account (and becomes member)

#### League wide

##### coach

* add tournaments to a league
* accept requets from players to join the league
* promote players to coach

##### player

* see tournaments
* see games
* create guesses
* see rankings
