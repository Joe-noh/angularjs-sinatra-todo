class Todo
  include DataMapper::Resource

  property :id,   Serial
  property :body, String,  required: true
  property :done, Boolean, default: false

  validates_uniqueness_of :body, message: "We already have the TODO"
end
