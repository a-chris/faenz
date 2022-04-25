class DemoController < ApplicationController
  DEMO_RELEASE_DATE = Time.new(2022, 4, 23)

  def index
    redirect_to new_user_session_path if ENV['DEMO_MODE'] != 'true'

    @domain = Domain.first
    @start_date = [2.weeks.ago.midnight, DEMO_RELEASE_DATE].max
  end
end
