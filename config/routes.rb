Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  constraints subdomain: 'api' do
    api_version(:module => "V1", :path => {:value => "v1"}) do
      resources :addresses, except: :create

      resources :products

      resources :customers do
        resource :address
        resources :orders do
          resources :order_lines do
            resource :product
          end
        end
        resources :retours do
          resources :retour_lines do
            resource :product
          end
        end
      end

      resources :deliverers

      resources :orders, except: :create

      resources :order_lines, except: :create

      resources :retours, except: :create

      resources :retour_lines, except: :create
    end
  end
end
