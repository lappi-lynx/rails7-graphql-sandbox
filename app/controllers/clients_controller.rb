class ClientsController < ApplicationController
  def index
    @clients = Client.all

    render json: @clients, each_serializer: ClientSimpleSerializer
  end

  def show
    @client = Client.includes(accounts: :assets).find(params[:id])

    render json: @client, serializer: ClientSerializer, currency: params[:currency]
  end
end
