module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    def handle_error(exception)
      case exception
      when ActiveRecord::RecordNotFound
        Rails.logger.error(exception.message)
        render json: { errors: ["Record not found"] }, status: :not_found
      when ActiveRecord::RecordInvalid
        Rails.logger.error(exception.message)
        render json: { errors: ["Validation failed: #{exception.record.errors.full_messages.join(', ')}"] }, status: :unprocessable_entity
      when ActiveRecord::RecordNotSaved
        Rails.logger.error(exception.message)
        render json: { errors: ["Record not saved: #{exception.record.errors.full_messages.join(', ')}"] }, status: :unprocessable_entity
      when ActiveRecord::RecordNotDestroyed
        Rails.logger.error(exception.message)
        render json: { errors: ["Record could not be deleted: #{exception.record.errors.full_messages.join(', ')}"] }, status: :unprocessable_entity
      else
        Rails.logger.error(exception.message)
        render json: { errors: ["An unexpected error occurred"] }, status: :internal_server_error
      end
    end

    def handle_error_in_development(e)
      logger.error e.message
      logger.error e.backtrace.join("\n")

      render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
    end
  end
end
