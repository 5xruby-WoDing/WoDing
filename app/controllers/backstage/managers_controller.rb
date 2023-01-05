# frozen_string_literal: true

module Backstage
  class ManagersController < ApplicationController
    before_action :authenticate_manager!
    layout 'backstage'

    def show
      @restaurants = current_manager.restaurants.includes(:manager, :tags, :opening_times, :reservations, :seats, images_attachments: :blob)
    end
  end
end
