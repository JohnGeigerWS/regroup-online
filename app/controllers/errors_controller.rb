class ErrorsController < ApplicationController
  def not_found
    render 'errors/not_found', layout: 'application', status: 404
  end
end
