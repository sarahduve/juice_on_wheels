Rails.application.routes.draw do
  namespace :api do
    resources :battery_shifts, only: [:create, :show] do # create a shift; show a shift's status
      resources :vehicle_assignments, only: [:create] # assign a vehicle to a shift
      resources :vehicles, only: [:index, :show] # show all vehicles in a shift; show details for a vehicle in the context of a shift
    end

    resources :battery_shifts, only: [] do
      resources :vehicles, only: [] do
        resource :battery, only: [:update] # update the battery for a vehicle
      end
    end
  end
end

