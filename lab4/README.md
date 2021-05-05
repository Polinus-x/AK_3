# Lab 4 AK

## To start qemu
```sh
PATH=$PATH:~/opt/xPacks/qemu-arm/2.8.0-7/bin/
make 
make qemu
```


## from another terminal
```sh
PATH=$PATH:~/opt/xPacks/qemu-arm/2.8.0-7/bin/
gdb-multiarch firmware.elf
target extended-remote:1234
layout regs 
```

