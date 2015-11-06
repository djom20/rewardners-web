module ActivitiesHelper

  def activity_info(activity)
    case activity.trackable_type.downcase
    when "takenpromo"
      taken_promo_information(activity)
    when "place"
      place_information(activity)
    when "redeem"
      redeem_information(activity)
    end
  end

  def taken_promo_information(activity)
    case activity.key
    when "taken_promo.take"
      notification_type = "success"
      message = I18n.t('activity.taken_promo.take')
    when "taken_promo.untake"
      notification_type = "info"
      message = I18n.t('activity.taken_promo.untake')
    when "taken_promo.accept"
      notification_type = "success"
      message = I18n.t('activity.taken_promo.accepted')
    when "taken_promo.reject"
      notification_type = "danger"
      message = I18n.t('activity.taken_promo.rejected')
    end

    if (activity.key == "taken_promo.take") || (activity.key == "taken_promo.untake")
      "<li class='notification__item'>
        <div class='notification-messages #{notification_type}'>
          <div class='message-wrapper'>
            <div class='heading'>
              #{activity.trackable.user_full_name_or_company} #{message}
            </div>
            <div class='description'>
              #{activity.trackable.promo_name.titleize}
            </div>
          </div>
        </div>
      </li>".html_safe
    else
      "<li class='notification__item'>
        <div class='notification-messages #{notification_type}'>
          <div class='message-wrapper'>
            <div class='heading'>
              #{activity.owner.full_name_or_company.titleize}  #{message}
            </div>
            <div class='description'>
              #{activity.trackable.promo_name.titleize}
            </div>
          </div>
        </div>
      </li>".html_safe
    end
  end

  def place_information(activity)
    case activity.key
    when "place.like"
      notification_type = "success"
      message = I18n.t('activity.place.like')
    when "place.unlike"
      notification_type = "info"
      message = I18n.t('activity.place.unlike')
    end
    "<li class='notification__item'>
      <div class='notification-messages #{notification_type}'>
        <div class='message-wrapper'>
          <div class='heading'>
            #{activity.owner.full_name_or_company} #{message}
          </div>
          <div class='description'>
            #{activity.trackable.name.titleize}
          </div>
        </div>
      </div>
    </li>".html_safe
  end

  def redeem_information(activity)
    case activity.key
    when "redeem.create"
      notification_type = "success"
      message = I18n.t('activity.redeem.create')
    end
    "<li class='notification__item'>
      <div class='notification-messages #{notification_type}'>
        <div class='message-wrapper'>
          <div class='heading'>
            #{activity.owner.full_name_or_company} #{message}
          </div>
          <div class='description'>
            #{activity.trackable.number_of_stars} #{I18n.t('activity.redeem.stars')}
          </div>
        </div>
      </div>
    </li>".html_safe
  end

end
