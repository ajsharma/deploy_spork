# Capture heroku deploy hook posts
# See https://devcenter.heroku.com/articles/deploy-hooks#customizing-messages
# for more details
class HerokuDeploysController < ApplicationController

  # TODO
  # before_action :verify_incoming_request_is_from_heroku
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    Rails.logger.debug request.inspect

    respond_to do |format|
      format.html do
        HerokuDeployJob.perform_later heroku_deploy_params
        head :created
      end
    end
  end

  private

  def heroku_deploy_params
    params.permit(
      # the app name
      :app,

      # email of the user deploying the app
      :user,

      # the app URL (e.g. http://myapp.heroku.com)
      :url,

      # short identifier of the latest commit
      # (first seven bytes of the SHA1 git object name)
      :head,

      # identifier of the latest commit (SHA1 git object name)
      :head_long,

      # shortened log of commits between this deploy and the last,
      # or the description field for releases triggered via the Platform API
      :git_log,

      # identifier for the release (eg. v7)
      :release,
    )
  end
end
