#!/usr/bin/env python

def esum(n):
    def esum2(mp, n, m):
        if m == 0:
            return 0
        if n == 0:
            return 1
        if n < 0:
            return 0

        if n not in mp:
            mp[n] = []

        try:
            result = mp[n][m]
        except:
            result = esum2(mp, n - m, m) + esum2(mp, n, m - 1)
            while len(mp[n]) < m + 1:
                mp[n].append(None)
            mp[n][m] = result

        return result
    return esum2(dict(), n, n)

for i in [0, 1, 2, 3, 4, 5, 10, 50, 80, 100]:
    print i, esum(i)
