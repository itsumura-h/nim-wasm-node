FROM nimlang/nim:1.6.4-ubuntu-regular

RUN apt update && \
    apt upgrade -y

RUN apt install -y \
      curl

RUN git clone https://github.com/nodenv/nodenv.git ~/.nodenv
RUN echo 'export PATH="/root/.nodenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(nodenv init -)"' >> ~/.bashrc
ENV PATH $PATH:/root/.nodenv/bin:/root/.nodenv/shims
RUN git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build
RUN nodenv install 16.13.2 && nodenv global 16.13.2
RUN npm install -g yarn

RUN git clone https://github.com/emscripten-core/emsdk.git /root/.emsdk
WORKDIR /root/.emsdk
RUN ./emsdk install latest
RUN ./emsdk activate latest

# シェルからemsdkを読み込む。手動で実行必要？
# source ./emsdk_env.sh

WORKDIR /application
