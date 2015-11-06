Rewardners
==============


System Requirements
-------------------

* Rails 4.2.1
* Ruby 2.2.2
* Postgresql
* SendGrid email service
* Mailcatcher (for development env).
* Foreman (for development env).

Running on
----------

* Rewardner Staging: [https://rewardners-st.herokuapp.com](https://rewardners-st.herokuapp.com)

_______

Installing Dependencies
-----------------------

```
  $ bundle install
```

Setting up Database
-------------------

There is a sample database configuration file at ``config/database.yml.example`` you would need to create a new ``config/database.yml`` and configure your [PostgreSQL](http://www.postgresql.org) configuration.

After configure your database server in rails:

* ``$ rake db:setup``


Running Rewardners
----------------------

```
  $ foreman start -f Procfile.dev
```

This will start the required services on development mode.


To scan for vulnerabilities
---------------------------

```
  $ rake brakeman:run
```
