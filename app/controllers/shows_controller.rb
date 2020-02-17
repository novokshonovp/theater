# frozen_string_literal: true

class ShowsController < ApplicationController
  def create
    contract = Contracts::Shows::NewShow.new(create_permited_params)
    contract.validate!

    use_case = Cmd::Shows::CreateShow
    render json: use_case.run!(contract.attributes)
  end

  def index
    use_case = Cmd::Shows::IndexShow
    render json: use_case.run!, each_serializer: ::ShowSerializer
  end

  def destroy
    contract = Contracts::Shows::DeleteShow.new(delete_permited_params)
    contract.validate!

    use_case = Cmd::Shows::DeleteShow
    render json: { id: use_case.run!(contract.attributes) }
  end

  private

  def create_permited_params
    params.permit(:name, :start_date, :end_date).to_h
  end

  def delete_permited_params
    params.permit(:id).to_h
  end
end
