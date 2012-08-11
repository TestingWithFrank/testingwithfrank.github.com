Dir.glob('Screen Shot*').each_with_index do |f,i|
  cmd = %Q|convert "#{f}" -crop 279x537+1007+237 example#{i+1}.png|
  puts cmd
  system cmd
end

