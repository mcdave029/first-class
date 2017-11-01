class User < ApplicationRecord

  def fullname
    first_name.to_s + " " + last_name.to_s
  end
end
