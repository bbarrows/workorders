class TicketsController < ApplicationController
  include TicketsHelper
  before_action :set_ticket, only: [:csv, :show, :edit, :update, :destroy]
  before_filter :authenticate_user! #, only: [:create, :new, :edit, :update, :destroy, :index, :show]


  def csv
    # http://railscasts.com/episodes/362-exporting-csv-and-excel?view=asciicast
    respond_to do |format|
      format.html
      format.csv { render text: @ticket.to_csv }
    end
    #render text: @work_order.to_csv
  end

  def searchtickets
    start_date_post = params[:start_date]
    end_date_post = params[:end_date]
    @start_date = Date.new start_date_post["year"].to_i, start_date_post["month"].to_i, start_date_post["day"].to_i
    @end_date = Date.new end_date_post["year"].to_i, end_date_post["month"].to_i, end_date_post["day"].to_i
    
    # If admin then get all tickets
    if current_user.id == 1 then
      @tickets = Ticket.where(:date => @start_date..@end_date)
    # Otherwise just get for current user:
    # @ticket.user_id = current_user.id
    else
      @tickets = Ticket.where(:date => @start_date..@end_date, :user_id => current_user.id)
    end
    
    response.headers['Content-Type'] = 'text/csv'
    response.headers['Content-Disposition'] = 'attachment; filename=tickets.csv'
    render text: tickets_to_csv(@tickets)
  end

  def download24hour
    start_date_post = params[:start_date]
    end_date_post = params[:end_date]
    start_str = start_date_post["year"].to_s + '-' + start_date_post["month"].to_s + '-' + start_date_post["day"].to_s
    @start_date = Date.new start_date_post["year"].to_i, start_date_post["month"].to_i, start_date_post["day"].to_i

    if current_user.id == 1 then
      @tickets = Ticket.where(:date => @start_date..@start_date.tomorrow)
    else
      @tickets = Ticket.where(:date => @start_date..@start_date.tomorrow, :user_id => current_user.id)
    end

    response.headers['Content-Type'] = 'text/csv'
    response.headers['Content-Disposition'] = 'attachment; filename=24from' + start_str + '.csv'
    render text: tickets_to_csv(@tickets)
  end


  def all24
    event = params[:date]
    @start_date = Date.new event["year"].to_i, event["month"].to_i, event["day"].to_i
    
    if current_user.id == 1 then
      @tickets = Ticket.where(:date => @start_date..@start_date.tomorrow)
    else
      @tickets = Ticket.where(:date => @start_date..@start_date.tomorrow, :user_id => current_user.id)
    end    
    
  end

  # GET /tickets
  # GET /tickets.json
  def index
    # Show all tickets if admin otherwise just tickets by user
    if current_user.id == 1 then
      @tickets = Ticket.all
    else
      @tickets = Ticket.where(:user_id => current_user.id)
    end
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @entry = Entry.new
    respond_to do |format|
      format.html
      format.csv { render text: @ticket.to_csv }
    end
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  def entry
    @entry = Entry.new(entry_params)
    @ticket = Ticket.find(params[:ticket_id])
    @entry.ticket_id = @ticket.id

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @ticket, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.user_id = current_user.id

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
      @ticket_user = User.find(@ticket.user_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:date, :work_order, :job_code, :quantity, :user_id)
    end
end
