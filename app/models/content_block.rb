# == Schema Information
# Schema version: 15
#
# Table name: content_blocks
#
#  id             :integer(11)   not null, primary key
#  group          :string(255)   default(""), not null
#  text           :text          
#  position       :integer(11)   default(0), not null
#  created_at     :datetime      
#  updated_at     :datetime      
#  blockable_id   :integer(11)   not null
#  blockable_type :string(255)   default(""), not null
#

# == Schema Information
# Schema version: 13
#
# Table name: content_blocks
#
#  id             :integer(11)   not null, primary key
#  group          :string(255)   default(""), not null
#  text           :text          
#  position       :integer(11)   default(0), not null
#  created_at     :datetime      
#  updated_at     :datetime      
#  blockable_id   :integer(11)   not null
#  blockable_type :string(255)   default(""), not null
#

class ContentBlock < ActiveRecord::Base
  attr_protected :created_at, :created_by
  belongs_to :blockable, :polymorphic=>true
  
  # update the page search index
  def after_save
    self.blockable.touch if self.blockable_type == 'Page'
  end
  
  def self.start_menu
    @@in_sub_menu = false
  end
  
  def self.end_menu
    return '</li></ul>' if @@in_sub_menu
    return ''
  end
    
  
  def menu_item
    if just_text =~ /^(.+?)<a(.*)$/
      ret = "<a#{$2}"
      unless @@in_sub_menu
        @@in_sub_menu = true
        ret = "<li><ul><li>#{ret}</li>"
        return ret;
      end
      ret = "<li>#{ret}</li>" 
      return ret
    end
    
    if @@in_sub_menu
      return "</li></ul><li>#{just_text}</li>"
    end
    return "<li>#{just_text}</li>"
  end
  
  #This strips off the surrounding <p> entered by the editor
  def just_text
    return $1 if text =~ /^<p>(.*)<\/p>$/
    text
  end
  
end
