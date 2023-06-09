$LOAD_PATH << '.'
$LOAD_PATH << '/lib/'

require 'diary_methods.rb'
require 'multi_class_todo'

class Diary
  def initialize(name)
    @name = name
    @entries = []
    @todo = TodoList.new(name)
  end

  def todo
    @todo
  end

  def add(entry) # entry is an instance of DiaryEntry
    @entries << entry
  end

  def all
    @entries
  end

  def count_words
    # Returns the number of words in all diary entries
    # HINT: This method should make use of the `count_words` method on DiaryEntry.
    @entries.map { |n| n.count_words_diary_entry }.sum
  end

  def reading_time(wpm) # wpm is an integer representing
                        # the number of words the user can read per minute
    # Returns an integer representing an estimate of the reading time in minutes
    # if the user were to read all entries in the diary.
    (self.count_words/wpm.to_f).ceil
  end

  def find_best_entry_for_reading_time(wpm, minutes)
        # `wpm` is an integer representing the number of words the user can read
        # per minute.
        # `minutes` is an integer representing the number of minutes the user
        # has to read.
    # Returns an instance of diary entry representing the entry that is closest 
    # to, but not over, the length that the user could read in the minutes they
    # have available given their reading speed.
    readable = wpm * minutes
    best = nil
    result = nil
    for i in @entries do
      if best == nil || i.count_words_diary_entry - readable < best
        result = i
      end
    end
    return result
  end
end