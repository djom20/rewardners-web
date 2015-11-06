module ApplicationHelper

  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    error:   'alert-danger',
    alert:   'alert-warning',
    notice:  'alert-info'
  }

  def current_url(overwrite={})
    url_for(params.merge(overwrite))
  end

  def alert_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG.fetch(flash_type, flash_type.to_s)
  end

  def build_tree_checkboxes object, attribute, items, priorities
    raw "<ul>#{_build_tree_checkboxes object, attribute, items, priorities, ""}</ul>"
  end

  def application_name
    "Rewardners"
  end

  def get_pending_taken_promos_count
    TakenPromo.get_taken_promos_for_user_places(current_user).where(approved_at: nil).count
  end

  def taken_promo_order_label(status)
    case status
    when "approved"
      "success"
    when "rejected"
      "danger"
    when "waiting"
      "info"
    end
  end

  def role_name(user)
    "#{t('titles.role')}: #{user.role_name_formatted}"
  end

  def category_name_I18n
    params[:locale].present? ? "name_#{params[:locale]}" : "name_en"
  end

  def profile_links_validation
    (controller_name == "users" && action_name == "show") || (controller_name == "users" && action_name == "taken_promos") || (controller_name == "registrations" && action_name == "edit") || (controller_name == "redeems" && action_name == "processed") || (controller_name == "places" && action_name == "stars") || (controller_name == "users" && action_name == "favorite_places")
  end


  def place_full_name_or_company(place)
    place["user_name"].present? ? "#{place['user_name']} #{place['user_last_name']}" : "#{place['user_business_name']}"
  end

  private

  def _build_tree_checkboxes object, attribute, items, priorities, cumulative
    items.each do |item|
      unless item.subcategories.empty?
        cumulative <<
          "<li>#{item.name}
            <ul>#{_build_tree_checkboxes(object, attribute, item.subcategories, priorities, "")}</ul>
          </li>"
      else
        obj_id = "#{object}_#{attribute}_#{item.id}"
        obj_name = "#{object}[#{attribute}][]"
        selected = ""
        if !priorities.nil?
          if priorities.kind_of?(Array)
            id = priorities[0].is_a?(Integer) ? item.id : item.id.to_s
            selected = priorities.include?(id) ? "checked" : ""
          else
            selected = priorities.include?(item.id) ? "checked" : ""
          end
        end
        cumulative <<
          "<li>
            <div class=\"checkbox\">
              <label>
                <input type=\"checkbox\" id=\"#{obj_id}\" name=\"#{obj_name}\" value=\"#{item.id}\" #{selected}></input>
                #{item.name}
              </label>
            </div>
          </li>" if item.leaf?
      end
    end
    cumulative
  end

end
