guard :rake, task: 'test', notification: false do
  watch(/^(src|spec)\/(.+)\.coffee$/) do
    `rake test`
  end
end
