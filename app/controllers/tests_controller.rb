class TestsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.tests.new(test_params)

    if @test.save
      redirect_to tests_path, notice: t('flash_message.test.create.success')
    else
      render :new
    end
  end

  def show
    @test = Test.find(id)
  end

  def edit
    @test = Test.find(id)
  end

  def update
    @test = Test.find(id)

    if @test.update(test_params)
      redirect_to test_path(@test), notice: t('flash_message.test.update.success')
    else
      render :edit
    end
  end

  def destroy
    @test = Test.find(id)
    @test.destroy

    redirect_to tests_path, notice: t('test.message.destroy.success')
  end

  protected

  def test_params
    params.require(:test).permit(:name, :description, questions_attributes: [
      :id,
      :label,
      :_destroy,
      options_attributes: [:id, :label, :correctness, :_destroy]
    ])
  end
end
