#!/usr/bin/env ruby
# -*- coding : utf-8 -*-

require 'drb/drb'
require 'tempfile'
require 'fileutils'

class SearchServer

  SLEEP_SECOND = 0.05
  def initialize(stream=$stdout)
    @stream = stream
    @queue = []
  end

  def add_search(tmpfile, target, query)
    # 利用する一時ファイル、最終的に設定するファイル、検索クエリを
    # キューに設定する。
    @queue.push([File.expand_path(tmpfile), File.expand_path(target), query])
  end

  def search

    if !@queue.empty?

      tmpfile, target, query = @queue.pop

      qs = query.split " "

      Tempfile.open(File.basename(tmpfile)) do |w|
        open(tmpfile, "r") do |f|
          f.readlines.each {|line|
            w.write(line) if inner_search(qs, line)
          }
        end
        w.close
        FileUtils.cp(w.path, tmpfile)
      end
      Tempfile.open(File.basename(tmpfile)) do |w|
        system "uniq #{tmpfile} | tac > #{w.path}"
        FileUtils.mv w.path, target
      end
      FileUtils.rm tmpfile
    end

    sleep SLEEP_SECOND
  end

  def inner_search(qs, line)
    l = line.encode("UTF-8")
    qs.map{|q| l =~ /#{q}/i}.select {|i| i != nil }.size == qs.size
  end
end

search_server = SearchServer.new

uri = ARGV.shift
DRb.start_service(uri, search_server)

loop { search_server.search }

DRb.thread.join
