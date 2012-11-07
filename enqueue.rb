require 'iron_worker_ng'

@iw = IronWorkerNG::Client.new

# This is the input required for the worker
payload = {
    sid: "YOUR TWILIO SID",
    token: "YOUR TWILIO TOKEN",
    from: "5555555555", # YOUR TWILIO PHONE NUMBER
    to: "5555555555",
    body: "Hello from IronWorker!"
}
# delay is the number of seconds to wait before running the task, you can change this if you want it to
# run in the future.
delay = 0
task = @iw.tasks.create("twilio", payload, {:delay => delay})

# wait for task to complete and print the log
p @iw.tasks.wait_for(task.id)
puts @iw.tasks.log(task.id)
