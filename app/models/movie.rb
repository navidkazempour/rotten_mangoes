class Movie < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size
  end


  def self.filter (title, director, runtime_in_minutes)
    movies = Movie.all
    if title.present? || director.present? || runtime_in_minutes.present?
      if runtime_in_minutes == '1'
        lower_range = 0
        upper_range = 90
      elsif runtime_in_minutes == '2'
        upper_range = 120
        lower_range = 90
      elsif runtime_in_minutes == '3'
        lower_range = 120
        upper_range = Movie.maximum("runtime_in_minutes") + 1
      end
      movies = movies.where("title LIKE ? OR director LIKE ? OR runtime_in_minutes BETWEEN ? AND ?" , title, director, lower_range, upper_range)
    end
    movies.limit(50)
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
  
end
