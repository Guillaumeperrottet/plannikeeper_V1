class DashboardController < ApplicationController
  before_action :set_current_path
  def dashboard
    @objets = Objet.all
    selected_objet = Objet.find(params[:objet_id]) if params[:objet_id].present?

    # Initialiser les tâches de la semaine et à venir
    @this_week_tasks = selected_objet&.tasks&.this_week || [] # Retourne un tableau vide s'il n'y a rien
    @upcoming_tasks = selected_objet&.tasks&.upcoming || []   # Retourne un tableau vide s'il n'y a rien
  end

  private

  def set_current_path
    @current_path = case request.path
                    when authenticated_root_path
                      "Home"
                    when new_objet_path
                      "Créer un objet"
                    else
                      "Autre"
                    end
  end
end
