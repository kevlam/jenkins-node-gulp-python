#!/usr/bin/sh

: ${JENKINSUSER:=jenkins}
: ${JENKINSGROUP:=jenkins}

if ! getent group "$JENKINSGROUP" >/dev/null 2>&1; then
    echo "Creating group $JENKINSGROUP"
    addgroup $JENKINSGROUP
fi

if ! id -u "$JENKINSUSER" >/dev/null 2>&1; then
    echo "Creating user $JENKINSUSER"
    adduser -D $JENKINSUSER -s /bin/sh -G $JENKINSGROUP
    chown -R ${JENKINSUSER}:${JENKINSGROUP} /home/$JENKINSUSER
    echo "${JENKINSUSER}:jenkins" | chpasswd
fi