class ContactsController < ApplicationController

  before_action :contact, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    @contacts = current_user.contacts
  end

  def new
    @contact = Contact.new
  end

  def create
    current_user.contacts.create(contact_params)
    redirect_to '/contacts'
  end

  def show
  end

  def edit
  end

  def update
    @contact.update(contact_params)
    redirect_to '/contacts/' + "#{@contact[:id]}"
  end


  def destroy
    @contact.destroy
    redirect_to '/contacts'
  end

  private

  def contact_params
    params.require(:contact).permit(:firstname, :surname, :email, :phone, :image)
  end

  def contact
    @contact = Contact.find(params[:id])
  end


end
