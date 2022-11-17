# Machxir

Mach-O parser written in Elixir.
This implementation refers to [macho](https://github.com/macmade/macho) in C++.


## Usage

```
mix parse -v /path/to/mach-o/file
```
Here, `-v` is flag for slightly better output.  
Output Example:
```
Header
  CPU
    type:    aarch64
    subtype: Generic
  sizeofcmds: 1960
  ncmds:      20
Load Command 0
  cmd:     LC_SEGMENT_64
  cmdsize: 72
    segname:  __PAGEZERO
    vmaddr:   0x0000000000000000
    vmsize:   0x0000000100000000
    fileoff:  0x0000000000000000
    filesize: 0x0000000000000000
    maxprot:  0
    initprot: 0
    nsects:   0
    flags:
      type:       S_REGULAR
      attributes: (none)
Load Command 1
  cmd:     LC_SEGMENT_64
  cmdsize: 552
    segname:  __TEXT
    vmaddr:   0x0000000100000000
    vmsize:   0x0000000000044000
    fileoff:  0x0000000000000000
    filesize: 0x0000000000044000
    maxprot:  5
    initprot: 5
    nsects:   6
    flags:
      type:       S_REGULAR
      attributes: (none)
Load Command 2
  cmd:     LC_SEGMENT_64
  cmdsize: 232
    segname:  __DATA_CONST
    vmaddr:   0x0000000100044000
    vmsize:   0x0000000000004000
    fileoff:  0x0000000000044000
    filesize: 0x0000000000004000
    maxprot:  3
    initprot: 3
    nsects:   2
    flags:
      type:       S_LAZY_DYLIB_SYMBOL_POINTERS
      attributes: (none)
Load Command 3
  cmd:     LC_SEGMENT_64
  cmdsize: 552
    segname:  __DATA
    vmaddr:   0x0000000100048000
    vmsize:   0x0000000000004000
    fileoff:  0x0000000000048000
    filesize: 0x0000000000004000
    maxprot:  3
    initprot: 3
    nsects:   6
    flags:
      type:       S_REGULAR
      attributes: (none)
Load Command 4
  cmd:     LC_SEGMENT_64
  cmdsize: 72
    segname:  __LINKEDIT
    vmaddr:   0x000000010004C000
    vmsize:   0x0000000000034000
    fileoff:  0x000000000004C000
    filesize: 0x00000000000307F8
    maxprot:  1
    initprot: 1
    nsects:   0
    flags:
      type:       S_REGULAR
      attributes: (none)
Load Command 5
  cmd:     LC_DYLID_CHAINED_FIXUPS
  cmdsize: 16
    dataoff:  311296
    datasize: 1944
Load Command 6
  cmd:     LC_DYLID_EXPORTS_TRIE
  cmdsize: 16
    dataoff:  313240
    datasize: 12560
Load Command 7
  cmd:     LC_SYMTAB
  cmdsize: 24
    symoff:  0x0004FC30
    nsyms:   3391
    stroff:  0x0005D310
    strsize: 0x0001E4E0
Load Command 8
  cmd:     LC_DYSYMTAB
  cmdsize: 80
    ilocalsym:      0
    nlocalsym:      3095
    iextdefsym:     3095
    nextdefsym:     202
    iundefsym:      3297
    nundefsym:      94
    tocoff:         0
    ntoc:           0
    modtaboff:      0
    nmodtab:        0
    extrefsymoff:   0
    nextrefsyms:    0
    indirectsymoff: 380960
    nindirectsyms:  187
    extreloff:      0
    nextrel:        0
    locreloff:      0
    nlocrel:        0
Load Command 9
  cmd:     LC_LOAD_DYLINKER
  cmdsize: 32
    name: /usr/lib/dyld (offset 12)
Load Command 10
  cmd:     LC_UUID
  cmdsize: 24
    uuid: FF993A93-C88B-3532-8D6F-7AF46DCE2C50
Load Command 11
  cmd:     LC_BUILD_VERSION
  cmdsize: 32
    minos:    786432
    platform: macOS
    sdk:      787200 
    ntools:   1
        Build tool version 1:
          tool:    ld
          version: 710.1.0
Load Command 12
  cmd:     LC_SOURCE_VERSION
  cmdsize: 16
    version: 0.0.0.0.0
Load Command 13
  cmd:     LC_MAIN
  cmdsize: 24
    entryoff:  8192
    stacksize: 0
Load Command 14
  cmd:     LC_LOAD_DYLIB
  cmdsize: 56
    name:               /usr/lib/libSystem.B.dylib (offset 24)
    timestamp:          1970-01-01 00:00:00.002Z
    current_version:    1311.100.3
    compatible_version: 1.0.0
Load Command 15
  cmd:     LC_LOAD_DYLIB
  cmdsize: 56
    name:               /usr/lib/libresolv.9.dylib (offset 24)
    timestamp:          1970-01-01 00:00:00.002Z
    current_version:    1.0.0
    compatible_version: 1.0.0
Load Command 16
  cmd:     LC_LOAD_DYLIB
  cmdsize: 56
    name:               /usr/lib/libiconv.2.dylib (offset 24)
    timestamp:          1970-01-01 00:00:00.002Z
    current_version:    7.0.0
    compatible_version: 7.0.0
Load Command 17
  cmd:     LC_FUNCTION_STARTS
  cmdsize: 16
    dataoff:  325800
    datasize: 904
Load Command 18
  cmd:     LC_DATA_IN_CODE
  cmdsize: 16
    dataoff:  326704
    datasize: 0
Load Command 19
  cmd:     LC_CODE_SIGNATURE
  cmdsize: 16
    dataoff:  505840
    datasize: 4104
```