class EventsController < ApplicationController
  def event
    attrs = params.permit(:domain, :url, :event, :referrer, :width)

    domain_id = Domain.find_or_create_by(base_url: params[:domain]).id
    geo = GeolocationIp.call(ip: request.ip)
    visit_attrs = attrs.except(:domain).merge(domain_id: domain_id, ip: request.ip, geo: geo)
    Visit.create!(visit_attrs)

    render json: { status: 200, text: 'ok' }
  rescue StandardError => e
    render json: { status: 500, text: e.message }
  end
end
