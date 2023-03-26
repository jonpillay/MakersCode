# Diary class and Diary Entry intergration

> require 'diary'
> require 'diary_entry'

'''ruby

RSpec.describe "integration" do
  context "when we add DiaryEntry"
    it "comes back in the list"
      diary = Diary.new
      diary_entry = DiaryEntry.new("my_title", "my_contents")
      diary.add(diary_entry)
      expect(diary.all).to eq [diary_entry]
    end
  end
    context "when we want to total number of words"
    it "returns the total number of words"
      diary = Diary.new
      diary_entry = DiaryEntry.new("my title", "one two three")
      diary.add(diary_entry)
      expect(diary.count_words).to eq 3
    end
  end
  context "should count words"
    it "returns the word count"
      diary = Diary.new
      diary_entry = DiaryEntry.new("my title1", "one two three")
      diary_entry2 = DiaryEntry.new("my title2", "four five six" * 10)
      expect(diary.count_words).to eq 33 
    end
  end
  context "to estimate how long it would take to read the diary"
    it "returns estimate of the reading time"
      diary = Diary.new
      diary_entry = DiaryEntry.new("my title1", "one two three")
      diary_entry2 = DiaryEntry.new("my title2", "four five six" * 10)
      expect(diary.reading_time(16)).to eq 2 
    end
  end
  context "to find a suitable entry to raed given a specific time"
    it "returns a suitable diary entry"
      diary = Diary.new
      diary_entry = DiaryEntry.new("my title1", "one two three")
      diary_entry2 = DiaryEntry.new("my title2", "four five six" * 10)
      expect(diary.find_best_entry_for_reading_time(16, 30)).to eq [my_title2] 
    end
  end
end

'''