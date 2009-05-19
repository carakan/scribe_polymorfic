class Activity < ActiveRecord::Base
  belongs_to :creator, :polymorphic => true
  belongs_to :item, :polymorphic => true

  def self.created_by(model, id)
    Activity.find(:all, :conditions => ["(creator_type = ? AND creator_id = ?) OR (item_type = ? AND item_id = ?)", model, id, model, id])
  end

  def self.of_creator(model)
    Activity.find(:all, :conditions => ["creator_type = ? OR item_type = ?", model, model])
  end

  named_scope :since, lambda { |time|
    {:conditions => ["activities.created_at > ?", time] }
  }
  named_scope :before, lambda {|time|
    {:conditions => ["activities.created_at < ?", time] }
  }

  named_scope :limit_to, lambda{|limit| {:order => "created_at DESC", :limit => limit}}

  def without_model?
    item.nil?
  end
end
