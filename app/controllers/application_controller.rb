class ApplicationController < ActionController::Base
    before_action :store_user_location!, if: :storable_location?
    private
        # Its important that the location is NOT stored if:
        # - The request method is not GET (non idempotent)
        # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an 
        #    infinite redirect loop.
        # - The request is an Ajax request as this can lead to very unexpected behaviour.
        def storable_location?
        request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
        end

        def store_user_location!
        # :user is the scope we are authenticating
        store_location_for(:user, request.fullpath)
        end

        # This is a devise_guests method that is called when a guest user logs in.
        # It facilitates the transfer of information between the guest_user and the newly created current_user
        # See further documentation for devise_guests: 
        # github.comhttps://github.com/cbeer/devise-guests/cbeer/devise-guests
        def transfer_guest_to_user
            current_user.conversations += guest_user.conversations
        end 
end
