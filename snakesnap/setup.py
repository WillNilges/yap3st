from setuptools import setup, find_packages
setup(
    name="snakesnap",
    version="0.1",
    packages=['snakesnap'],
    scripts = ['bin/snakesnap.py'],
    install_requires=['cryptoauthlib'],
)
