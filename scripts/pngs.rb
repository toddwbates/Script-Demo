#! /usr/bin/env ruby

dest = File.open(ARGV[1] + "pngs.h",File::CREAT|File::WRONLY|File::TRUNC,0777)    

Dir.foreach(ARGV[0]) { 
    |file| 
    expression =  /.png$/
    if expression.match file #filename ends with .png
        basename = File.basename(file,".png")
        dest.puts "#define k_png_" + basename + " [UIImage imageNamed:@\"" + basename + "\"]"
    end
}




