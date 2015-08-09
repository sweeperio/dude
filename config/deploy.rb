# config valid only for current version of Capistrano
lock "3.4.0"

set :application, "dude"
set :repo_url, "git@github.com:sweeperio/dude.git"
set :chruby_ruby, "2.2.2"
set :use_sudo, false
