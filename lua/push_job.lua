-- KEYS[1]: the job data hash
-- KEYS[2]: the active job list

-- ARGV[1]: the job ID
-- ARGV[2]: the serialized job data

-- Returns: 1 if the job was newly enqueued, 0 if it already exists

-- Set job data in hash
local set = redis.call("hsetnx", KEYS[1], ARGV[1], ARGV[2])
if set == 1 then
  -- If it was set, push the job on to the active list
  redis.call("rpush", KEYS[2], ARGV[1])
  return 1
end

return 0
