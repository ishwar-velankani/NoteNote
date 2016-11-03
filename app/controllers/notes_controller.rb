class NotesController < ApplicationController
	before_action :find_note, only: [:show,:edit,:update,:destroy]
	def index
		#@notes = Note.all.order("created_at DESC")
		#we want to change the index, since it display all the notes
		#we want only current user post only
		@notes= Note.where(user_id: current_user)
	end

	def new
		#@note = Note.new
		#Note.new is replaced as we want to cahnge how the notes are being created
		@note = current_user.notes.build
		#also maeke change in the create function . replace Note.new 
	end

	def create
		@note = current_user.notes.build(note_params)
		if @note.save
			redirect_to @note
		else
			render 'new'
		end

	end

	def show
	end

	def edit 
	end

	def update
		if @note.update(note_params)
			redirect_to @note
		else
			render 'edit'
		end
	end
    
	def destroy
		@note.destroy
		redirect_to notes_path
	end

	private
		def find_note
			@note = Note.find(params[:id])

		end

		def note_params
			params.require(:note).permit(:title,:content)
		end



end
