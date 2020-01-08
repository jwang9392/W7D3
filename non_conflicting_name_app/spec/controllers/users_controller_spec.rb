require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe "GET #index" do
        it "renders the users index" do
            get :index 
            expect(response).to render_template(:index)
        end 
    end

    describe "GET #new" do
        it "renders the users new" do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe "POST #create" do
        it "redirects to the users show if successfuly creates" do
            post :create
            expect(response).to redirect_to(user_url(User.last.id))
        end

        it "renders the users new if fails to create" do
            post :create
            expect(response).to render_template(:new)
        end
    end

    describe "GET #edit" do
        it "renders the users edit" do
            get :edit
            expect(response).to render_template(:edit)
        end
    end
end

