class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:all, :create, :new, :edit, :update, :destroy, :index, :show]

  def all
    @entries = Entry.joins(:ticket).where('tickets.user_id' => current_user.id)
  end

  # GET /entries
  # GET /entries.json
  def index
    @ticket = Ticket.find(params[:ticket_id])
    @entries = @ticket.entries
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @ticket = Ticket.find(params[:ticket_id])
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @ticket = Ticket.find(params[:ticket_id])
    @entry = Entry.new(entry_params)
    @entry.ticket_id = @ticket.id

    respond_to do |format|
      if @entry.any_overylap?
        format.html { render :new, notice: 'Entry overlapped with existing entry.' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      elsif @entry.save
        format.html { redirect_to @ticket, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @ticket, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to @ticket, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @ticket = Ticket.find(params[:ticket_id]) #params[:ticket_id] ? Ticket.find(params[:ticket_id]) : nil
      @entry = Entry.find(params[:entry_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:start, :end, :ticket_id)
    end
end
