# frozen_string_literal: true

class Comment
  attr_reader :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save(gossip_id)
    CSV.open("./db/gossip_#{gossip_id}_comments.csv", 'ab') do |csv|
      csv << [@author, @content]
    end
  end
  
  def self.all(gossip_id)
    begin
      all_comments = []
      CSV.read("./db/gossip_#{gossip_id}_comments.csv").each do |line|
        all_comments << Comment.new(line[0], line[1])
      end
      all_comments
    rescue StandardError
      'No comment'
    end
  end
end

