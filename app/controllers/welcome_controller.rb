class WelcomeController < ApplicationController
    # GET welcome
    def index
       @active="index" 
    end
    
    def resume
        @active="resume"
    end

end
