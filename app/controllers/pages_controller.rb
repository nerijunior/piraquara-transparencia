require 'faraday'

class PagesController < ApplicationController
  def home
    @servidores = Servidor.order(:salario_liquido).all
  end
end
