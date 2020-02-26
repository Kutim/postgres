FROM postgres:9.6.17

LABEL maintainer="Kutim <1252900197@qq.com>"

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
  && apt update -y \
  && apt-get install -y locales vim curl rsyslog \
  && sed -ie 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen \
  && sed -ie 's/# cron.*/cron.*/g' /etc/rsyslog.conf \
  && locale-gen 

ENV LANG zh_CN.UTF-8

ENV TZ Asia/Shanghai

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo $TZ > /etc/timezone \
  && dpkg-reconfigure -f noninteractive tzdata


RUN curl -o /var/lib/postgresql/pg_backup.sh https://raw.githubusercontent.com/Kutim/postgres/master/pg_backup.sh -L \
  && echo '0 2 * * * postgres bash /var/lib/postgresql/pg_backup.sh' >> /etc/cron.d/pgbackup \
  && echo '*/1 * * * * postgres date>/var/lib/postgresql/test.txt' >> /etc/cron.d/pgbackup \
  && echo '*/2 * * * * root date>/tmp/test.txt' >> /etc/cron.d/pgbackup

USER postgres

