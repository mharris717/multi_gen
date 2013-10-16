Dir["/code/orig/auction/**/*widget*"].each do |f|
  puts f
  `rm -rf #{f}`
end