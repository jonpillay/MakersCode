require 'multi_class_diary'
require 'diary_methods.rb'

RSpec.describe "integration" do
  context "when we add DiaryEntry" do
    it "comes back in the list" do
      diary = Diary.new("John")
      diary_entry = DiaryEntry.new("my_title", "my_contents")
      diary.add(diary_entry)
      expect(diary.all).to eq [diary_entry]
    end
  end
  context "when we want to total number of words" do
    it "returns the total number of words" do
      diary = Diary.new("John")
      diary_entry = DiaryEntry.new("my title", "one two three")
      diary.add(diary_entry)
      expect(diary.count_words).to eq 3
    end
  end
  context "should count words" do
    it "returns the word count" do
      diary = Diary.new("John")
      diary_entry = DiaryEntry.new("my title1", "one two three")
      diary_entry2 = DiaryEntry.new("my title2", "four five six butter " * 10)
      diary.add(diary_entry)
      diary.add(diary_entry2)
      expect(diary.count_words).to eq 43
    end
  end
  context "to estimate how long it would take to read the diary" do
    it "returns estimate of the reading time" do
      diary = Diary.new("John")
      diary_entry = DiaryEntry.new("my title1", "one two three")
      diary_entry2 = DiaryEntry.new("my title2", "four five six " * 10)
      diary.add(diary_entry)
      diary.add(diary_entry2)
      expect(diary.reading_time(16)).to eq 3
    end
  end
  context "to find a suitable entry to read given a specific time" do
    it "returns a suitable diary entry" do
      diary = Diary.new("John")
      diary_entry = DiaryEntry.new("my title1", "one two three")
      diary_entry2 = DiaryEntry.new("my title2", "four five six " * 10)
      diary.add(diary_entry)
      diary.add(diary_entry2)
      expect(diary.find_best_entry_for_reading_time(16, 30)).to eq diary_entry2
    end
  end
end