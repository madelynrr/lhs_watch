class AnimalsController < ApplicationController
    before_action :set_animal, only: %i[ show edit update destroy ]

    # GET /animals or /animals.json
    def index
        @animals = Animal.all.order(:name)
    end

    # GET /animals/1 or /animals/1.json
    def show
    end

    # GET /animals/new
    def new
        @animal = Animal.new
    end

    # GET /animals/1/edit
    def edit
    end

    # POST /animals or /animals.json
    def create
        @animal = Animal.new(animal_params)

        respond_to do |format|
        if @animal.save
            format.html { redirect_to @animal, notice: "Animal was successfully created." }
            format.json { render :show, status: :created, location: @animal }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @animal.errors, status: :unprocessable_entity }
        end
        end
    end

    # PATCH/PUT /animals/1 or /animals/1.json
    def update
        respond_to do |format|
            if @animal.update(animal_params)
                format.html { redirect_back(fallback_location: @animal, notice: "Animal was successfully updated.", status: :see_other) }
                format.json { render :show, status: :ok, location: @animal }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @animal.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /animals/1 or /animals/1.json
    def destroy
        @animal.destroy!

        respond_to do |format|
        format.html { redirect_to animals_path, notice: "Animal was successfully destroyed.", status: :see_other }
        format.json { head :no_content }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_animal
        @animal = Animal.find(params.expect(:id))
        end

        # Only allow a list of trusted parameters through.
        def animal_params
        params.expect(animal: [ :name, :shelter_id, :species, :sex, :age, :status, :favorite ])
        end
end
