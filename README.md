# yap3st

This is Yet Another Python3 Snap Tutorial

I hate computers.

This took me 6 hours to get right, so here are, as of June 18, 2020, the steps for getting a simple "hello world" program, written in Python 3, to build and install on your amd64 based computing device.

Inspiration:
- https://forum.snapcraft.io/t/filenotfounderror-while-snapping-python-program/18306
- https://forum.snapcraft.io/t/failed-to-generate-snap-metadata-errors/8955
- https://github.com/nom666nom/numpy-dice-hy

[This page](https://snapcraft.io/docs/python-apps) isn't great. Someone needs to update it.

For this, I'm using Ubuntu 18.04.

### Making an environment

First, you're gonna wanna make a directory and initialize a snap project. We'll be working from this repo folder in my Documents because my comptuer files are about twice as organized as my life. That is to say, a complete mess, and detonating a grenade in the directory would probably _reduce_ the entropy.

```
mkdir ~/Documents/yap3st/snakesnap
cd ~/Documents/yap3st/snakesnap
```

Then, create a snap environment.

```
snapcraft init
```

This command creates a `snapcraft.yaml` which is the beating heart of your snap build environment, well, unless you're making a Python snap, in which case you also need [setup](https://setuptools.readthedocs.io/en/latest/).

Your file tree probably looks like this, assuming you're in `yap3st`.

```
.
├── README.md
└── snakesnap
    └── snap
        └── snapcraft.yaml
```

Groovy, my dude. Alright, grab your favorite text editor and meet me in `snapcraft.yaml`.

### Snapcraft.yaml

I'm just gonna fill this out and leave comments in the file. You can follow along or just copy it.

<details>
<summary>snapcraft.yaml</summary>

```
# Welcome to snapcraft.yaml. The default file isn't too exciting, and there's some comments left in it by the snapcraft devs that you should pay attention to if you actually want to publish your snap.

name: snakesnap # I changed this to match the name of our project.
base: core18 # It's the 20s, so you'll need Core18 to do anything useful.
version: '0.1' # This doesn't matter for now
summary: It's a snap. Whoopie! # Nor does this
description: |
  This is my-snap's description. You have a paragraph or two to tell the
  most important story about your snap. Keep it under 100 words though,
  we live in tweetspace and your description wants to look good in the snap
  store.
  #Nor does the above! It's a description of your snap, you get the point!

# These options have to do with how locked down your snap is. For the time being, to reduce complexity, leave these alone.
grade: devel # must be 'stable' to release into candidate/stable channels
confinement: devmode # use 'strict' once you have the right plugs and slots

# Now for the main show: Parts. They're what make your snap, your snap. We'll need two things in here.
parts:
  snakesnap:
      source: . # This is where you point Snapcraft at your source code. This can point at github links or whatever else, but we want to tell Snapcraft that everything it needs is right here, in this directory.
      plugin: python # Unfortunately, we'll need the `python` plugin to make this work.
      python-version: 'python3' # We're using python3, so we gotta let Snapcraft know that.
      python-packages: # We need one package, setuptools, for later, but I'm also tossing in cryptoauthlib to demonstrate how this works. Basically, if your code needs you to `pip install` something to work, drop whatever that is in this list.
        - cryptoauthlib
        - setuptools

#Here's your app. Basically this'll just run your python script when you call it on the command line after installing the app.
apps:
    snakesnap:
        command: bin/snakesnap.py
```

</details>

### Okay, now for code.

We just want a simple little thing for this. Try this on for size:

```
#!/usr/bin/env python3

def main():
    print("Hello world!")


if __name__ == "__main__":
    main()
```

Throw this script into `bin/snakesnap.py` and `snakesnap/snakesnap.py`. Don't ask me why, Snapcraft is just like that.

Also, run this command: `touch snakesnap/__init__.py`. This'll tell setup that this is a package.

### I'm sorry, "setup?"

Yea dawg, that's how Snapcraft typically builds python packages for some reason. The point is you'll need a `setup.py` that looks like this:

```
from setuptools import setup, find_packages
setup(
    name="snakesnap",
    version="0.1",
    packages=['snakesnap'],
    scripts = ['bin/snakesnap.py'],
    install_requires=['cryptoauthlib'],
)
```

### Is that it?

Shoot, dawg, I think so. Do this:

```
python setup.py bdist_wheel && snapcraft
```

If you see `Snapped snakesnap_0.1_amd64.snap`, do this:

```
sudo snap install snakesnap_0.1_amd64.snap --devmode
```

And then do this a few times to make sure it works:

```
snakesnap
```

You should see something like this:

```
[~/Documents/yap3st/snakesnap] [±master✗]
 $ snakesnap
[~/Documents/yap3st/snakesnap/snakesnap] [±master✗]
$ snakesnap
Hello world!
[~/Documents/yap3st/snakesnap/snakesnap] [±master✗]
$ snakesnap
Hello world!
[~/Documents/yap3st/snakesnap/snakesnap] [±master✗]
$ snakesnap
Hello world!
```

Congrats, you have a snap. Go home.

(To uninstall it do `sudo snap remove snakesnap`).
