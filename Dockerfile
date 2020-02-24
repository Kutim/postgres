FROM postgres:9.6.17

LABEL maintainer="Kutim <1252900197@qq.com>"

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
  && apt update -y \
  && apt-get install -y locales \
  && sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen \
  && locale-gen 

ENV LANG zh_CN.UTF-8

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

USER postgres
