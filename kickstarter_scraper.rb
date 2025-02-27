# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # This just opens a file and reads it into a variable
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  
  projects = {}
  
  # Iterate through the projects
  kickstarter.css("li.project.grid_4").each do |project|
    # projects[project] = {} #this won't work
    # each project title is a key, and the value is 
      # another hash with each of our other data points as keys
    title = project.css("h2.bbcard_name strong a").text
    
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta li a span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
    }
  end
  
  #return projects hash
  projects
end

create_project_hash