#! /usr/bin/env ruby

require "rexml/document"

def processsAttribute(src,dest,attributeName)
    src.elements.each("//@" + attributeName).each do 
        |element| 
        if element.value != "" 
            dest.puts "#define k_" + attributeName + "_" + element.value + " @\"" + element.value + "\""
        end 
    end 
end

def  processsStoryboard(file,srcDir,destDir)
    
    dest = File.open(destDir + File.basename(file,".storyboard") + ".h",File::CREAT|File::WRONLY|File::TRUNC,0777)    
    src = REXML::Document.new File.open( srcDir + file )
    
    processsAttribute(src,dest,"storyboardIdentifier")
    processsAttribute(src,dest,"reuseIdentifier")
    processsAttribute(src,dest,"tag")
    
    src.elements.each("//segue") do 
        |element|
        if element.attributes["identifier"]
            dest.puts "#define k_segue_"+ element.attributes["identifier"] + " @\"" + element.attributes["identifier"] + "\""
        end
    end 
    
    dest.close
end

def processsXib(file,srcDir,destDir)
    basename = File.basename(file,".xib")
    dest = File.open(destDir + basename + "_xib.h",File::CREAT|File::WRONLY|File::TRUNC,0777)    
    src = REXML::Document.new File.open( srcDir + file )
    
    dest.puts "#define k_xib_" + basename + " @\"" + basename + "\""

    dest.close
end

Dir.foreach(ARGV[0]) do 
    |file| 
    expression =  /.storyboard$/
    if expression.match file #filename ends with .storyboard
         processsStoryboard(file,ARGV[0],ARGV[1])
    end
    
    expression =  /.xib$/
    if expression.match file #filename ends with .xib
        processsXib(file,ARGV[0],ARGV[1])
    end
end





