Original README can be found [here](https://github.com/fosslinux/live-bootstrap/blob/master/README.rst)
> "Recipe for a yoghurt: add yoghurt to milk" (c)

## About

This is bootstrapping part of Trusted Bootstrap project. It is based on [live-bootstrap](https://github.com/fosslinux/live-bootstrap). We're using live-bootstrap for building Linux kernel and base binaries (bash, gcc-4, mus-libc, etc.) from minimal binary seeds. These are later used in next phase.

## Build and run

```console
$ ./init.sh
```
To build Image
```console
$ ./build.sh
```
To run built Image in qemu
```console
$ ./run.sh
```

## TODO

- [ ] Build logging
- [ ] Build from scratch without rootfs.py script
- [ ] Build and run customization
- [ ] Remove unused and unnecessary sources and steps in image
- [ ] Strip down Linux kernel build
