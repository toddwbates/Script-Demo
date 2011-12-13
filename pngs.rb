#! /usr/bin/env ruby

require "rexml/document"
dest = File.open(ARGV[0],File::CREAT|File::WRONLY,0777)

Dir.foreach(".") { |file| 
    expression =  /.png$/
    if expression.match file #filename ends with .png
        name = File.basename(file,".png")
        dest.puts "#define k_png_"+ name + " @\"" + name + "\""
    end
}

dest.close





