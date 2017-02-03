class Sitem < ApplicationRecord
  belongs_to :stodo

  validates_presence_of :name
end
