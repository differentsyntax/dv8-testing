f = open("ram.txt", "r")
c = 0
arr = []
for x in f:
	x.strip()
	if c > 0:
		if x == "\n" or c % 3 == 0:
			continue
		else:
			mem = x.strip()
			num = int(mem[:len(mem)-1])
			if mem[len(mem)-1] == 'M':
				num = num/1000
			arr.append(num)

	c = c + 1

maxx = 0
for i in range(0, len(arr)):
	if arr[i] > maxx:
		maxx = arr[i]

print(maxx)
