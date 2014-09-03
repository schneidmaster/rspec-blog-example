class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }

  def preview
    if text.length <= 25
      # Return if the text is already sufficiently short
      text
    else
      # Ensure length will be <= 25 even after '...' is appended
      truncated = text[0..22]

      # Remove characters until a space is found (so we don't break a word)
      while truncated[truncated.length - 1] != ' ' && truncated.length > 0
        truncated = truncated[0..truncated.length - 2]
      end

      # Remove the space
      truncated = truncated[0..truncated.length - 2] if truncated[truncated.length - 1] == ' '

      # Append '...' and return
      truncated + '...'
    end
  end
end
