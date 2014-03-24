class TestAppointmentsController < ApplicationController
  # GET /test_appointments
  # GET /test_appointments.json
  def index
    @test_appointments = TestAppointment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @test_appointments }
    end
  end

  # GET /test_appointments/1
  # GET /test_appointments/1.json
  def show
    @test_appointment = TestAppointment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test_appointment }
    end
  end

  # GET /test_appointments/new
  # GET /test_appointments/new.json
  def new
    @test_appointment = TestAppointment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @test_appointment }
    end
  end

  # GET /test_appointments/1/edit
  def edit
    @test_appointment = TestAppointment.find(params[:id])
  end

  # POST /test_appointments
  # POST /test_appointments.json
  def create
    @test_appointment = TestAppointment.new(params[:test_appointment])

    respond_to do |format|
      if @test_appointment.save
        format.html { redirect_to @test_appointment, notice: 'Test appointment was successfully created.' }
        format.json { render json: @test_appointment, status: :created, location: @test_appointment }
      else
        format.html { render action: "new" }
        format.json { render json: @test_appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /test_appointments/1
  # PUT /test_appointments/1.json
  def update
    @test_appointment = TestAppointment.find(params[:id])

    respond_to do |format|
      if @test_appointment.update_attributes(params[:test_appointment])
        format.html { redirect_to @test_appointment, notice: 'Test appointment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @test_appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_appointments/1
  # DELETE /test_appointments/1.json
  def destroy
    @test_appointment = TestAppointment.find(params[:id])
    @test_appointment.destroy

    respond_to do |format|
      format.html { redirect_to test_appointments_url }
      format.json { head :no_content }
    end
  end
end
