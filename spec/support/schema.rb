ActiveRecord::Schema.define(version: 1) do
  create_table :some_classes do |t|
    t.string :title
    t.string :name
    t.text :description
    t.integer :some_integer
    t.references :another_class, index: true, foreign_key: true
    t.references :more_class, index: true, foreign_key: true

    t.timestamps
  end

  create_table :another_classes do |t|
    t.string :title
    t.string :name
    t.text :description
    t.integer :some_integer
    t.references :some_class, index: true, foreign_key: true

    t.timestamps
  end

  create_table :more_classes do |t|
    t.string :title
    t.string :name
    t.text :description
    t.integer :some_integer
    t.references :some_class, index: true, foreign_key: true

    t.timestamps
  end

end
