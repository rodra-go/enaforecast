# ENA Forecast

This project is part of the seminar presented by myself, [Rodrigo Cunha](https://orcid.org/
0000-0002-9374-9568), for the discipline **MAE5871 - Análise Espectral de Séries Temporais**, ministered by Professor [Pedro Morettin](https://www.ime.usp.br/~pam/) and Professor [Chang Chiann](https://www.ime.usp.br/~chang/) at [**Instituto de Matemática e Estatística da Universidade de São Paulo (IME-USP)**](https://www.ime.usp.br/).

This project applies the ideas from the article **Daily streamflow forecasting in Sobradinho Reservoir using machine
learning models coupled with wavelet transform and bootstrapping**, by Saraiva et. al [(2021)](https://www.sciencedirect.com/science/article/abs/pii/S1568494621000041). The article main idea is to use Discrete Wavelet Transform (DWT) to decompose the time series before feeding it to machine learning models while training. The results presented by the authors show an increase on both MLP and SVM models' performance. The purpose of the models is to forecast the daily streamflow in Sobradinho Reservoir.

In this seminar, the objective is to apply DWT for forecasting time series based on an article of choice of each student. Henceforth, an idea similar to the applied in the presented article is applied to forecast the Affluent Natural Energy (or *Energia Afluente Natural*, in portuguese) at the Paraná River basin using MLP models. The data is provided by the **Operador Nacional do Sistema** (ONS), a government agency responsible for the coordination and monitoring of electric power generation and transmission facilities connected to Brazil's national grid.

The data used in this project is available [here](https://dados.ons.org.br/dataset/ena-diario-por-bacia).


## Table of Contents

- [1. Prerequisites](#1-prerequisites)
  * [1.1. Install Docker Engine](#11-install-docker-engine)
  * [1.2. Install Git](#12-install-git)
  * [1.3. Install you favorite code editor](#13-install-you-favorite-code-editor)
- [2. Setup](#2-setup)
  * [2.1. Create a new folder to use](#21-create-a-new-folder-to-use)
  * [2.2. Clone the project from GitHub](#22-clone-the-project-from-github)
- [3. Docker](#3-docker)
  * [3.1. Build Docker Image from Dockerfile](#31-build-docker-image-from-dockerfile)
  * [3.2. Run the Docker container (Linux)](#32-run-the-docker-container-linux)
  * [3.3. Run the Docker container (Windows)](#33-run-the-docker-container-windows)
  * [3.4. Open a bash in the container](#34-open-a-bash-in-the-container)
- [4. Kedro](#4-kedro)
  * [4.1. Check Kedro installation](#41-check-kedro-installation)
  * [4.2. Run Jupyter Server](#42-run-jupyter-server)
  * [4.3. Run Tensorboard Server](#42-run-tensorboard-server)
- [5. Kedro Overview](#5-kedro-overview)

## 1. Prerequisites

### 1.1. Install Docker Engine
Follow the instructions [here](https://docs.docker.com/engine/install/) to install Docker Engine for you OS.


### 1.2. Install Git
Follow the instructions [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) to install Git for you OS.

### 1.3. Install you favorite code editor

Choose the code editor of you preference (PyCharm, Atom, VSCode, etc...) to help you following the tutorial.

## 2. Setup

Open a terminal (for Windows' users, the **Windows Power Shell**) to run the following commands.

### 2.1. Create a new folder to use

Remember to use a valid path in your machine, replacing **/path/to/folder**.
```
mkdir /path/to/folder && cd /path/to/folder
```


### 2.2. Clone the project from GitHub

```
git clone https://github.com/rodra-go/enaforecast.git
```


## 3. Docker

After installing Docker in your machine (see section [2](#2-setup)), open a terminal (for Windows' users, the **Windows Power Shell**)
to run the following commands.

### 3.1. Build Docker Image from Dockerfile

Remember to replace to a valid path in your machine.

<pre><code>
cd /path/to/folder
docker build -t enaforecast .
</code></pre>

### 3.2. Run the Docker container (Linux)

```
docker run --rm --name enaforecast -dit -p 8888:8888 -p 5000:5000 -v $(pwd):/usr/src/code/ enaforecast
```

### 3.3. Run the Docker container (Windows)

Replace the ```$(pwd)``` on the command above for the path to your folder ```/path/to/folder``` in the command below, then run it on Windows Power Shell.

```
docker run --rm --name enaforecast -dit -p 8888:8888 -p 5000:5000 -v C:/path/to/folder:/usr/src/code/ enaforecast
```

### 3.4. Open a bash in the container

```
docker exec -it enaforecast bash
```

## 4. Kedro

After opening a bash in the enaforecast container, run the following commands.

### 4.1. Check Kedro installation

```
kedro info
```


### 4.2. Run Jupyter Server

```
kedro jupyter notebook --ip 0.0.0.0
```

After a while, the command above will print the address for your Jupyter Notebook and the authentication token. You can access the Jupyter Notebook Server with your internet browser, at the local address http://0.0.0.0:8888.

### 4.3. Run Tensorboard Server

It will be necessary to open a new terminal. After doing that, run the following

<pre><code>
cd /path/to/folder
docker exec -it enaforecast bash
tensorboard --logdir . --host 0.0.0.0 --port 5000
</code></pre>

You can access tensorboard with your internet browser, at the local address http://0.0.0.0:5000.


##  5. Kedro Overview

This is your new Kedro project, which was generated using `Kedro 0.16.6`.

Take a look at the [Kedro documentation](https://kedro.readthedocs.io) to get started.

## Rules and guidelines

In order to get the best out of the template:

* Don't remove any lines from the `.gitignore` file we provide
* Make sure your results can be reproduced by following a [data engineering convention](https://kedro.readthedocs.io/en/stable/11_faq/01_faq.html#what-is-data-engineering-convention)
* Don't commit data to your repository
* Don't commit any credentials or your local configuration to your repository. Keep all your credentials and local configuration in `conf/local/`

## How to install dependencies

Declare any dependencies in `src/requirements.txt` for `pip` installation and `src/environment.yml` for `conda` installation.

To install them, run:

```
kedro install
```

## How to run your Kedro pipeline

You can run your Kedro project with:

```
kedro run
```

## How to test your Kedro project

Have a look at the file `src/tests/test_run.py` for instructions on how to write your tests. You can run your tests as follows:

```
kedro test
```

To configure the coverage threshold, go to the `.coveragerc` file.

## Project dependencies

To generate or update the dependency requirements for your project:

```
kedro build-reqs
```

This will copy the contents of `src/requirements.txt` into a new file `src/requirements.in` which will be used as the source for `pip-compile`. You can see the output of the resolution by opening `src/requirements.txt`.

After this, if you'd like to update your project requirements, please update `src/requirements.in` and re-run `kedro build-reqs`.

[Further information about project dependencies](https://kedro.readthedocs.io/en/stable/04_kedro_project_setup/01_dependencies.html#project-specific-dependencies)

## How to work with Kedro and notebooks

> Note: Using `kedro jupyter` or `kedro ipython` to run your notebook provides these variables in scope: `context`, `catalog`, and `startup_error`.
>
> Jupyter, JupyterLab, and IPython are already included in the project requirements by default, so once you have run `kedro install` you will not need to take any extra steps before you use them.

### Jupyter
To use Jupyter notebooks in your Kedro project, you need to install Jupyter:

```
pip install jupyter
```

After installing Jupyter, you can start a local notebook server:

```
kedro jupyter notebook
```

### JupyterLab
To use JupyterLab, you need to install it:

```
pip install jupyterlab
```

You can also start JupyterLab:

```
kedro jupyter lab
```

### IPython
And if you want to run an IPython session:

```
kedro ipython
```

### How to convert notebook cells to nodes in a Kedro project
You can move notebook code over into a Kedro project structure using a mixture of [cell tagging](https://jupyter-notebook.readthedocs.io/en/stable/changelog.html#cell-tags) and Kedro CLI commands.

By adding the `node` tag to a cell and running the command below, the cell's source code will be copied over to a Python file within `src/<package_name>/nodes/`:

```
kedro jupyter convert <filepath_to_my_notebook>
```
> *Note:* The name of the Python file matches the name of the original notebook.

Alternatively, you may want to transform all your notebooks in one go. Run the following command to convert all notebook files found in the project root directory and under any of its sub-folders:

```
kedro jupyter convert --all
```

### How to ignore notebook output cells in `git`
To automatically strip out all output cell contents before committing to `git`, you can run `kedro activate-nbstripout`. This will add a hook in `.git/config` which will run `nbstripout` before anything is committed to `git`.

> *Note:* Your output cells will be retained locally.

## Package your Kedro project

[Further information about building project documentation and packaging your project](https://kedro.readthedocs.io/en/stable/03_tutorial/05_package_a_project.html)
