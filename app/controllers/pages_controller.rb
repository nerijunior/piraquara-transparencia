require 'faraday'

class PagesController < ApplicationController
  def home
    @servidores = Servidor.order(:salario_liquido, :desc).all
  end
end
