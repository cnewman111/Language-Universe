module PromptsHelper
    def user_can_modify(prompt, user)
        if prompt.visible_to_all && !user.is_admin
            return false
        else 
            return true
        end 
      end 
end
