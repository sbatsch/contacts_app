class Api::ContactsController < ApplicationController
  def index
    group = params[:group]

    if current_user
      @contacts = current_user.contacts
      render 'index.json.jb'
    elsif group
      group = Group.find_by(name: group)
      @contacts = group.contacts.where(user_id: current_user.id)
      render 'index.json.jb'
    else
      render json: {}
    end 
  end

  def create
    @contact = Contact.new(
                           first_name: params[:first_name],
                           last_name: params[:last_name],
                           middle_name: params[:middle_name],
                           email: params[:email],
                           phone_number: params[:phone_number],
                           bio: params[:bio],
                           user_id: current_user.id
                           )
    if @contact.save
      render 'show.json.jb'
    else 
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end  
  end

  def show
    @contact = Contact.find(params[:id])
    render 'show.json.jb'
  end

  def update
    @contact = Contact.find(params[:id])

    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number
    @contact.bio = params[:bio] || @contact.bio

    if @contact.save
      render 'show.json.jb'
    else 
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end 
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: {message: "Your contact was successfully destroyed."}
  end
end
