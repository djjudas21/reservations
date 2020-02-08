#!/bin/sh
rake db:create
rake db:schema:load
rails server
