require 'rake'
require "rexml/document"
require './boot'

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

