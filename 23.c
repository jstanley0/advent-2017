#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
    long long a = 0, b = 0, c = 0, d = 0, e = 0, f = 0, h = 0;

    if (argc > 1 && 0 == strcmp(argv[1], "1"))
        a = 1;

    b = 65;
    c = b;

    if (a != 0) {
        b = b * 100 + 100000;
        c = b + 17000;
    }

    // coming into the loop:
    // b = 106500
    // c = 123500

    for(; b <= c; b += 17) {
        f = 1;
        for(d = 2; d != b; ++d) {
            for(e = 2; e != b; ++e) {
                if (d * e == b) {
                    f = 0;
                }
            }
        }

        if (f == 0) {
            h += 1;
        }

        if (b == c)
            break;
    }
    printf("%lld\n", h);
    return 0;
}
