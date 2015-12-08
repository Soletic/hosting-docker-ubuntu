FROM ubuntu:trusty
MAINTAINER Sol&TIC <serveur@soletic.org>

ENV LANG fr_FR.UTF-8
ENV LANGUAGE fr_FR
ENV TZ "Europe/Paris"
ENV DEBIAN_FRONTEND noninteractive

# Allow restart/stop service when we upgrade (see http://askubuntu.com/questions/365911/why-the-services-do-not-start-at-installation)
RUN sed -ri -e "s/101/0/" /usr/sbin/policy-rc.d

# Local
RUN apt-get update
RUN locale-gen fr_FR.UTF-8 && export LANG=fr_FR.UTF-8 && DEBIAN_FRONTEND=noninteractive && export DEBIAN_FRONTEND
RUN apt-get install -y supervisor unzip

ADD run.sh /run.sh
RUN chmod u+x /run.sh
ADD ubuntu-setup.conf /etc/supervisor/conf.d/ubuntu-setup.conf

RUN mkdir -p /root/scripts
ADD ubuntu.start.sh /root/scripts/ubuntu.start.sh
RUN chmod u+x /root/scripts/ubuntu.start.sh
COPY crontab /etc/crontab

CMD ["/run.sh", "-D", "FOREGROUND"]