# Inspired-API

Simple Sinatra application responsible for providing a new video every day through a single endpoint.  
The endpoint returns JSON data containing the video preview image, title and id.

The videos come from predefined Youtube channels and are fetch through Youtube Data API.

Videos are filtered and ordered depending on a number of criterias such as quality, length and view count.

You can download the Android App that uses this API here: [Inspired Android app](https://play.google.com/store/apps/details?id=com.neilrosenstech.inspired&hl=en).  
Which has an open source repo as well: [https://github.com/Raindal/Inspired-Android](https://github.com/Raindal/Inspired-Android).

## How to run it locally

* Clone the repo

* If you are using RVM, just trust the .rvmrc to install the desired ruby and create a new gemset

* Bundle to install the gems listed in the Gemfile

* You'll need a Youtube Data API key in order to populate your database with Youtube videos. Create a new server 
API key through the Google Developer Console tools and put it in an environment variable named 
`YOUTUBE_DATA_API_KEY`

* Create the database with `rake db:create db:migrate`. This will create a new database file 
`development.sqlite3` in the `db` folder. Copy this database to create a `test.sqlite3` file used by RSpec

* Populate the database with `rake inspired:create_set`. This should take no more than 5 to 10 seconds to 
complete. You will end up with 10 videos. If this doesn't work maybe you didn't set the YOUTUBE_DATA_API_KEY 
correctly. In that case try running the command like so:

```
$ rake inspired:create_set YOUTUBE_DATA_API_KEY="your-key-here"
```

* Verify that you actually have videos in the db:

``` ruby
$ pwd
/home/neil/Dev/inspired-api
$ irb
> require './inspired'
=> true
> Video.count
=> 10
```

* Run the server with `ruby inspired.rb`

* Navigate to `http://localhost:4567/[today]` replacing `[today]` with the current date. For instance, if today 
is April 18 2015, then you have to write `http://localhost:4567/20150418` or `http://localhost:4567/20150418.js`

* You should see something like:

```
{"image_url":"https://i.ytimg.com/vi/672jKuyzkX4/maxresdefault.jpg","video_id":"672jKuyzkX4","title":"GoPro: Furious 7 - Behind the Scenes"}
```

## How to contribute

* Make sure all tests are green before starting to code:

```
$ rspec
...............................

Finished in 1.69 seconds (files took 0.54748 seconds to load)
31 examples, 0 failures
```

* Create a feature branch

* Write tests for your feature

* Make a pull request
