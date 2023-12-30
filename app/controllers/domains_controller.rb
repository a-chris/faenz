class DomainsController < ApplicationController
  before_action :set_domain, only: %i[show edit update destroy]

  # GET /domains or /domains.json
  def index
    @domains = current_user.domains
  end

  # GET /domains/1 or /domains/1.json
  def show; end

  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # POST /domains or /domains.json
  def create
    @domain = Domain.new(user_id: current_user.id, **domain_params)

    respond_to do |format|
      if @domain.save
        format.html { redirect_to domain_url(@domain), notice: "Domain was successfully created." }
        format.json { render :show, status: :created, location: @domain }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def current_user
      User.first
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_domain
      @domain = Domain.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def domain_params
      params.require(:domain).permit(:base_url, :icon)
    end
end
