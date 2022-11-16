#!/usr/bin/env bash
set -o pipefail

LINKS=("https://github.com/neoavalon/docker-ros-elg5228_ext/raw/master/lib/tigervnc-1.8.0.x86_64.tar.gz" \
		"https://eecs.uottawa.ca/~wgueaieb/Teaching/tigervnc-1.8.0.x86_64.tar.gz")

echo "Install TigerVNC server"
for LINK_IDX in ${!LINKS[@]}; do
	NEXT_LINK="${LINKS[$LINK_IDX]}"
	wget -q --spider "$NEXT_LINK"
	if [ $? -eq 0 ]; then
		echo "Using mirror $LINK_IDX @ $NEXT_LINK"
		wget -qO- "$NEXT_LINK" | tar -xz --strip 1  -C /
		RES=$?

		if [ $RES -eq 0 ]; then
			echo "OK"
		else
			echo "Mirror $LINK_IDX is down ($NEXT_LINK)"
		fi

		exit $RES
	else
		echo "Mirror $LINK_IDX is down ($NEXT_LINK)"
	fi
done

exit 1

#wget -qO- https://eecs.uottawa.ca/~wgueaieb/Teaching/tigervnc-1.8.0.x86_64.tar.gz | tar -xz --strip 1  -C / 
# wget -qO- https://github.com/TigerVNC/tigervnc/archive/refs/tags/v1.11.0.tar.gz | tar -xz --strip 1  -C / 
# wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.8.0.x86_64.tar.gz | tar -xz --strip 1 -C /
