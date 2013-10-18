Refinery::Core::Engine.routes.draw do

  # Frontend routes
  namespace :properties do
    resources :properties, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :properties, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :properties, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
