# frozen_string_literal: true

module Backstage
  class ManagersController < ApplicationController
    before_action :authenticate_manager!
    layout 'backstage'

    def show
      @restaurants = Restaurant.includes(:manager, :tags, :opening_times, :reservations, :seats,
                                         images_attachments: :blob).where(manager_id: current_manager.id).references(:manager)
    end
  end
end
