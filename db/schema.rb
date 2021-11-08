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

ActiveRecord::Schema.define(version: 2021_11_07_225104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "colunas", force: :cascade do |t|
    t.string "nome"
    t.integer "posicao"
    t.integer "projeto_id"
    t.integer "empresa_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status_id"
  end

  create_table "empresas", force: :cascade do |t|
    t.string "nome"
    t.string "nome_fantasia"
    t.string "sigla"
    t.string "cnpj"
    t.string "telefone"
    t.string "email"
    t.boolean "ativo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "projetos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.datetime "inicio_projeto"
    t.datetime "fim_projeto"
    t.integer "empresa_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sigla"
  end

  create_table "quadros", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.boolean "burndown"
    t.integer "pontuacao"
    t.integer "usuario_id"
    t.integer "coluna_id"
    t.integer "status_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sprint_id"
    t.integer "rank", default: 3
    t.datetime "baixada_dia"
  end

  create_table "sprints", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.datetime "inicio_sprint"
    t.datetime "fim_sprint"
    t.boolean "burndown"
    t.integer "pontuacao_total"
    t.integer "projeto_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "sprint_atual"
  end

  create_table "status", force: :cascade do |t|
    t.string "nome"
    t.string "cor_fundo"
    t.string "cor_fonte"
    t.integer "empresa_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "projeto_id"
    t.integer "rank", default: 1
    t.boolean "finalizador", default: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nome"
    t.string "login"
    t.string "senha"
    t.string "email"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "foto_file_name"
    t.string "foto_content_type"
    t.integer "foto_file_size"
    t.datetime "foto_updated_at"
  end

  create_table "usuarios_empresas", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "empresa_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "usuarios_projetos", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "projeto_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
