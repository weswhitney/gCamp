class TrackerApi

  def initialize
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end

  def projects(token)
    return [] if token.nil?
    response = @conn.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end

    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed.map do |json|
      PivotalProject.new(json[:id], json[:name])
    end
  end

  def stories(token, project_id)
    return [] if token.nil?
    response = @conn.get do |req|
      req.url "/services/v5/projects/#{project_id}/stories"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end

class PivotalProject
  def initialize(id, name)
    @id = id
    @name = name
  end

  def id
    @id
  end

  def name
    @name
  end
end
