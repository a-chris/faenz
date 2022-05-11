class EventsController < ActionController::API
  def create
    attrs = params.permit(:d, :u, :n, :r, :w).to_h.with_indifferent_access
    return render json: { text: 'Missing d, u or n' }, status: :bad_request if (%w[d u n] - attrs.keys).any?

    attrs = {
      domain: attrs[:d],
      url: attrs[:u],
      event: attrs[:n],
      referrer: attrs[:r],
      width: attrs[:w]
    }

    domain = Domain.find_by(base_url: attrs[:domain])
    return render json: { text: 'Domain not found' }, status: :bad_request if domain.nil?

    geo = GeolocationIp.call(ip: request.ip)
    ip = IpDigester.call(ip: request.ip)
    visit_attrs = attrs.except(:domain).merge(time_at: Time.now, domain_id: domain.id, ip: ip, geo: geo)
    Visit.create!(visit_attrs)

    render json: { text: 'ok' }, status: :ok
  rescue StandardError => e
    render json: { text: e.message }, status: :bad_request
  end
end
