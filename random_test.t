
setfenv(1, require'globals')
local rand = require'random'

local n = 1e8
local seed = 543

local function test_lua(n)
	local t0 = clock()
	math.randomseed(seed)
	local x = 0
	for i=1,n do
		local r = math.random()
		x = x + r
	end
	print('time:', clock() - t0, 'checksum:', x)
end

local terra test_terra(n: int64)
	var t0 = clock()
	rand.randomseed(seed)
	var x = 0.0
	for i=0,n do
		var r = rand.random()
		x = x + r
	end
	print('time:', clock() - t0, 'checksum:', x)
end

test_lua(n)
test_terra(n)
