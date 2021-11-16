Rails.application.routes.draw do
  get 'pages/homepage'
  post "pages/homepage" => "pages#create", :as => :users
  root to: "pages#homepage"
end
