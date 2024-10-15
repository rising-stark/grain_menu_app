module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    def handle_error(exception)
      case exception
      when ActiveRecord::RecordNotFound
        Rails.logger.error(exception.message)
        GraphQL::ExecutionError.new("Record not found")
      else
        Rails.logger.error(exception.message)
        GraphQL::ExecutionError.new("An unexpected error occurred")
      end
    end
  end
end
