# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'Password!'
    click_button 'ログイン'
    assert_text 'ログインしました'
  end

  test 'should create report' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
    click_on '日報の新規作成'
    fill_in 'タイトル', with: 'Railsのプラクティスを進めました'
    fill_in '内容', with: 'MVCについて学びました'
    click_on '登録する'
    assert_text '日報が作成されました。'
    assert_text 'Railsのプラクティスを進めました'
    assert_text 'MVCについて学びました'
  end

  test 'should update report' do
    report = reports(:alice_report)
    visit report_url(report)
    assert_selector 'h1', text: '日報の詳細'
    click_on 'この日報を編集'
    fill_in 'タイトル', with: 'Linuxのプラクティスを進めました'
    fill_in '内容', with: 'コマンドについて学びました'
    click_on '更新する'
    assert_text '日報が更新されました'
    assert_text 'Linuxのプラクティスを進めました'
    assert_text 'コマンドについて学びました'
  end

  test 'should destroy report' do
    report = reports(:alice_report)
    visit report_url(report)
    assert_selector 'h1', text: '日報の詳細'
    click_on 'この日報を削除'
    assert_text '日報が削除されました。'
    assert_selector 'h1', text: '日報の一覧'
  end
end
