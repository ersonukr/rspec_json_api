class Stodo < ApplicationRecord
  has_many :sitems, dependent: :destroy

  validates_presence_of :title, :created_by
end
