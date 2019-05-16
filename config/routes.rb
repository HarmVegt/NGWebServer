Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :addresses, except: :create

  resources :products

  #link 'customers'

  get 'customers/email', to: 'customers#email'
  get "customers/:customer_id/order_lines", to: 'order_lines#index', as: "customer_order_lines"
  get "customers/:customer_id/products", to: "products#index", as: "customer_products"

  post "customers/:customer_id/retours/bizagi", to: "retours#bizagi", as: "retours_bizagi"

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

  resources :orders, except: :create do
    resources :order_lines
  end

  resources :order_lines, except: :create

  resources :retours, except: :create

  resources :retour_lines, except: :create

#  constraints subdomain: 'api' do
#    api_version(:module => "V1", :path => {:value => "v1"}) do
#
#    end
#  end
end
