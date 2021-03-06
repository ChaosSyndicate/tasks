files = Dir.glob('**/src/main/res/values/*.xml')
files.each do |path|
    file = File.new(path)
    file.read.scan(/<string name="(.*)">/) do |match|
        result = `git grep R.string.#{match[0]} astrid api` + `git grep string\/#{match[0]} astrid api`
        puts "#{path} - #{match[0]}" if result.empty?
    end
    file = File.new(path)
    file.read.scan(/<string-array name="(.*)">/) do |match|
      result = `git grep R.array.#{match[0]} astrid api` + `git grep array\/#{match[0]} astrid api`
      puts "#{path} - #{match[0]}" if result.empty?
    end
end
file = File.new('astrid/src/main/res/values/attrs.xml')
file.read.scan(/<attr name="(.*)" format=".*"\/>/) do |match|
    result = `git grep R.attr.#{match[0]} astrid api` + `git grep "?attr/#{match[0]}" astrid api`
    puts "#{file.path} - #{match[0]}" if result.empty?
end
