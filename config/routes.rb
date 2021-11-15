Rails.application.routes.draw do
  get 'pages/homepage'
  root to: "pages#homepage"
end
