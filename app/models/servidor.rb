class Servidor < ApplicationRecord
  self.table_name = 'servidores'

  validates :nome, :matricula, :cargo, :lotacao, :vinculo, :classe, presence: true
end
