class TasksController < ApplicationController
  before_action :require_login
  before_action :set_task, only: [ :show, :edit, :update, :destroy, :complete, :incomplete ]
  before_action :require_task_access, only: [ :show, :edit, :update, :destroy ]

  def index
    @view = params[:view] || "list"
    @tasks = current_user_tasks

    # Filter by status
    case params[:status]
    when "completed"
      @tasks = @tasks.completed
    when "incomplete"
      @tasks = @tasks.incomplete
    when "overdue"
      @tasks = @tasks.overdue
    when "due_today"
      @tasks = @tasks.due_today
    else
      @tasks = @tasks.incomplete
    end

    # Filter by assignee
    if params[:assignee_id].present?
      @tasks = @tasks.assigned_to(User.find(params[:assignee_id]))
    end

    # Filter by priority
    if params[:priority].present?
      @tasks = @tasks.where(priority: params[:priority])
    end

    if @view == "week"
      setup_weekly_view
    else
      setup_list_view
    end

    # Statistics for dashboard
    @stats = {
      total: current_user_tasks.count,
      completed: current_user_tasks.completed.count,
      incomplete: current_user_tasks.incomplete.count,
      overdue: current_user_tasks.overdue.count,
      due_today: current_user_tasks.due_today.count
    }

    @users = User.all.order(:first_name)
  end

  def show
    @related_tasks = current_user_tasks.where.not(id: @task.id).limit(5)
  end

  def new
    @task = Task.new

    # Pre-populate due_date if provided in URL params
    if params[:due_date].present?
      @task.due_date = Date.parse(params[:due_date])
    end

    @users = User.all.order(:first_name)
  end

  def create
    @task = Task.new(task_params)
    @task.created_by = current_user

    if @task.save
      flash[:notice] = t("tasks.task_created")
      redirect_to @task
    else
      @users = User.all.order(:first_name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @users = User.all.order(:first_name)
  end

  def update
    if @task.update(task_params)
      flash[:notice] = t("tasks.task_updated")
      redirect_to @task
    else
      @users = User.all.order(:first_name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    title = @task.title
    @task.destroy!
    flash[:notice] = t("tasks.task_deleted")
    redirect_to tasks_path
  end

  def complete
    @task.complete!

    # Create next occurrence if recurring
    if @task.recurring?
      next_task = @task.create_next_occurrence!
      flash[:notice] = t("tasks.task_completed_recurring", date: next_task.due_date)
    else
      flash[:notice] = t("tasks.task_completed")
    end

    redirect_back(fallback_location: tasks_path)
  end

  def incomplete
    @task.incomplete!
    flash[:notice] = t("tasks.task_incomplete")
    redirect_back(fallback_location: tasks_path)
  end

  private

  def setup_weekly_view
    # Calculate current week
    @current_week = if params[:week].present?
                      Date.parse(params[:week])
    else
                      Date.current.beginning_of_week
    end

    @week_start = @current_week
    @week_end = @current_week.end_of_week
    @prev_week = @week_start - 1.week
    @next_week = @week_start + 1.week

    # Get tasks for the current week
    week_tasks = @tasks.where(due_date: @week_start..@week_end)
                      .includes(:assignee, :created_by)
                      .order(:due_date, :due_time, :priority)

    # Organize tasks by day of week
    @tasks_by_day = {}
    (@week_start..@week_end).each do |date|
      @tasks_by_day[date] = week_tasks.select { |task| task.due_date == date }
    end

    # Also include tasks without due dates in a separate section
    @tasks_without_due_date = @tasks.where(due_date: nil)
                                   .includes(:assignee, :created_by)
                                   .order(:priority, :created_at)
  end

  def setup_list_view
    # Sort
    case params[:sort]
    when "priority"
      @tasks = @tasks.by_priority
    when "due_date"
      @tasks = @tasks.by_due_date
    else
      @tasks = @tasks.recent
    end

    @tasks = @tasks.includes(:assignee, :created_by)
  end

  def set_task
    @task = current_user_tasks.find(params[:id])
  end

  def current_user_tasks
    if current_user.admin?
      Task.all
    else
      Task.where("created_by_id = ? OR assignee_id = ?", current_user.id, current_user.id)
    end
  end

  def require_task_access
    return if current_user.admin?
    return if @task.created_by == current_user || @task.assignee == current_user

    flash[:alert] = t("tasks.no_permission")
    redirect_to tasks_path
  end

  def task_params
    params.require(:task).permit(:title, :description, :assignee_id, :due_date, :due_time,
                                 :priority, :tags, :recurring, :recurrence_type, :recurrence_interval)
  end
end
