f = open("stats.txt", "r")
c = 0
arr = []
for x in f:
	x.strip()
	if c > 2:
		if x == "\n" or c % 26 == 0:
			continue
		else:
			arr.append(round(float(x.strip()), 2))

	c = c + 1

maxx = 0
minn = 1000
sum = 0
for i in range(0, len(arr)):
	if arr[i] > maxx:
		maxx = arr[i]
	if arr[i] < minn:
		minn = arr[i]

	sum += arr[i]

avgg = round(sum/len(arr), 3)
print(minn,maxx,avgg)
