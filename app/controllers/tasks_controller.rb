class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @tasks = Task.where(:user_id => current_user.id).order("deadline_at desc").paginate(page: params[:page], per_page: 5)
                 .includes(:tags).includes(:category).includes(:tag_associations)
    @search = params[:search]
    # p "dsaodoiroirewjoirjewuroiwuroiewuroiwruoiewruewoiruwroieureworuo"
    # p @search
    if @search.present?
      @category = @search["category"]
      @tags = @search["tags"]
      @target_name = @search["name"]
      # p "cattttt"
      # p @category
      # p "tagsssss"
      # p @tags
      # p "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      # p Task.where(:category_id => @category)
      # p @category
      # p "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      # p @search["tags"]
      # @tasks = Task.where(:category_id =>  @category, :user_id => current_user.id).order("deadline_at desc").paginate(page: params[:page], per_page: 5)
      # @tasks = Task.by_category(@category).where(:user_id => current_user.id).order("deadline_at desc").paginate(page: params[:page], per_page: 5)
      # p "taskstaskstasks"
      if @target_name != ""
        @tasks = Task.where(:user_id => current_user.id).where('title LIKE :search OR note LIKE :search', search: "%#{@target_name}%")
                     .order("deadline_at desc").paginate(page: params[:page], per_page: 5).includes(:tags).includes(:category).includes(:tag_associations)
      else
        if @category != "" && @tags != ""
          @tasks = Task.by_tags(@tags).by_category(@category).where(:user_id => current_user.id).order("deadline_at desc").paginate(page: params[:page], per_page: 8)
                       .includes(:tags).includes(:category).includes(:tag_associations)
        elsif @category != "" && @tags == ""
          @tasks = Task.by_category(@category).where(:user_id => current_user.id).order("deadline_at desc").paginate(page: params[:page], per_page: 8)
                       .includes(:tags).includes(:category).includes(:tag_associations)
        elsif @category == "" && @tags != ""
          @tasks = Task.by_tags(@tags).where(:user_id => current_user.id).order("deadline_at desc").paginate(page: params[:page], per_page: 8)
                       .includes(:tags).includes(:category).includes(:tag_associations)
        end
      end
      # p @tasks
    end
  end

  # GET /tasks/pending
  def pending
    @tasks = Task.pending.where(:user_id => current_user.id).paginate(page: params[:page], per_page: 5)
                 .includes(:tags).includes(:category).includes(:tag_associations)
    render "index"
  end

  # GET /tasks/completed
  def completed
    @tasks = Task.completed.where(:user_id => current_user.id).paginate(page: params[:page], per_page: 5)
                 .includes(:tags).includes(:category).includes(:tag_associations)
    render "index"
  end

  # def by_category
  #   @category = Category.find(params[:category_id])
  #   @tasks = Task.by_category(@category.id).where(:user_id => current_user.id).paginate(page: params[:page], per_page: 5)
  #   render "index"
  # end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit

  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :note, :is_done, :deadline_at, :category_id, :tag_ids => [])
    end
end
