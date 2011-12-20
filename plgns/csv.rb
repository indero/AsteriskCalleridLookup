#!/usr/bin/env ruby
require 'csv'

#CallerID Lookup - CSV
#Initial 2011/12/18

#check if the callerid is allready set.
if $cid == nil

    # We get the phonenumber as an argument
    ARGV.each do|a|
        #  puts "Argument: #{a}"
        tel = a
        #puts tel

        #read the csv file.
        array = CSV.parse(File.read('plgns/numbers.csv'))
        #puts array.inspect
        #search in the array for the telephonenumber
        search = array.assoc("#{tel}")
        #puts search
            if search == nil
                    $cid = nil
            else
                        #select the name from the array
                        $cid = search[1]
                        #print phonenumber on stdout
                        puts $cid 
            end
    end

end
