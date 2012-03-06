# Heroku Cloner

Lots of times I want to clone one of my heroku apps to a different
machine. Usually, I've pushed from home and want to pull to work.

Anyway, I can never remember the 'git clone ...', so this script does
just that. Nothing more.

And tis the way, I found [this](http://github.com/ddollar/heroku-clone)
afterwards which is even better.

Meh,...

# Usage
Create a .creds.yml file that looks like this

```ruby
username: myemail@address
password: blahblahblahblah
```

$: sudo ln -s /full/path/to/this/ruby/script /bin/hc

$: hc

Enter the num and press enter.

Clones to $PWD
