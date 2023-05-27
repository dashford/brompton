FROM eclipse-mosquitto:2.0.15

ARG USERNAME
ARG PASSWORD

ENV USERNAME ${USERNAME}
ENV PASSWORD ${PASSWORD}

RUN mosquitto_passwd -c -b /mosquitto/config/passwd "${USERNAME}" "${PASSWORD}"
#RUN mosquitto_passwd -b /mosquitto/config/test second_user second_pass