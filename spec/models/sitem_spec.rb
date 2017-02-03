require 'rails_helper'

RSpec.describe Sitem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it { should belong_to(:stodo) }
  it { should validate_presence_of(:name) }
end
