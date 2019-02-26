class PostReport < Struct.new(:word_count, :word_histogram)
  
  def self.generate(post)
    words = separate_post_in_words(post)
    PostReport.new(
      # word count
      words.count,
      # word histogram
      generate_histogram(words)
    )
  end

  private

    def self.separate_post_in_words(post)
      (post
        .content
        .split
        .map { |word| word.gsub(/\W/, '') }
      )
    end

    def self.generate_histogram(words)
      (words
        .map(&:downcase)
        .group_by { |word| word }
        .transform_values(&:size)
      )
    end
end