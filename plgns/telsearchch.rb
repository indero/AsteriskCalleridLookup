#!/usr/bin/env ruby
require 'net/http'
require 'rexml/document'

#CallerID Lookup - tel.search.ch
# Intitial Version 2011/12/17 

#check if the callerid is allready set. 
if $cid == nil

    #You can insert your API key here.
    #get the API Key at http://admin.tel.search.ch/api/getkey
    apikey = ""
    #puts apikey

    # We get the phonenumber as an argument
    ARGV.each do|a|
        #  puts "Argument: #{a}"
        tel = a
        #puts tel


            #puts tel.size
            #swiss phonenumbers have to be at least 10 numbers.
            if tel.size < 10
                #puts "no Swiss number"
                #Set the error=true if the number is shorter than 10 digits
                num_error = true
            end
        #Testing Option. Most Company have a range of numbers. Only the few of them
        #are in the phone book. If I search without the last two digits its possible
        #to find the holder :)
        tel2 = tel[0..-3]
        #puts tel2
            
            #do not continiue if the number gets an error.
            if num_error == nil
                
                #if the API Key is empty search without the API String
                if apikey == ""
                    url = 'http://tel.search.ch/api/?was='+tel
                else
                    url = 'http://tel.search.ch/api/?was='+tel
                    url = url+'&key='+apikey
                end
            #puts url

            #get xml file and parse
            xml_data = Net::HTTP.get_response(URI.parse(url)).body
            #puts xml_data
            doc = REXML::Document.new(xml_data)
            root = doc.root

                #if we get an empty respose, we try the phone number without the last
                #two digits
                #puts root.elements["openSearch:totalResults"].text
                if  root.elements["openSearch:totalResults"].text == "0"
                    url = 'http://tel.search.ch/api/?was='+tel2
                    #	puts url
                    xml_data = Net::HTTP.get_response(URI.parse(url)).body
                    doc = REXML::Document.new(xml_data)
                    root = doc.root
                end

            #set the cid as the element title in the xml file    
            cid = root.elements["entry/title"].text
            #print phonenumber on stdout
            puts cid

            end
    end
end
