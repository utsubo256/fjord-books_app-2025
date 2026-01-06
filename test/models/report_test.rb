# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable? should be true when given the login user' do
    target_user = users(:alice)
    report = reports(:alice_report)
    assert report.editable?(target_user)
  end

  test '#editable? should be false for non-owner users' do
    target_user = users(:bob)
    report = reports(:alice_report)
    assert_not report.editable?(target_user)
  end

  test '#created_on' do
    report = reports(:alice_report)
    assert_equal Date.new(2025, 12, 6), report.created_on
  end

  test '#save_mentions removes mentions that are no longer in content' do
    alice_report = Report.create!(title: 'テストタイトル', content: 'テスト内容', user: users(:alice))
    alice_report.active_mentions.create!(mentioned: reports(:bob_report))
    assert_difference 'alice_report.mentioning_reports.count', -1 do
      alice_report.update!(content: 'test content')
    end
  end

  test '#save_mentions keeps mentions that still exist in content' do
    alice_report = Report.create!(title: 'テストタイトル', content: 'テスト内容', user: users(:alice))
    alice_report.active_mentions.create!(mentioned: reports(:bob_report))
    assert_difference 'alice_report.mentioning_reports.count', 0 do
      alice_report.update!(content: "http://localhost:3000/reports/#{reports(:bob_report).id}")
    end
  end

  test '#save_mentions adds new mentions from content' do
    alice_report = Report.create!(title: 'テストタイトル', content: 'テスト内容', user: users(:alice))
    assert_difference 'alice_report.mentioning_reports.count', 1 do
      alice_report.update!(content: "http://localhost:3000/reports/#{reports(:bob_report).id}")
    end
  end
end
