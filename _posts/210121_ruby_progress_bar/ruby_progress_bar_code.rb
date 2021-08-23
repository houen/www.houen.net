def format_time(elapsed_in_sec, show_hours: false)
  elapsed_sec   = elapsed_in_sec % 60
  elapsed_min   = (elapsed_in_sec / 60) % 60
  elapsed_hours = elapsed_in_sec / (60 * 60)
  return format("%02d:%02d:%02d", elapsed_hours, elapsed_min, elapsed_sec) if show_hours

  format("%02d:%02d", elapsed_min, elapsed_sec)
end

current_pct   = 0.0
partial_pct   = false
bar_size      = 50
progress_char = '='
show_hours    = false

# TODO: Time elapsed, time remaining [00:25 of ~ 05:23]

round_val         = partial_pct ? 2 : 0
step_size         = 100.0 / bar_size
spinner_vals      = ['-', '\\', '|', '/']
spinner_vals_size = spinner_vals.size
spinner_num       = 0


t1        = Time.now
iteration = 0
loop do
  iteration += 1

  # Current pct, is pct full
  current_pct = [current_pct, 100].min
  is_pct_full = current_pct >= 100

  # Time elapsed, total, remaining
  elapsed_in_sec       = (Time.now - t1)
  elapsed_sec_per_pct  = current_pct > 0 ? elapsed_in_sec / current_pct : 0
  est_total_in_sec     = 100 * elapsed_sec_per_pct
  est_remaining_in_sec = est_total_in_sec - elapsed_in_sec

  # Build strings
  progress_str        = (current_pct / step_size).to_i.times.map { progress_char }.join
  progress_bar_str    = "%-#{bar_size}.#{bar_size}s" % "#{progress_str}"
  current_spinner_str = is_pct_full ? '|' : spinner_vals[spinner_num]
  current_pct_str     = "%3.3s" % "#{current_pct.to_f.round(round_val)}"
  elapsed_str         = format_time(elapsed_in_sec, show_hours: show_hours)
  total_str           = format_time(est_total_in_sec, show_hours: show_hours)
  remaining_str       = format_time(est_remaining_in_sec, show_hours: show_hours)

  # Build output str
  output_str = "|#{progress_bar_str}#{current_spinner_str} #{current_pct_str}% [#{elapsed_str} of ~ #{total_str} (#{remaining_str})]"

  print output_str + "\r"
  $stdout.flush

  break if is_pct_full

  # Increment spinner
  spinner_num = (spinner_num + 1) % spinner_vals_size
  # Increment pct
  current_pct += rand(100.0) / 10.0
  sleep 0.5
end
