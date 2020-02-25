FROM postgres:9.6.17

LABEL maintainer="Kutim <1252900197@qq.com>"

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
  && apt update -y \
  && apt-get install -y locales vim curl\
  && sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen \
  && locale-gen 

ENV LANG zh_CN.UTF-8

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV TZ Asia/Shanghai

RUN curl -o /var/lib/postgresql/pg_backup.sh https://github.com/Kutim/postgres/blob/master/pg_backup.sh -L \
  && echo ‘0 2 * * * posetgres bash /var/lib/postgresql/pg_backup.sh’ \
  && service cron restart & 

USER postgres

