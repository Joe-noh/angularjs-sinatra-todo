require_relative './spec_helper'

describe TodoAppBackend do

  before do
    Todo.destroy!
    5.times { Todo.gen! }
  end

  context 'GET' do
    it 'returns all todos' do
      get '/api/todos'
      expect(JSON.parse(last_response.body).size).to eql 5
    end

    it 'returns a todo specified by ID' do
      todo = Todo.first
      get "/api/todo/#{todo.id}"
      res = JSON.parse(last_response.body)
      expect(res['body']).to eql todo.body
    end
  end

  context 'POST' do
    it 'creates new todo' do
      post '/api/todos', body: 'buy some more milk'
      todo = Todo.first(body: 'buy some more milk')
      expect(todo).not_to be_nil
    end

    it 'does not create duplicated todo' do
      post '/api/todos', body: 'run 10 miles'
      count = Todo.count
      post '/api/todos', body: 'run 10 miles'
      expect(Todo.count).to eql count
    end
  end

  context 'PUT' do
    it 'updates existing todo' do
      before = Todo.first
      put "/api/todo/#{before.id}", body: 'New Todo', done: !before.done
      after = Todo.get(before.id)
      expect(after.body).to eql 'New Todo'
      expect(after.done).to eql !before.done
    end

    it 'does not execute updates that make duplication' do
      first_one = Todo.first
      another = Todo.last
      put "/api/todo/#{another.id}", body: first_one.body
      another = Todo.get(another.id)
      expect(another.body).not_to eql first_one.body
    end
  end

  context 'DELETE' do
  end
end
