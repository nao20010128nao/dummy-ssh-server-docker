FROM alpine

RUN apk add --no-cache openssh

RUN echo "#!/bin/sh" > /bin/message.sh && \
    echo "echo You're tricked and in a jail. You can't do anything here. Bye!" >> /bin/message.sh && \
    chmod +x /bin/message.sh

RUN adduser -s /bin/message.sh -D lesmi && \
    echo 'lesmi:1234' | chpasswd

RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''

# To prevent from flooding, run upto 10 min
ENTRYPOINT ["timeout","-t","600","/usr/sbin/sshd","-D"]
RUN rm /bin/sh && ln -s /bin/message.sh /bin/bash && ln -s /bin/message.sh /bin/sh && rm /sbin/apk
