require 'rails_helper'

RSpec.describe Tool, type: :model do
  let!(:tool) { create(:tool) }
  subject { described_class.new(title: 'test') }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  describe '#tagged_with' do
    let!(:tag) { create(:tag) }
    subject { Tool.tagged_with(tag.name) }

    describe 'when is called without unknown' do
      it 'returns nil array' do
        expect(subject).to match_array([])
      end
    end

    describe 'when is called with a tag' do
      describe "when there is not tools with that tag" do
        it 'returns nil array' do
          expect(subject).to match_array([])
        end
      end
      
      describe "when there is no tools with that tag" do
        let!(:tagging) { create(:tagging, tag: tag) }
      
        it 'returns a tool array' do
          expect(subject.count).to eql(1)
        end
      end
    end
  end

  describe '#tag_list' do
    subject { tool.tag_list }

    describe 'when there are no tags' do
      it 'returns nil' do
        expect(subject).to be_empty
      end
    end
    
    describe 'when there is a tag' do
      let!(:tagging) { create(:tagging, tool: tool) }
      
      it 'returns an array of tags' do
        expect(subject).to eql([tagging.tag.name])
      end
    end
  end

  describe '#add_tags' do
    describe 'when it is called with tags' do
      subject { tool.add_tags(['Microsoft', 'Linux']) }

      it 'adds all tags' do
        subject
        expect(tool.tags.count).to eql(2)
      end
    end
  end

  describe '#as_json' do
    it 'returns a json from Tool object' do
      expect(tool.as_json).to match({
        id: tool.id,
        title: tool.title,
        link: tool.link,
        description: tool.description,
        tags: tool.tag_list
      })
    end
  end
end
