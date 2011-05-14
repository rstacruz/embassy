# Sequel
Sequel::Model.plugin :validation_helpers

Sequel.extension :inflector
Sequel.extension :pagination

class Main
  def self.models
    Object.constants.
      map    { |c| Object.const_get(c) }.
      select { |c| c.is_a?(Class) && c.ancestors.include?(Sequel::Model) }
  end

  def self.reload_models!
    models.each { |m| Object.send :remove_const, m.to_s.to_sym }
    Dir[root('app/models/*.rb')].each { |f| load f }
  end

  def self.db_flush!
    Main.database.tables.each { |t| database.drop_table t }
  end

  def self.db_migrate!
    load root('app/init/migrations.rb')
  end

  register Sinatra::SequelExtension
  helpers  Sinatra::SequelHelper
end

