# frozen_string_literal: true

class String
  # Checks if a line is commented out or not.
  def commented?
    start_with?("#")
  end

  # Comments a line if it is not already commented out.
  def comment
    commented? ? self : "# #{self}"
  end

  # Uncomments a line if it is commented out.
  def uncomment
    gsub(/^#\s*/, "")
  end

  # Removes whitespace from the beginning of the String.
  def strip_beginning
    gsub(/^\s*/, "")
  end
end
