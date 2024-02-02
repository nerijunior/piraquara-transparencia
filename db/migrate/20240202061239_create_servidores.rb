class CreateServidores < ActiveRecord::Migration[7.1]
  def change
    create_table :servidores do |t|
      t.string :nome, null: false
      t.integer :matricula, null: false
      t.string :cargo, null: false
      t.string :lotacao, null: false
      t.string :vinculo, null: false
      t.string :classe, null: false
      t.date :data_admissao, null: false
      t.float :salario_liquido, null: false, default: 0

      t.date :ultima_atualizacao, null: false, default: -> { 'CURRENT_DATE' }

      t.timestamps
    end
  end
end
