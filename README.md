# JupyterLab Environment for Ruby

## how to build

```sh
git clone git@github.com:hinastory/jupyterlab-ruby.git
docker build --rm -t hinastory/jupyterlab-ruby .
```

## running

```sh
docker run --rm -p 8888:8888 hinastory/jupyterlab-ruby
```

## Acknowledgement

This repository refers to the following a resource:

- [HeRoMo/jupyter-langs](https://github.com/HeRoMo/jupyter-langs)

## License
MIT
