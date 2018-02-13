# TrueRandom
> My own version of true random thing, based on seeding libc rand()-like function using sound data in raw format
## Installation
TrueRandom is really easy to install - just compile randgen.c and use it!
```sh
gcc randgen.c -o randgen.exe
```
or
```sh
gcc randgen.c -o randgen
```
To generate randoms just feed randgen.c with data!
You can feed it with noise, temperature sensor data,
everything!
I'm going to commit data to feed randgen with.
Name of every random seed data pack is:
```sh
[day]-[month]-[year]-[daily #].zip
```
Example:
```sh
9-1-2018-1.zip
```

Just unzip it, every archive is going to contain
30 seconds of amplified mono tracks with 8000 Hz
sample rate, 120 seconds of nearly-silience.

Every tracks's size is approx. *480 KB*. That means,
*you can generate 2400000000 of random numbers*!
That means, *in worst case they can be big as, if redirected
to file, 9 TB of random data*. You can even increase or decrease
randomness by modifying RAND_MAX constant, higher means less random,
lesser means more random, default is 5000. That means, for every 4 bytes
of data in seed file, 5000 of random numbers are generated. That means, for
every long integer in seed file, there are going to be generated 5000 numbers.

## About Authors

Krzysztof Szewczyk – [@KrzysztofSzewczyk](https://github.com/KrzysztofSzewczyk)

Distributed under the MIT license. See ``LICENSE`` for more information.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

If you want to upload your sound samples, please create folder named with your own name.
Please note that sound samples propably isn't subject of copyright law, so every seed
data is released to Public Domain
