class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactUsMailer.new_message(@contact).deliver
      flash[:notice] = I18n.t('controllers.contacts.create')
      redirect_to new_contact_path
    else
      render :new
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :email, :message_title, :message_body)
    end
end
