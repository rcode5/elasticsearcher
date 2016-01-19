require 'rails_helper'

describe AuthorsController do

  # This should return the minimal set of attributes required to create a valid
  # Author. As you add validations to Author, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for :author
  }

  let(:invalid_attributes) {
    {
      name: ''
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AuthorsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #show" do
    it "assigns the requested author as @author" do
      author = Author.create! valid_attributes
      get :show, { id: author.to_param }, valid_session
      expect(assigns(:author)).to eq(author)
    end
  end

  describe "GET #new" do
    it "assigns a new author as @author" do
      get :new, {}, valid_session
      expect(assigns(:author)).to be_a_new(Author)
    end
  end

  describe "GET #edit" do
    it "assigns the requested author as @author" do
      author = Author.create! valid_attributes
      get :edit, { id: author.to_param }, valid_session
      expect(assigns(:author)).to eq(author)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Author" do
        expect {
          post :create, {:author => valid_attributes}, valid_session
        }.to change(Author, :count).by(1)
      end

      it "assigns a newly created author as @author" do
        post :create, {:author => valid_attributes}, valid_session
        expect(assigns(:author)).to be_a(Author)
        expect(assigns(:author)).to be_persisted
      end

      it "redirects to the created author" do
        post :create, {:author => valid_attributes}, valid_session
        expect(response).to redirect_to(Author.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved author as @author" do
        post :create, {:author => invalid_attributes}, valid_session
        expect(assigns(:author)).to be_a_new(Author)
      end

      it "re-renders the 'new' template" do
        post :create, {:author => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for :author
      }

      it "updates the requested author" do
        author = Author.create! valid_attributes
        put :update, { id: author.to_param, :author => new_attributes }, valid_session
        author.reload
        expect(author.name).to eql new_attributes[:name]
        expect(author.hometown).to eql new_attributes[:hometown]
      end

      it "assigns the requested author as @author" do
        author = Author.create! valid_attributes
        put :update, { id: author.to_param, :author => valid_attributes }, valid_session
        expect(assigns(:author)).to eq(author)
      end

      it "redirects to the author" do
        author = Author.create! valid_attributes
        put :update, { id: author.to_param, :author => valid_attributes }, valid_session
        expect(response).to redirect_to(author)
      end
    end

    context "with invalid params" do
      it "assigns the author as @author" do
        author = Author.create! valid_attributes
        put :update, { id: author.to_param, :author => invalid_attributes }, valid_session
        expect(assigns(:author)).to eq(author)
      end

      it "re-renders the 'edit' template" do
        author = Author.create! valid_attributes
        put :update, { id: author.to_param, :author => invalid_attributes }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested author" do
      author = Author.create! valid_attributes
      expect {
        delete :destroy, { id: author.to_param }, valid_session
      }.to change(Author, :count).by(-1)
    end

    it "redirects to the authors list" do
      author = Author.create! valid_attributes
      delete :destroy, { id: author.to_param }, valid_session
      expect(response).to redirect_to(root_path)
    end
  end

end
