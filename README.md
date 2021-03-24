# BorgBox
A simple, secure [BorgBackup](https://borgbackup.readthedocs.io/en/stable/) repository, wrapped in a lightweight Alpine Linux Docker container.

To run `borgbox`, you can use the following `docker-compose.yml` file.
```yaml
---
version: "3.8"

services:
  borgbox:
    image: ghcr.io/dmptrluke/borgbox:latest
    container_name: borgbox
    restart: always
    ports:
      - "2222:2222"
    volumes:
      - ./config:/config
      - ./data:/data
      - hostkeys:/hostkeys

volumes:
  hostkeys:
```

## Configuration 
BorgBox is configured by mounting a folder of named public keys into the container at `/config`. You will also need to mount a folder at `/data` for the backups to be stored.


## License

This software is released under the MIT license.
```
Copyright (c) 2020-2021 Luke Rogers

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
