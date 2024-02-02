# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_02_02_061239) do
  create_table "servidores", force: :cascade do |t|
    t.string "nome", null: false
    t.integer "matricula", null: false
    t.string "cargo", null: false
    t.string "lotacao", null: false
    t.string "vinculo", null: false
    t.string "classe", null: false
    t.date "data_admissao", null: false
    t.float "salario_liquido", default: 0.0, null: false
    t.date "ultima_atualizacao", default: -> { "CURRENT_DATE" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
