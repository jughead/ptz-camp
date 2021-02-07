# frozen_string_literal: true

module Camps
  class GenerateParticipantsCsvCommand
    def initialize(camp, columns)
      @camp = camp
      @columns = columns || %w[delegation email]
    end

    def execute
      tempfile = Tempfile.new
      CSV.open(tempfile.path, 'w') do |csv|
        csv << csv_header
        data.each do |row|
          csv << row
        end
      end
      tempfile
    rescue StandardError => e
      tempfile.unlink
      raise e
    end

    private

    def csv_header
      @columns.map(&:titleize)
    end

    def data
      query.map do |participant|
        @columns.map do |column|
          column_from_record(participant, column)
        end
      end
    end

    def column_from_record(record, column)
      case column
      when 'delegation'
        record.delegation&.name
      when 'email'
        record.user.email
      when 'last_first_names'
        "#{record.personal.last_name} #{record.personal.first_name}"
      when 'birth_date'
        record.personal.birth_date
      end
    end

    def query
      @camp.participants.order(:delegation_id).ordered_by_last_name.ordered_by_first_name.includes(:delegation, :team, :user)
    end
  end
end
