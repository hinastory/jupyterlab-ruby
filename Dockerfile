FROM hero/jupyter-langs:python

RUN apt-get update && apt-get install -y curl vim

RUN conda install -c conda-forge nodejs

# install Ruby
ENV RUBY_VERSION=2.6.5 \
    RUBY_HOME=/opt/ruby
RUN git clone https://github.com/rbenv/ruby-build.git \
    && PREFIX=/usr/local ./ruby-build/install.sh \
    && mkdir -p ${RUBY_HOME} \
    && ruby-build ${RUBY_VERSION} ${RUBY_HOME}/${RUBY_VERSION}
ENV PATH=${RUBY_HOME}/${RUBY_VERSION}/bin:$PATH
RUN gem install --no-document \
                benchmark_driver \
                cztop \
                iruby \
    && iruby register --force

# copy JupyterLab Settings
RUN mkdir -p /root/.jupyter/lab/user-settings
COPY user-settings/ /root/.jupyter/lab/user-settings/

# install favorite jupyter lab extensions
RUN jupyter labextension install @lckr/jupyterlab_variableinspector
RUN jupyter labextension install @jupyterlab/toc
RUN jupyter labextension install @jupyterlab/git
RUN pip install jupyterlab-git
RUN jupyter serverextension enable --py jupyterlab_git
RUN jupyter labextension install jupyterlab-drawio

# for JupyterLab Terminal
ENV SHELL /bin/bash
RUN echo "alias ls='ls --color=auto'" >> /root/.bashrc
RUN echo "export PATH=/root/anaconda3/bin:$PATH" >> /root/.bashrc
RUN echo "export PS1='\u:\W# '" >> /root/.bashrc

# install favorite gems
RUN gem install nokogiri
RUN gem install daru
RUN gem install daru-view
RUN gem install --pre pycall
RUN gem install --pre matplotlib
RUN gem install numpy
RUN gem install pandas
