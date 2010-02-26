#!/usr/bin/env ruby
Dir.chdir(File.dirname(__FILE__))
%w{ext Components}.each do |dir|
  $LOAD_PATH.push(File.join(File.dirname(__FILE__),dir))
end
require 'helper'
require 'rubygems'
require 'MainWindow'

$window = LD16::MainWindow.instance
$window.show