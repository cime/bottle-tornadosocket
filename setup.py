try:
    from setuptools import setup
except:
    from distutils.core import setup

setup(
    name='bottle-tornado-websocket',
    version='0.12',
    author='cime',
    author_email='cime@specialec.net',
    packages=['bottle_tornado_websocket',],
    description='WebSockets for bottle',
    long_description=open('README.md').read(),
    install_requires=['bottle', 'tornado'],
    classifiers=['Operating System :: OS Independent']
)
