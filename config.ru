#!/usr/bin/env rackup
#\ -w -o 127.0.0.1 -p 4567 -s puma
# encoding: utf-8

require_relative 'config/application'

run Template::App