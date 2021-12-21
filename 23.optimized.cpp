#include <stdio.h>
#include <string.h>

bool IsPrime(int n)
{
    if (n == 2 || n == 3)
        return true;

    if (n <= 1 || n % 2 == 0 || n % 3 == 0)
        return false;

    for (int i = 5; i * i <= n; i += 6)
    {
        if (n % i == 0 || n % (i + 2) == 0)
            return false;
    }

    return true;
}

int main(int argc, char **argv)
{
    long long a = 0, b = 0, c = 0, d = 0, e = 0, h = 0;

    if (argc > 1 && 0 == strcmp(argv[1], "1"))
        a = 1;

    b = 65;
    c = b;

    if (a != 0) {
        b = b * 100 + 100000;
        c = b + 17000;
    }

    for(; b <= c; b += 17) {
        if (!IsPrime(b)) {
            h += 1;
        }
    }
    printf("%lld\n", h);
    return 0;
}
