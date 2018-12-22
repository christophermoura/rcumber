# README

## Overview of RCumber

RCumber is a rails plugin that gives your customers a web interface where they can view, edit and run Cucumber tests directly on your rails project.

First you need to have "rspec":http://github.com/dchelimsky/rspec/tree/master, "rspec-on-rails":http://github.com/dchelimsky/rspec-rails/tree/master and "Cucumber":https://github.com/cucumber/cucumber installed and you'll need to have some cucumber tests written in your project.

## Documentation / Wiki

> ~~http://github.com/jgoodsen/rcumber/wikis~~

## Current Features

Currently, Rcumber is just a simple CRUD viewer for cucumber tests in a rails project with the ability to run the tests and see the results.
	
### KNOWN BUGS

* Not displaying `stderr` in test results - Need a tighter way to run than using `system() ?`
* Not handling creating a new test with the same name as an existing test - currently overwrites
* need to improve field checking, error handling and help on creation screen - it's confusing - do they really need to manage the filename?

### ROADMAP / UPCOMING FEATURES 

* Show all tests next to the current test for faster navigation.
* Create a demo/home site at radsoft.com where people can play with this plugin
* Add some screen shots to the home site
* Graphical commander panel to run and show the red/green
* Run all tests or a selected set of tests at once
* Click on a stack trace in the results and navigate to textmate
* Extract user configurable parameters into a ./config file
* Integrate some relevant 3rd party agile articles/blogs on story tests and cucumber using a feed from radsoft.com (user definable).
* better graphical feedback on a test run
* structured editing of a cucumber test
* subversion and git integration for auto-commit of story test updates

### 3rd PARTY INTEGRATION PLANS

* Integration with radtrack - see radtrack project for details

## Installation

If you're looking at this right now - it's only been a day since I've pulled this out of a project (and I'm still a newbie at building my own plugin) - and there's some kinks - here they are - any help would be appreciated!:

### Add to your routes

You need to add the following to your `routes.rb` until I figure out how to bootstrap this in the plugin init process:

```
map.rcumber 'rcumber', :controller => 'rcumbers', :action => 'index' 
map.resources :rcumbers do |rcumber|
  rcumber.run 'run', :controller => 'rcumbers', :action => 'run'
end
```

It's simple to add rcumber to your rails project - just install it as plugin into your project:

```
   cd ./vendor/plugins
   git clone git://github.com/jgoodsen/rcumber.git
   cd rcumber
   rake rcumber:install  <-- all this does is copy the nifty cucumber.gif to your /images directory
```

Step two:  just start your rails server and visit http://localhost:3000/rcumber

---

That's it!  You should be looking at your cool cukes through a sexy web interface.

