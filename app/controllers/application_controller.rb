class ApplicationController < ActionController::Base
  before_action :set_default_session_values

  private

  def set_default_session_values
    session[:score] ||= 0
    session[:longest_word] ||= ''
  end
end
