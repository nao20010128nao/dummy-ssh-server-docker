FROM alpine


RUN apk add --no-cache openssh
RUN echo "#!/bin/bash" > /usr/bin/message.sh && \
    echo "echo You're tricked and in a jail. You can't do anything here. Bye!" >> /usr/bin/message.sh && \
    chmod +x /bin/message.sh

RUN adduser -s /bin/message.sh lesmi

# To prevent from flooding, run upto 10 min
ENTRYPOINT ["timeout","-t","600","/usr/bin/sshd","-D"]
RUN rm /bin/bash /bin/sh && ln -s /bin/message.sh /bin/bash && ln -s /bin/message.sh /bin/sh && rm /bin/apk
