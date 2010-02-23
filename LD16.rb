#!/usr/bin/env ruby
Dir.chdir(File.dirname(__FILE__))
$:.push(File.join(File.dirname(__FILE__),'ext'))
require 'helper'
require 'rubygems'
require 'MainWindow'

$window = LD16::MainWindow.instance
$window.show