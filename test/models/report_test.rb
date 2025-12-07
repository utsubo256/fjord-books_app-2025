# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    target_user = users(:alice)
    report = reports(:alice_report)
    assert report.editable?(target_user)
  end

  test '#created_on' do
    report = reports(:alice_report)
    assert_equal Date.new(2025, 12, 6), report.created_on
  end

  test '#save_mentions' do
    alice_report = reports(:alice_report)
    reports(:bob_report)
    charlie_report = reports(:charlie_report)
    report_mentions(:alice_to_bob)
    report_mentions(:alice_to_charlie)
    assert_difference 'alice_report.mentioning_reports.count', -1 do
      alice_report.update!(content: "http://localhost:3000/reports/#{charlie_report.id}")
    end
  end
end
