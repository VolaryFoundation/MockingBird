
require 'spec_helper'

describe Group do
  
  before do
    @group = build :group
  end
  
  describe 'name' do

    it 'should require a name' do
      @group.name = nil
      @group.should_not be_valid
    end
    
    it 'should have a unique name' do
      @group.save
      group = build :group, name: @group.name
      group.should_not be_valid
    end
  end

  describe 'size' do

    it 'should allow size ot be nil' do
      @group.size = nil
      @group.should be_valid
    end
    
    it 'should have a size that eqauls spcific options' do
      @group.size = 'something wrong'
      @group.should_not be_valid
    end
  end
  
  describe 'range' do

    it 'should have require a range' do
      @group.range = nil
      @group.should_not be_valid
    end
    
    it 'should be invalid if range is not in options' do
      @group.range = 'something wrong'
      @group.should_not be_valid
    end
  end

  describe 'status' do

    it "should have a default value of pending" do
      @group.status.should be == 'pending'
    end

    it 'should require a status' do
      @group.status = nil
      @group.should_not be_valid
    end
    
    it "should be invalid if an non-option is passed in" do
      @group.status = 'something wrong'
      @group.should_not be_valid
    end
  end
  
  describe 'location' do
    it 'should be able to have a location' do
      org = build :group_with_loc
      org.should be_valid
    end
  end
  
  describe 'link' do
    it 'should be able to have a link' do
      org = build :group_with_links
      org.should be_valid
    end
  end

  describe '.keywordize' do
   
    it 'should format a string as an array of keywords' do
      keywords = Group.keywordize('foo BAR')
      keywords.should be == [ 'foo', 'bar' ]
    end 
  end

  describe '.generate_keywords' do
    
    it 'should assign keywordized name and description as .keywords array' do
      group = create :group, name: 'foo bar', description: 'bat baz'
      group.keywords.should include('foo', 'bar', 'bat', 'baz')
    end
  end

  describe '.search' do

    before do
      @query = Group.build_query({
        keywords: 'Foo Bar',
        sizes: [ '1-10' ],
        ranges: [ 'local' ],
        tags: { a: 'require', b: 'reject', c: '' },
        geo: [ 0.1, -0.1, 1000 ],
        keys: { a: 1, b: 2 }
      })
    end

    describe 'keywords filter' do

      it "should include formatted array of keywords in query" do
        @query[:keywords].should be == { :$in => [ 'foo', 'bar' ] }
      end
    end

    describe 'sizes filter' do

      it 'should include sizes as part of $in array' do
        @query[:size].should be == { :$in => [ '1-10' ] }
      end
    end

    describe 'ranges filter' do

      it 'should include ranges as part of $in array' do
        @query[:range].should be == { :$in => [ 'local' ] }
      end
    end

    describe 'tags filters' do

      it 'shoudl show required and rejected tags' do
        @query[:tags].should be == { :$in => [ 'a' ], :$nin => [ 'b' ] }
      end
    end

    describe 'geo filter' do

      it 'should include complex geo query' do
        @query[:'location.lng_lat'].should be == { :$near => { :$geometry => { type: 'Point', coordinates: [ 0.1, -0.1 ] } }, :$maxDistance => 0.15696123057604772 }
      end
    end

    describe 'keys filter' do

      it 'should build query correctly' do
        @query[:a].should be 1
        @query[:b].should be 2
      end
    end
  end
end
