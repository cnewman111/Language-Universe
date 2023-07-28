module PromptsHelper
    def user_can_modify(prompt)
        if prompt.visible_to_all && !current_or_guest_user.is_admin
            return false
        else 
            return true
        end 
      end 
end
