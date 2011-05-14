namespace(:db) {
  desc "Drop tables [Database]"
  task(:drop) {
    require './init'
    Main.db_flush!
  }

  desc "Inspect the contents of the database [Database]"
  task(:dump) {
    require './init'
    require 'yaml'
    y Main.models.inject({}) { |h, model|
      h[model.name] = model.all.inject({}) { |hh, record| hh[record.id] = record.values; hh }
      h
    }
  }
}
