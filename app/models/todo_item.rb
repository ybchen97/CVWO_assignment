class TodoItem < ApplicationRecord
  has_and_belongs_to_many :tags

  # method to find all todo_items associated with a particular tag
  def self.tagged_with(name)
    Tag.find_by!(name: name).todo_items
  end
  
  # method to delete empty tags that have no todo items
  def self.delete_empty_tags
    Tag.all.each { |t| t.destroy if t.todo_items.empty? }
  end


  # virtual attribute 'all_tags'
  
  # setter
  def all_tags=(names)
    self.tags = names.split(/, |,/).map do |name|
      clean_name = name.downcase
      Tag.where(name: clean_name).first_or_create!
    end
  end

  # getter
  def all_tags
    #self.tags.present? ? 
    self.tags.map(&:name).join(', ') if tags.present?
  end

end
