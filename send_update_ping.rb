# -*- coding: utf-8 -*-
#=  サイト更新 Ping 送信
# ：指定の Ping サーバにサイトの更新 Ping を送信する。
#
# date          name            version
# 2012.12.03    mk-mode.com     1.00 新規作成
#
# Copyright(C) 2012 mk-mode.com All Rights Reserved.
#---------------------------------------------------------------------------------
#++
require 'xmlrpc/client'

SITE_NAME = "hogehoge BLOG"          # 自サイト名称
SITE_URL  = "http://xxxxxxxx/blog/"  # 自サイト URL
# Ping サーバ一覧 ( 以下に送信先を設定する )
PING_SERVERS = [
  "http://api.my.yahoo.co.jp/RPC2",
  "http://blogsearch.google.co.jp/ping/RPC2"
]

# 処理クラス
class Main
  # サイト更新 Ping 送信処理
  def send
    begin
      PING_SERVERS.each do |svr|
        puts "- #{svr}"
        client = XMLRPC::Client.new2(svr)
        begin
          res = client.call("weblogUpdates.ping", SITE_NAME, SITE_URL)
        rescue XMLRPC::FaultException => e
          puts "  [ERROR] #{e.faultCode} - #{e.faultString}"
        rescue Exception => e
          puts "  [ERROR] #{e.class} - #{e.message}"
        end
      end
    rescue => e
      str_msg = "[ERROR][" + self.class.name + ".send] " + e.to_s
      STDERR.puts str_msg
      exit 1
    end
  end
end

################
####  MAIN  ####
################

# 開始メッセージ出力
puts "#### Send Update Ping [ START ]"

# 処理クラスインスタンス化
obj_main = Main.new

# サイト更新 Ping 送信
obj_main.send

# 終了メッセージ出力
puts "#### Send Update Ping [ E N D ]"

