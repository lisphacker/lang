sizes = [5, 4, 2]
strides = [1, 10, 80]

loc = [0] * len(sizes)
offset = 0

while True:
    print loc, offset

    loc[0] += 1
    offset += strides[0]

    i = 0
    while i < len(sizes) and loc[i] == sizes[i]:
        loc[i] = 0
        offset -= sizes[i] * strides[i]
        i += 1
        if i < len(sizes):
            loc[i] += 1
            offset += strides[i]

    if i == len(sizes):
        break
