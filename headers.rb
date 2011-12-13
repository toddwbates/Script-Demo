#! /usr/bin/env ruby

require "rexml/document"
dest = File.open(ARGV[1],File::CREAT|File::WRONLY,0777)
src = REXML::Document.new File.open(ARGV[0])

src.elements.each("//@storyboardIdentifier").each do 
    |element| 
    if element.value != "" 
        dest.puts "#define k_storyboard"+ element.value + " @\"" + element.value + "\""
    end 
end 

src.elements.each("//@reuseIdentifier").each do 
    |element| 
    if element.value != "" 
        dest.puts "#define k_reuseIdentifier"+ element.value + " @\"" + element.value + "\""
    end 
end 

src.elements.each("//@tag").each do 
    |element| 
    if element.value != "" 
        dest.puts "#define k_tag"+ element.value + " @\"" + element.value + "\""
    end 
end 

dest.close

puts "ruby says goodbye"





