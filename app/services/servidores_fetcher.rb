class ServidoresFetcher
  def fetch_and_store
    current_page = 0
    finished = false

    until finished
      puts "Buscando servidores, pagina: #{current_page}"
      response = fetch_servidores_page(page: current_page)

      Servidor.transaction do
        response['content'].each do |servidor|
          create_servidor!(servidor)
        end
      end

      finished = response['last']
      current_page += 1
    end

    puts 'Finalizado'
  end

  def fetch_salarios
    servidores = Servidor.select(:id, :nome, :matricula).where(salario_liquido: 0)
    servidores.each do |servidor|
      puts "Buscando dados financeiros, servidor: #{servidor.nome} - matricula: #{servidor.matricula}"
      response = fetch_servidor(matricula: servidor.matricula)

      salario_base = response['dadosFinanceiros'][0]['vencimentos']
      descontos = response['dadosFinanceiros'][0]['descontos']

      Servidor.where(id: servidor.id).update( salario_liquido: salario_base + descontos)
    end
  end

  def fetch_servidores_page(page:)
    response = client.get('/portaltransparencia-api/api/servidores') do |req|
      req.params['situacao'] = 'ATIVO'
      req.params['page'] = page
    end
    JSON.parse(response.body)
  end

  def fetch_servidor(matricula:)
    response = client.get("/portaltransparencia-api/api/servidores/FUNCIONARIO/#{matricula}/0") do |req|
      req.params['situacao'] = 'ATIVO'
    end
    JSON.parse(response.body)
  end

  def client
    Faraday.new(
      url: ENV['OXY_API_URL'],
      params: { size: 50 },
      headers: { 'Content-Type' => 'application/json', 'ENTIDADE': '1', 'EXERCICIO': Time.now.year.to_s }
    )
  end

  def create_servidor!(data)
    Servidor.create!({
                       nome: data['nome'],
                       matricula: data['matricula'],
                       cargo: data['descricaoCargo'],
                       lotacao: data['descricaoLotacao'],
                       vinculo: data['vinculo'],
                       classe: data['descricaoClasse'],
                       data_admissao: data['dataAdmissao']
                     })
  end
end
