memory_usage = `ps -o rss= -p #{Process.pid}`.to_i # in kilobytes 

# -o rss= asks ps to print only the RSS (Resident Set Size, or physical memory used). You could also use vsz/vsize (virtual memory). The hanging = sign sets the header text to a blank string so you don’t have to filter out the header line.
# 
# -p #{Process.pid} limits the ps to only show the current process.