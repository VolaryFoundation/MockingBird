require 'rake'
require "rexml/document"
require './app/boot'

task :spec do
  system('rspec --color --format d ./spec')
end

namespace :db do
    
    task :load_factory do
      require 'faker'
      require "./spec/faker_extras.rb"
      require 'factory_girl'
      FactoryGirl.find_definitions
    end
    
    desc "load test data for the entire application"
    task :seed => :load_factory do
      random_group_number = [*5..10].sample
      random_group_number.times do |index|
        org = FactoryGirl.build(:group_with_loc, name: "Test Group ##{index + 1}")
        if org.save
          random_event_number = [*2..6].sample
          random_event_number.times do |eindex|
            event = FactoryGirl.create(:event_with_loc, name: "Test Event ##{index + 1}-#{eindex + 1}")
          end
        end
      end
      tags = ["age.child", "age.high school", "age.college", "age.young adult", "age.18+", "age.21+", "age.seniors", "age.singles", "age.moms", "age.dads", "philosophy.secular", "philosophy.agnostic", "philosophy.atheist", "philosophy.bright", "philosophy.conservative", "philosophy.freethought", "philosophy.freemason", "philosophy.humanist", "philosophy.liberal", "philosophy.libertarian", "philosophy.naturalist", "philosophy.objectivist", "philosophy.pastafarian", "philosophy.rationalism", "philosophy.skeptic", "philosophy.transhumanist", "philosophy.unitarian", "philosophy.other philosophy", "minority group.women", "minority group.LGBT", "minority group.African", "minority group.Asian", "minority group.European", "minority group.Hispanic", "minority group.minority group", "occupation.clergy", "occupation.military", "occupation.psychic", "occupation.teacher", "occupation.therapist", "occupation.other occupation", "ex-religious.ex-religious", "ex-religious.ex-Christian", "ex-religious.ex-Islamic", "ex-religious.ex-Mormon", "ex-religious.ex-Jewish", "ex-religious.ex-cult", "event type.meeting.conference", "event type.meeting.festival", "event type.meeting.member meet", "event type.meeting.committee meet", "event type.meeting.meeting", "event type.social.social", "event type.social.party", "event type.social.outing", "event type.social.dining", "event type.social.alcohol", "event type.camp", "event type.fundraising", "event type.educational", "event type.talk.lecture", "event type.talk.debate", "event type.talk.philosophy", "event type.talk.sunday school", "event type.talk.bible study", "event type.talk.discussion", "event type.media.book", "event type.media.movie", "event type.performance.theatre", "event type.performance.music", "event type.performance.choir", "event type.performance.comedy", "event type.performance.community.parade", "event type.performance.community.volunteer", "event type.performance.community.outreach", "event type.performance.community.rally", "event type.performance.community.community", "event type.performance.political", "event type.performance.sports", "topics", "topics.12-step", "topics.blog", "topics.business", "topics.church/state", "topics.civil rights", "topics.environment", "topics.family", "topics.feminism", "topics.government", "topics.health", "topics.history", "topics.homeschool", "topics.human rights", "topics.humor", "topics.law", "topics.military", "topics.politics", "topics.psychology", "topics.reddit", "topics.religion.Christian", "topics.religion.Jewish", "topics.religion.Islamic", "topics.religion.Buddhist", "topics.religion.cult", "topics.religion.religion", "topics.science", "topics.self-help", "topics.sexuality", "other.public transit", "other.handicapped access", "other.pet friendly", "other.child care", "other.free parking"] 
      tags.each { |t| Tag.create( name: t ) }
    end
    
    desc "Clear the database"
    task :clear do 
      MongoMapper.database.collections.each do |collection|
        unless collection.name.match(/^system\./)
          collection.remove
        end
      end
    end
end

desc "load test groups from alldata.xml"
 task :import_groups do
   require "rexml/document"
   include REXML
   file = File.new("test.xml")
   content = file.read
   @doc = Document.new(content.force_encoding("ISO-8859-1").encode("UTF-8"))
   @array_of_groups = Array.new
   @array_of_fails = Array.new
   @doc.root.elements[1].elements.each do |group|
     the_group = Group.new()
     #Build Group with no Associations.
     #Go though each element and set attributes based of element node name
     group.elements.each do |element|
       (the_group.name = element.text.present? ? element.text.strip : nil) if element.name == 'name'
       #next line is range. It relates to the size tag in the xml data
       (the_group.range = element.text.present? ? element.text.downcase : 'local') if element.name == 'size'
       if element.name == 'other_tags'
         element.text.gsub(" ", '').split(',').each do |tag|
           the_group.tags << tag.downcase unless the_group.tags.include?(tag.downcase)
         end
       end
       
       if element.name == 'philosophy_tag'
         unless the_group.tags.include?(element.text.downcase)
           the_group.tags << element.text.downcase 
           
         end
       end
     end
     # Item that are needed but not in the XML Data
     if the_group.save
       puts "Created #{the_group.name}"
       puts "    With tags: #{the_group.tags.join(', ')}"
       ##build Associations.
       group.elements.each do |element|
         #create main link
         if element.name == "url" && element.text.present?
           array_of_links = element.text.split(/,/)
           array_of_links.each do |the_link|
             the_group.links.build(name: the_link, url: the_link, type: 'Website')
             if the_group.save
               puts "  Create link: #{the_link}"
             else
               puts "  Failed to create link"
             end
           end
         end
       
         #Create Calender Link
         if element.name == "calendar_page_url" && element.text.present?
           array_of_links = element.text.split(/,/)
           array_of_links.each do |the_link|
             the_group.links.build(name: the_link, url: the_link, type: 'Calendar')
             if the_group.save
               puts "  Create link: #{the_link}"
             else
               puts "  Failed to create link"
             end
           end
         end
       
         #Create Podcast Link
         if element.name == "podcast_url" && element.text.present?
           array_of_links = element.text.split(/,/)
           array_of_links.each do |the_link|
             the_group.links.build(name: the_link, url: the_link, type: 'Podcast')
             if the_group.save
               puts "  Create link: #{the_link}"
             else
               puts "  Failed to create link"
             end
           end
         end
       
         #Create Facebook Link
         if element.name == "facebook" && element.text.present?
           array_of_links = element.text.split(/,/)
           array_of_links.each do |the_link|
             the_group.links.build(name: the_link, url: the_link, type: 'Facebook')
             if the_group.save
               puts "  Create link: #{the_link}"
             else
               puts "  Failed to create link"
             end
           end
         end
       
         #Create all Custon links
         array_of_custom_link_fields = ['public_contact_url','atheist_nexus', 'twitter', 'magazine', 'newsletter', 'book']
         if element.text.present? && array_of_custom_link_fields.include?(element.name)
           array_of_links = element.text.split(/,/)
           array_of_links.each do |the_link|
             the_group.links.build(name: the_link, url: the_link, type: 'Other')
             if the_group.save
               puts "  Create link: #{the_link}"
             else
               puts "  Failed to create link"
             end
           end
         end
       
         #Create all blog Links
         array_of_blog_links = ['blog_url', 'youtube_vlog']
         if array_of_blog_links.include?(element.name) && element.text.present?
           array_of_links = element.text.split(/,/)
           array_of_links.each do |the_link|
             the_group.links.build(name: the_link, url: the_link, type: 'Blog')
             if the_group.save
               puts "  Create link: #{the_link}"
             else
               puts "  Failed to create link"
             end
           end
         end
       
         #add the location
         if element.name == "address" && element.text.present?
           results = Geocoder.search(element.text).first
           unless results.nil?
            location = Location.new()
            location.state = results.state if results.state.present?
            location.country = results.country if results.country.present?
            location.city = results.city if results.city.present?
            location.postal_code = results.postal_code if results.postal_code.present?
            location.address = results.street_address if results.street_address.present?
            location.lng_lat = [results.longitude, results.latitude]
            if location.valid?
              the_group.location = location
              the_group.save
              puts " #{location.address}, #{location.city}, #{location.state}, #{location.country}"
            else
              puts " Failed to create location"
            end
          end
          sleep(1.0/10.0)
         end
       end
     else
       puts "Failed to create #{the_group.name} becuase:"
       the_group.errors.each do |key, value|
         puts "    #{key}: #{value}"
       end
     end
     puts "----------- Next Group ----------"

   end

 end

 task :sync_to_eagle do
  refsets = Group.all.to_a.inject([]) do |groups, group|

    data = {}

    # facebook
    fb_link = group.links.select { |l| l.type == 'Facebook' }.first
    if fb_link
      data[:facebook] = fb_link[:url]
    end

    # meetup
    meetup_link = group.links.select { |l| l.to_json.contains('Meetup') }.first
    if meetup_link
      data[:meetup] = meetup_link[:url]
    end

    # mockingbird
    data[:mockingbird] = group.id

    groups << data

    groups
  end
  
 end

