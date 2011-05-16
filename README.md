# Embassy
#### Online designer portfolio repository for PWDO

Requirements
------------

- **Ruby 1.9.2**
   - RVM: `rvm install 1.9.2`
   - Ubuntu: `sudo apt-get install ruby19`

- **[RVM](http://rvm.beginrescueend.com)** -- optional

Setup
-----

Create an RVM gemset (optional):

    rvm --rvmrc --create @myproject

Start:

    rake start   # or `rackup`, `thin start`, etc
    rake test

Heroku deployment
-----------------

    heroku create myapp --stack bamboo-mri-1.9.2

    # Or if you've already created it:
    heroku stack:migrate bamboo-mri-1.9.2

    heroku addons:add logging:expanded              # Provides `heroku logs --tail`
    heroku addons:add releases:basic                # Provides `heroku rollback` for release mgmt
    heroku addons:add pgbackups:basic               # Provides `heroku pgbackups:capture` for DB backups

    heroku addons:add custom_domains:basic
    heroku domains:add xxx.ph
    heroku config:add DOMAIN=xxx.ph

    heroku config:add HEROKU=1

    # Optional config
    heroku config:add AMAZON_ACCESS_KEY_ID=xxxx
    heroku config:add AMAZON_SECRET_ACCESS_KEY=xxxx
    heroku config:add AMAZON_S3_BUCKET=xxxx

Deploy:

    git push heroku master
