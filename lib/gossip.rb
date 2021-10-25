# frozen_string_literal: true

class Gossip
  attr_reader :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open('./db/gossips.csv', 'ab') do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read('./db/gossips.csv').each do |line|
      all_gossips << Gossip.new(line[0], line[1])
    end
    all_gossips
  end

  def self.find(gossip_id)
    all[gossip_id]
  end

  def self.delete_gossip(gossip_id)
    all_gossips = all
    all_gossips.delete_at(gossip_id)
    CSV.open('./db/gossips.csv', 'w')
    all_gossips.each do |gossip|
      CSV.open('./db/gossips.csv', 'a') do |csv|
        csv << [gossip.author, gossip.content]
      end
    end
  end

  def self.edit_gossip(gossip_id, gossip)
    all_gossips = all
    all_gossips[gossip_id] = gossip
    CSV.open('./db/gossips.csv', 'w')
    all_gossips.each do |g|
      CSV.open('./db/gossips.csv', 'a') do |csv|
        csv << [g.author, g.content]
      end
    end
  end
end
