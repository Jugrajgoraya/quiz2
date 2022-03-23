require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

    describe "#new" do
        it "should render new template for post" do
            #given
            #when
            get(:new)
            #then
            expect(response).to render_template(:new)
        end
        it "should set an instance variable with a new idea" do
            #given
            #when
            get(:new)
            #then
            expect(assigns(:idea)).to(be_a_new(Idea))            
        end
    end
    describe "#create" do
        context "with valid parameters" do
            it "should save an idea to db" do
                #given
                count_before = Idea.count
                #when
                post(:create, params: {idea: {title: "my idea", description: "this is new idea"}})
                #then
                count_after = Idea.count
                expect(count_after).to(eq(count_before + 1))
            end
            it "should redirect to show page" do
                #given
                #when
                post(:create, params: {idea: {title: "my idea", description: "this is a new idea"}})
                #then
                idea = Idea.last
                expect(response).to(redirect_to(idea_path(idea.id))) 
            end
        end
        context "with invalid parameters" do
            it "should not create a new idea to db" do
                #given
                count_before = Idea.count
                #when
                post(:create, params: {idea: {title: nil, description: "this is new idea"}})
                #then
                count_after = Idea.count
                expect(count_after).to eq(count_before)                
            end
            it "should render the new template" do
                #given
                #when
                post(:create, params: {idea: {title: nil, description: "this is new idea"}})
                #then
                expect(response).to render_template(:new)
            end
        end
    end

end
