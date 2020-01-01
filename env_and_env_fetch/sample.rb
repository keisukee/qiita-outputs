puts ENV["HOGE"]
puts ENV.fetch("HOGE") { "hoge_default" }
