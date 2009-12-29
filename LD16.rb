#!/usr/bin/env ruby
Dir.chdir(File.dirname(__FILE__))
$:.push(File.join(File.dirname(__FILE__),'ext'))
require 'MainWindow'

$window = LD16::MainWindow.instance
$window.show