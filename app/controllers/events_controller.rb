class EventsController < ActionController::API
  def create
    attrs = params.permit(:d, :u, :n, :r, :w)
    if (%i[d u n] - attrs.keys).any?
      return render json: { text: 'Missing d, u or n' }, status: :bad_request
    end

    attrs = {
      domain: attrs[:d],
      url: attrs[:u],
      event: attrs[:n],
      referrer: attrs[:r],
      width: attrs[:w]
    }
    domain_id = Domain.find_or_create_by(base_url: attrs[:domain]).id
    geo = GeolocationIp.call(ip: request.ip)
    visit_attrs = attrs.except(:domain).merge(domain_id: domain_id, ip: request.ip, geo: geo)
    Visit.create!(visit_attrs)

    render json: { text: 'ok' }, status: :ok
  rescue StandardError => e
    render json: { text: e.message }, status: :bad_request
  end
end
