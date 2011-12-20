#!/usr/bin/env ruby

#CallerID Lookup - Mainfile
#Initial 2011/12/17

#set callerid to nil
$cid = nil

#load the plugins
load 'plgns/csv.rb'
load 'plgns/telsearchch.rb'
