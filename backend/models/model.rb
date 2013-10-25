require_relative './todo'

module Model
  def setup(env)
    db_dir = 'sqlite://' + File.expand_path('../../db', __FILE__)

    case env
    when :test
      DataMapper.setup :default, 'sqlite::memory:'
    when :development, :production
      DataMapper.setup :default, "#{db_dir}/#{env.to_s}.db"
    else
      DataMapper.setup :default, "#{db_dir}/development.db"
    end

    DataMapper.finalize
    DataMapper.auto_upgrade!
  end

  module_function :setup
end
