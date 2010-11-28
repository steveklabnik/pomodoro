Pomodoro
========

A gem to make you productive.

Wait, what?
-----------

Yeah, that's right. See, there's this great [noprocrast gem](https://github.com/rfwatson/noprocrast) that tuns off your access to time-sucking sites, like Twitter and Hacker News. The problem with the gem is that you have to turn it on and off yourself, and I don't have that kind of self-control. I'll forget to turn it back on, and then keep wasting time.

So I avoided doing more work by making Yet Another Gem: Pomodoro!

The Technique
-------------

The '[pomodoro technique](http://en.wikipedia.org/wiki/Pomodoro_Technique)' is a time-management technique named after tomatos. I have no idea, either. Basically, you work for 25 minutes, and then take a break for 5.

So what's it actually do?
-------------------------

Basically, when you start it up, it changes your /etc/hosts file to redirect websites to localhost. Then, it does two things: starts up `thin` to run a tiny website on localhost that tells you you're a bad person if you try to visit one of those sites, and spins up a thread to run in the background, that checks every 5 minutes to see if the timer is up. Once 25 minutes have gone by, it lets you back into your sites, and 5 minutes later, shuts you out again.

Oh, and you get growl notifications every time the switch happens.

How do I get it?
----------------

Small note: This only really works with OSX. Patches welcome!

Just `gem install pomodoro`. Easy-peasy!

How do I use it?
----------------

Just `sudo pomodoro start` in a terminal. If you're using rvm, you may want to `rvmsudo` instead.

Sudo is needed because noprocrast messes with your /etc/hosts file. Since that's neccesary, I also decided to run the local site on port 80, for simplicity's sake, and that takes root permissions too.

If this worries you, [check out the source](http://github.com/steveklabnik/pomodoro). It's real short. No tricks up my sleeve!

If you'd like to change the sites it blocks, `sudo noprocrast edit` will open your $EDITOR and let you change it up.

Future stuff
------------

* Eventually, I'm sure this could be useful on other platforms.
* Maybe a simple to-do list with HTML5 local storage could be cool, rather than yelling. Dunno.
* Pretty icons for growl
* Growl notifications on how much time you have left.
