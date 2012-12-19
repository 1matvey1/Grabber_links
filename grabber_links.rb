class Grabber
require 'open-uri'
 attr_reader :url,:page,:text,:links,:level,:buf,:url_gets,:buf_links

Myfile = File.new("links.txt", "w")
	def grabber_links(url,lvl)
	url_gets = [url]
	buf_save = []
        buf_links = url_gets
	links = []
	level = lvl.to_i
        
		for i in 1..level
                         
			 url_gets.each do |j|
                         begin
                         	links = self.search_links(j, buf_links)   
			 	self.save_txt(j, links, i)
			 	buf_save += links
				buf_links += links
                         rescue
                         end
			end
		url_gets = buf_save
		buf_save = []
	 	end	
	'save for links.txt'
	end

def save_txt(url, links, level)
	
		Myfile.puts('level '+level.to_s + ' : ')
		Myfile.puts(url + '  : ')
			links.each do |i|
                          Myfile.puts(i) 
		end
	end
	
def search_links(url_new, buf_links)
		url = url_new
		page = open(url)
		text = page.read
		links = text.scan(/<a href=\"(.*?)\"/)       
		links = links.collect{|link| link=links_other_recources(link, buf_links, url)}-['']
		links = links.uniq
	end
	
	
def links_other_recources(link, buf_links, url)
	link = link.to_s      
          buf_links.each do |buf|
		if link.eql?(buf)==true || link.eql?(buf+'/')==true 
                        return ''
                end
          end 
		if link.include?("http://") == true || link.include?("https://") == true
               		return link       
                else	
			count = url.count "/"
                        if count >= 3
				url_mas = url.split('/')
				url = url_mas[0] + "//" + url_mas[2]
				return url + link   
			else
				''
			end	
                		     	
		end  
              
	end


end
grabber=Grabber.new
puts 'write site(http://name_site)'
url ='http://soccer.ru'
#url = gets 
#url = url.chomp
#p url
puts 'enter the level : '
level = gets
txt = grabber.grabber_links(url,level)
p txt






