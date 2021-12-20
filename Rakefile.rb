# frozen_string_literal: true

task :console do
  exec 'irb -r zspay -I ./lib'
end
