# Project Keeper

## Description
Project Keeper is CMS application designed to assist users in managing various projects and/or tasks. It's uses [Sinatra](http://www.sinatrarb.com/), a ruby web application framework and uses [Twitter Bootstrap](http://getbootstrap.com/) for styling.


## Installation

#### (Step 1) Install the following gems on your local machine:
##### Bundler
```
$ gem install bundler
```
##### Rack
```
$ gem install rack
```
##### Sinatra
```
$ gem install sinatra
```
##### Shotgun
```
$ gem install shotgun
```

#### (Step 2) Create a fork of Project Keeper:
* [Click the **_Fork_** button on the top-right corner of the page](https://help.github.com/articles/fork-a-repo/).

#### (Step 3) Clone a local copy of the repository:
* [Click on the **_Clone or download_** dropbox.](https://help.github.com/articles/cloning-a-repository/)
* Select either **_Clone with HTTPS_** or **_Clone with SSH_** and copy the clone the url.

**HTTPS:** `https://github.com/YOUR-USERNAME/project_keeper.git`

**SSH:** `git@github.com:YOUR-USERNAME/project_keeper.git`
* Open your terminal and paste in the url (don't forget to change *"YOUR-USERNAME"* to your github account).

```
$ git clone https://github.com/YOUR-USERNAME/project_keeper.git
Cloning into 'project_keeper'...
remote: Counting objects: 705, done.
remote: Compressing objects: 100% (678/678), done.
remote: Total 705 (delta 394), reused 0 (delta 0), pack-reused 4
Receiving objects: 100% (705/705), 99.15 KiB | 0 bytes/s, done.
Resolving deltas: 100% (394/394), done.
Checking connectivity... done.
```

#### (Step 4) Use Bundler to install your project's gems:
Bundler will Mange your application dependencies and create *Gemfile.lock* file.
```
$ cd project_keeper/
$ bundle install
```

#### (Step 5) Migrate your database:
```
$ bundle exec rake db:migrate
```

#### (Step 6) Startup your server (*shotgun*):
```
$ bundle exec shotgun
== Shotgun/Thin on http://127.0.0.1:9393/
Thin web server (v1.7.0 codename Dunder Mifflin)
Maximum connections set to 1024
Listening on 127.0.0.1:9393, CTRL+C to stop
```

#### (Step 7) Bring up Project Keeper in your browser:
* Go to either <http://127.0.0.1:9393/> or <http://localhost:9393/> and verify Project Keeper is up and running!


## Creator
Dom McKellar
* <http://newme.io/>
* <https://github.com/Dom-Mc>


## License
Project Keeper is an open-sourced software licensed under the [MIT license](https://github.com/Dom-Mc/project_keeper/blob/master/LICENSE).
