class Todo < ApplicationRecord

  belongs_to :user
	after_save :generate_random_number

  validates :title, :due_date, :user_id, presence: {message: "must be given"}
  validate :check_due_date_is_valid, :check_user_id_is_valid, :check_user_id_is_exists, if: :validate_user_id?

	def validate_user_id?
    @validate_user_id != false
  end

  def skip_user_id_validation
    @validate_user_id = false
  end

  def enable_user_id_validation
    @validate_user_id = true
  end

  def self.over_due
    all.where("due_date < ?", Date.today)
  end

  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.due_later
    all.where("due_date > ?", Date.today)
  end

  def self.completed
    all.where(completed: true)
  end

	private
	def generate_random_number
		r = Random.new
		self.rn = r.rand(10...99)
	end

	public
  # validations
	def check_due_date_is_valid
		current_time = Time.now.to_s
    if due_date.present? && due_date.to_s < DateTime.parse(current_time).strftime("%Y-%m-%d")
      errors.add(:due_date, "Invalid due_date")
    end
	end

	def check_user_id_is_valid
		if user_id.to_i <= 0
			errors.add(:user_id, "Invalid user_id")
		end
	end

	def check_user_id_is_exists
		begin
			user = User.find(user_id)
		rescue StandardError => e
			errors.add(:user_id, "User not found")
		end
	end

	# def check_todo_id_is_valid
	# 	begin
	# 		if params[:id] == "" || params[:id] == nil
	# 			raise "todo_id cannot be empty or nil"
	# 		elsif params[:id].to_i <= 0
	# 			raise "Invalid todo_id"
	# 		end
	# 	rescue StandardError => e
	# 		render json: {error: e}, status: 400
	# 	end
	# end

end
