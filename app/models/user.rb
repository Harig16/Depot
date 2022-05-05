class User < ApplicationRecord
  after_destroy :ensure_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password

  class Error < StandardError
  end

  private 
    #after_destroy will check the deletion of entry. If count is zero then rollback last transaction and raise expection send message to the controller accessed by rescue_from. Expection is raised useing Error class
    def ensure_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end
end
