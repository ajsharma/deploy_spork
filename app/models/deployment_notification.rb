class DeploymentNotification
  def notify
    options = {}
    HTTParty.get "http://www.example.com", options
  end
end
