# Pari-magique

Rails website for users to predict the result of soccer games.

### Background

In 2008, I had an idea to create a website to bet with my friends on soccer games during major competitions (Euro and World Cup). I was using static html pages. Users were sending me their guesses by email and I modified the html pages manually. It was a lot of work.
In 2012, more friends joined and I didn't want to do everything manually so I created a more dynamic PHP website (using [Yii framework](www.yiiframework.com/)) where people could log in and enter their guesses.
In 2017, I decided to switch to Rails because it is my favorite Web framework and I decided to use Github and Heroku.


### Deployment


#### Production environment

The goal is to use Github with [Heroku](https://www.heroku.com/) for easy deployment.

After creating an account and setting up Heroku, execute the following commands to deploy Pari-magique.

```
$ heroku create
$ git push heroku master
$ heroku addons:create rediscloud:30
$ heroku run rake db:migrate
$ heroku open
$ heroku logs
```

The version of bundler of this project should match with the version of bundler used on Heroku.

#### Development environment

##### Redis

Please follow the tutorial from  [Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04) to install Redis otherwise the chat will failed.

##### Start the server

Execute the following commands to start the server:

```
$ bundle install --without production
$ rake db:migrate
$ rake db:seed
$ rails s
```

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

* see factions
* create a faction (and becomes coach)
* send a request to join a faction (and becomes player)

##### unregistered user

* create an account (and becomes member)

#### Faction wide

A faction is a group of users. For example, you can be a member of a faction with your friends and a member of a second faction with your coworkers.

##### coach

* add tournaments to a faction
* accept requets from players to join the faction
* promote players to coach

##### player

* see tournaments
* see games
* create guesses
* see rankings
