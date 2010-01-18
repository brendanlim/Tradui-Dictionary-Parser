require 'rubygems'
require 'open-uri'
require 'hpricot'

doc = Hpricot(File.read("dictionary.xml"))

translations = [];
(doc/:term).each do |xml_term|
  creole = xml_term.attributes["word"]
  translations.push({"#{creole}" => xml_term.search("/value").collect{|x| x.innerHTML}})
end

translations.each do |hash_values|
  hash_values.each_pair do |key,values|
    values.each do |value|    
      p "INSERT INTO DICTIONARY (CREOLE,ENGLISH) VALUES ('#{key}','#{value}');"
    end
  end
end